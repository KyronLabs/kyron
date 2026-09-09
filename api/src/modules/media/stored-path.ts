/**
 * Turns a stored clip's public URL back into the path it lives at.
 *
 * The Media table keeps a URL; the re-encode queue is keyed by storage path.
 * Everything uploaded through SupabaseService has the shape
 *
 *   https://<project>.supabase.co/storage/v1/object/public/<bucket>/<path>
 *
 * and the path is what comes after the bucket.
 *
 * Separate and pure so it can be tested against the URLs that are actually in
 * the table. It is deliberately strict: anything it does not recognise gets
 * null rather than a guess. A guessed path is a job whose download fails --
 * and, worse, a path is also where a re-encode is written back, so a wrong one
 * is a write aimed at the wrong object.
 */
export function storedPathFromUrl(
  url: string,
  bucket: string,
): { path: string } | { refused: string } {
  let parsed: URL;
  try {
    parsed = new URL(url);
  } catch {
    return { refused: 'not a URL' };
  }

  if (parsed.protocol !== 'https:') {
    return { refused: `not https (${parsed.protocol})` };
  }

  // Signed and public URLs differ only in this segment, and a signed one still
  // names the same object.
  const marker = /\/storage\/v1\/object\/(?:public|sign|authenticated)\//;
  const match = marker.exec(parsed.pathname);
  if (!match) return { refused: 'not a Supabase storage URL' };

  const after = parsed.pathname.slice(match.index + match[0].length);
  const prefix = `${bucket}/`;
  if (!after.startsWith(prefix)) {
    // Another bucket entirely. Re-encoding into it is not this job's business.
    const other = after.split('/')[0];
    return { refused: `in bucket ${other || '(none)'}, not ${bucket}` };
  }

  // Percent-encoding survives the round trip through a URL, and the storage
  // API wants the decoded name -- a clip called "my clip.mp4" is stored under
  // a space, not under %20.
  let path: string;
  try {
    path = decodeURIComponent(after.slice(prefix.length));
  } catch {
    return { refused: 'path is not decodable' };
  }

  if (path.length === 0) return { refused: 'no path after the bucket' };
  // A traversal in stored data would aim a write outside the prefix it came
  // from. Nothing legitimate produces one.
  if (path.split('/').some((part) => part === '..' || part === '.')) {
    return { refused: 'path walks outside itself' };
  }
  return { path };
}
