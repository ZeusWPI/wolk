export type User = {
  name: string;
  admin: boolean;
}

export type Album = {
  id: number;
  name: string;
}

export type Kiekje = {
  id: number;
  uplaoded_by: string;
  url: string;
  thumbnail_url: string;
}

export type Upload = {
  file: File,
  status: UploadStatus;
  progress?: number;
  albumId?: number;
  error?: unknown;
}

export type UploadStatus = "idling" | "uploading" | "uploaded" | "failed"
