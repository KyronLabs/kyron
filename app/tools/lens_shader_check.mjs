// Runs the Android lens-video shader in a browser, against real jobs.
//
// LensVideo.kt's shader is GLSL ES 1.00, which is what WebGL 1 runs, so the
// exact source can be checked here without a phone: compiled, drawn over a
// test frame with the masks and drawings the Dart side made, and the pixels
// read back.
//
// What it reproduces of the phone, and so what it can and cannot prove:
//   - Media3 frames have their origin at the bottom left: the test frame is
//     uploaded flipped, so its top is at t = 1.
//   - Android uploads a bitmap with its first row at t = 0, premultiplied:
//     the masks and drawings are uploaded unflipped and premultiplied.
//   - The colour and wash matrices are packed as LensShaderProgram.split
//     packs them (ported below -- keep the two in step).
// It does not prove Media3 calls the program as assumed, or anything about
// the encoder. Those need a phone.
//
// Usage (from app/):
//   flutter test test/lens_video_test.dart --dart-define=lensJob=/tmp/lensjob
//   node tools/lens_shader_check.mjs /tmp/lensjob
import fs from 'node:fs';
import path from 'node:path';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
const { chromium } = require('playwright');

const dir = process.argv[2];
if (!dir) {
  console.error('usage: node tools/lens_shader_check.mjs <job directory>');
  process.exit(2);
}

const kotlin = fs.readFileSync(
  new URL('../android/app/src/main/kotlin/so/kyron/app/LensVideo.kt', import.meta.url),
  'utf8',
);
const shader = (name) => kotlin.match(new RegExp(`const val ${name} = """([\\s\\S]*?)"""`))[1];
const VERTEX = shader('VERTEX');
const FRAGMENT = shader('FRAGMENT');

// LensShaderProgram.split, ported.
function split(m) {
  const mat = new Array(16).fill(0);
  for (let row = 0; row < 4; row++) for (let col = 0; col < 4; col++) mat[col * 4 + row] = m[row * 5 + col];
  return [mat, [m[4] / 255, m[9] / 255, m[14] / 255, 0]];
}
const IDENTITY = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];

const dataUrl = (file) => `data:image/png;base64,${fs.readFileSync(file).toString('base64')}`;

const browser = await chromium.launch();
const page = await browser.newPage();
let failures = 0;
const expect = (ok, what) => {
  console.log(`${ok ? 'ok  ' : 'FAIL'} ${what}`);
  if (!ok) failures++;
};

async function run(name, atUs) {
  const job = JSON.parse(fs.readFileSync(path.join(dir, `${name}.json`), 'utf8'));
  const current = (list) => {
    let found = null;
    for (const e of list) if (e.at <= atUs) found = e;
    return found ? dataUrl(found.path) : null;
  };
  const [colour, colourOffset] = split(job.matrix ?? IDENTITY);
  const [wash, washOffset] = split(job.wash ?? IDENTITY);

  return page.evaluate(
    async ({ VERTEX, FRAGMENT, mask, art, colour, colourOffset, wash, washOffset, blur }) => {
      const W = 820, H = 1024;
      // The test frame: orange left, blue right, a green block top left so a
      // flip anywhere shows, and a white band across the bottom.
      const src = document.createElement('canvas');
      src.width = W; src.height = H;
      const c = src.getContext('2d');
      c.fillStyle = '#e08030'; c.fillRect(0, 0, W / 2, H);
      c.fillStyle = '#3060e0'; c.fillRect(W / 2, 0, W / 2, H);
      c.fillStyle = '#20c040'; c.fillRect(0, 0, 120, 120);
      c.fillStyle = '#ffffff'; c.fillRect(0, H - 60, W, 60);

      const out = document.createElement('canvas');
      out.width = W; out.height = H;
      const gl = out.getContext('webgl', { preserveDrawingBuffer: true, premultipliedAlpha: false });

      const compile = (type, source) => {
        const s = gl.createShader(type);
        gl.shaderSource(s, source);
        gl.compileShader(s);
        if (!gl.getShaderParameter(s, gl.COMPILE_STATUS)) throw new Error(gl.getShaderInfoLog(s));
        return s;
      };
      const program = gl.createProgram();
      gl.attachShader(program, compile(gl.VERTEX_SHADER, VERTEX));
      gl.attachShader(program, compile(gl.FRAGMENT_SHADER, FRAGMENT));
      gl.linkProgram(program);
      if (!gl.getProgramParameter(program, gl.LINK_STATUS)) throw new Error(gl.getProgramInfoLog(program));
      gl.useProgram(program);

      // GlUtil.getNormalizedCoordinateBounds: a strip over -1..1, homogeneous.
      const buffer = gl.createBuffer();
      gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
      gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([
        -1, -1, 0, 1, 1, -1, 0, 1, -1, 1, 0, 1, 1, 1, 0, 1,
      ]), gl.STATIC_DRAW);
      const loc = gl.getAttribLocation(program, 'aFramePosition');
      gl.enableVertexAttribArray(loc);
      gl.vertexAttribPointer(loc, 4, gl.FLOAT, false, 0, 0);

      const load = (url) => new Promise((ok, fail) => {
        const i = new Image(); i.onload = () => ok(i); i.onerror = fail; i.src = url;
      });
      const texture = (unit, source, { flip, premultiply }) => {
        const t = gl.createTexture();
        gl.activeTexture(gl.TEXTURE0 + unit);
        gl.bindTexture(gl.TEXTURE_2D, t);
        gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, flip);
        gl.pixelStorei(gl.UNPACK_PREMULTIPLY_ALPHA_WEBGL, premultiply);
        gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, source);
        for (const [k, v] of [
          [gl.TEXTURE_MIN_FILTER, gl.LINEAR], [gl.TEXTURE_MAG_FILTER, gl.LINEAR],
          [gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE], [gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE],
        ]) gl.texParameteri(gl.TEXTURE_2D, k, v);
      };
      const u = (n) => gl.getUniformLocation(program, n);

      // Media3 frame: origin bottom left.
      texture(0, src, { flip: true, premultiply: false });
      gl.uniform1i(u('uTexSampler'), 0);
      // Android bitmaps: first row at t = 0, premultiplied.
      if (mask) texture(1, await load(mask), { flip: false, premultiply: true });
      if (art) texture(2, await load(art), { flip: false, premultiply: true });
      gl.uniform1i(u('uMask'), mask ? 1 : 0);
      gl.uniform1i(u('uArt'), art ? 2 : 0);
      gl.uniformMatrix4fv(u('uColour'), false, colour);
      gl.uniform4fv(u('uColourOffset'), colourOffset);
      gl.uniformMatrix4fv(u('uWash'), false, wash);
      gl.uniform4fv(u('uWashOffset'), washOffset);
      gl.uniform1f(u('uBlur'), blur * 2.5);
      gl.uniform1f(u('uAspect'), W / H);
      gl.uniform1f(u('uUseMask'), mask && blur > 0 ? 1 : 0);
      gl.uniform1f(u('uUseArt'), art ? 1 : 0);

      gl.viewport(0, 0, W, H);
      gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);

      // Read back upright, as the encoder would see it.
      return { png: out.toDataURL('image/png') };
    },
    { VERTEX, FRAGMENT, mask: current(job.masks), art: current(job.overlays),
      colour, colourOffset, wash, washOffset, blur: job.blur },
  );
}

