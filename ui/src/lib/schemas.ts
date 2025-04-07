import { z } from "zod";

export const albumSchema = z.object({
  name: z.string(),
})

export type AlbumSchema = typeof albumSchema

export const existingAlbumSchema = z.object({
  name: z.string(),
  files: typeof window === 'undefined' ? z.any() : z.instanceof(FileList)
})

export type ExistingAlbumSchema = typeof existingAlbumSchema
