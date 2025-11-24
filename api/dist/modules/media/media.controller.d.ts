import { MediaService } from './media.service';
export declare class MediaController {
    private readonly svc;
    constructor(svc: MediaService);
    transcode(body: {
        input: string;
        output: string;
    }): Promise<{
        ok: boolean;
    }>;
}