// Pixels are read off the rendered PNG in a second, plain 2D canvas.
async function render(name, atUs, points) {
  const result = await run(name, atUs);
  fs.writeFileSync(path.join(dir, `${name}-shader.png`), Buffer.from(result.png.split(',')[1], 'base64'));
  return page.evaluate(async ({ png, points }) => {
    const img = await new Promise((ok) => { const i = new Image(); i.onload = () => ok(i); i.src = png; });
    const c = document.createElement('canvas'); c.width = img.width; c.height = img.height;
    const x = c.getContext('2d'); x.drawImage(img, 0, 0);
    return points.map(([px, py]) => Array.from(x.getImageData(px, py, 1, 1).data));
  }, { png: result.png, points });
}

const face = JSON.parse(fs.readFileSync(new URL('../test/face-detection.json', import.meta.url), 'utf8'));
const W = 820, H = 1024;
const leftIris = face.landmarks[468];
const eye = [Math.round(leftIris[0] * W), Math.round(leftIris[1] * H)];
const luma = ([r, g, b]) => 0.2126 * r + 0.7152 * g + 0.0722 * b;

{
  // Specs: the tinted lens lands on the eye, the frame is not flipped, and
  // away from the face nothing changed.
  const [atEye, corner, belowLeft] = await render('specs', 100000, [eye, [60, 60], [100, 700]]);
  expect(luma(atEye) < 0.6 * luma([224, 128, 48]), `specs: eye darkened by the lens (${atEye})`);
  expect(corner[1] > 150 && corner[0] < 80, `specs: green block still top left (${corner})`);
  expect(Math.abs(belowLeft[0] - 224) < 6, `specs: cheek untouched (${belowLeft})`);
}
{
  // Frost: the seam between orange and blue, away from the eyes, smears;
  // near the eye it stays sharp; the wash lifts towards white.
  const seamY = 900;
  const [l, r, el, er, lifted] = await render('frosted', 100000, [
    [400, seamY], [420, seamY], [404, eye[1]], [416, eye[1]], [100, 900],
  ]);
  expect(Math.abs(l[0] - r[0]) < 0.6 * (224 - 48), `frost: seam smeared (${l} | ${r})`);
  expect(Math.abs(el[0] - er[0]) > 0.8 * (224 - 48), `frost: seam sharp at the eyes (${el} | ${er})`);
  expect(luma(lifted) > luma([224, 128, 48]) + 5, `frost: lifted (${lifted})`);
}
{
  const [p] = await render('mono', 0, [[100, 500]]);
  expect(Math.abs(p[0] - p[1]) < 3 && Math.abs(p[1] - p[2]) < 3, `mono: grey (${p})`);
  const expected = 0.2126 * 224 + 0.7152 * 128 + 0.0722 * 48;
  expect(Math.abs(p[0] - expected) < 3, `mono: the same grey Flutter makes (${p[0]} vs ${expected.toFixed(1)})`);
}

await browser.close();
console.log(failures ? `${failures} failed` : 'all passed');
process.exit(failures ? 1 : 0);
