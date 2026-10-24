import type { Copy } from './en';
import { en } from './en';

/** Every language a push can be said in, by the code the app uses. */
export const CATALOGS: Readonly<Record<string, Copy>> = {
  en,
};
