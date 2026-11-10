import {
  registerDecorator,
  ValidationArguments,
  ValidationOptions,
} from 'class-validator';

import { storedPathFromUrl } from '../modules/media/stored-path';

/**
 * Whether [url] is an object in this deployment's public bucket.
 *
 * A post, a message, a cover and a community's pictures all carry a URL the
 * client supplies after uploading. Stored as written and served to every
 * reader, a URL anywhere else lets whoever wrote it choose the server each
 * reader's phone fetches from: they learn every reader's address, and can
 * change the picture after moderation has looked at it. Everything the app
 * attaches, GIFs included, is uploaded first, so nothing legitimate lives
 * anywhere else.
 */
export function isStoredMediaUrl(url: unknown): boolean {
  if (typeof url !== 'string' || url.length > 2048) return false;
  const bucket = process.env.SUPABASE_BUCKET_NAME || 'kyron-media';
  if ('refused' in storedPathFromUrl(url, bucket)) return false;
  // `/object/public/` only: a signed URL names the same object but expires,
  // and nothing stores one.
  if (!new URL(url).pathname.includes('/storage/v1/object/public/')) {
    return false;
  }

  const project = process.env.SUPABASE_URL;
  if (!project) {
    // Nothing to compare the host with (a spec, or a machine with no storage
    // configured, where no upload could have happened either). The shape has
    // been checked; production always has the project set, or uploads fail.
    return true;
  }
  try {
    return new URL(url).host === new URL(project).host;
  } catch {
    return false;
  }
}

/** A URL under this deployment's public storage bucket, and nowhere else. */
export function IsStoredMediaUrl(options?: ValidationOptions) {
  return (target: object, propertyName: string) => {
    registerDecorator({
      name: 'isStoredMediaUrl',
      target: target.constructor,
      propertyName,
      options,
      validator: {
        validate: (value: unknown) => isStoredMediaUrl(value),
        defaultMessage: (args: ValidationArguments) =>
          `${args.property} must be a file uploaded to Kyron.`,
      },
    });
  };
}
