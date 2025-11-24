export declare class MediaService {
    private readonly logger;
    transcode(inputPath: string, outputPath: string): Promise<{
        ok: boolean;
    }>;
}
