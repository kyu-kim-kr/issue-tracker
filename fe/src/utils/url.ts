import { ParsedQs } from 'qs';

export const getUrl = {
  LOGIN: (code: string | ParsedQs | string[] | ParsedQs[] | undefined) =>
    `/api/login/auth?client=web&code=${code}`,
};