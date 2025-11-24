import { Injectable, Logger } from '@nestjs/common';
import { exec } from 'child_process';
import { promisify } from 'util';
const execAsync = promisify(exec);

@Injectable()
export class MediaService {
  private readonly logger = new Logger(MediaService.name);

  async transcode(inputPath: string, outputPath: string) {
    // placeholder: calls ffmpeg from PATH inside host or container
    const cmd = `ffmpeg -y -i "${inputPath}" -c:v libx264 -preset veryfast "${outputPath}"`;
    this.logger.log(`Transcode command: ${cmd}`);
    const { stdout, stderr } = await execAsync(cmd);
    this.logger.debug(stdout || stderr);
    return { ok: true };
  }
}
