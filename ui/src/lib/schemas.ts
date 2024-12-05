import { z } from "zod";

export const albumSchema = z.object({
  name: z.string(),
})

export type AlbumSchema = typeof albumSchema
