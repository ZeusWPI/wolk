import type { Upload } from "$lib/types";
import { toast } from "svelte-sonner";

let fileUploads = $state<Upload[]>([])
let uploadsProcessing = $state(false);

export const getFileUploads = () => fileUploads;

export const addFileUpload = (file: File, albumId?: number) => {
  fileUploads.push({
    file: file,
    status: 'idling',
    albumId
  });
}

export const processUploads = async () => {
  if (uploadsProcessing) return;
  uploadsProcessing = true;
  for (let i = 0; i < fileUploads.length; i++) {
    const upload = fileUploads[i];
    try {
      upload.status = "uploading"
      await uploadKiekje(upload.file, upload.albumId);
      upload.status = "uploaded"
    } catch (err) {
      upload.status = "failed"
      upload.error = err;
    }
  }
}

export const uploadKiekje = async (imageFile: File, albumId?: number) => {
  const formData = new FormData();
  formData.append('image', imageFile);
  const resp = await fetch('/api/kiekje', {
    method: 'POST',
    body: formData
  });

  if (!resp.ok) {
    throw new Error('Failed to upload image');
  }

  const kiekje = await resp.json();
  if (!albumId) {
    return kiekje;
  }

  const albumResp = await fetch(`/api/albums/${albumId}/add/${kiekje.data.id}`, {
    method: 'POST'
  });

  if (!albumResp.ok) {
    throw new Error('Failed to link image to album');
  }
  return kiekje;
}

export const cleanupUploads = () => {
  if (uploadsProcessing) {
    toast.error("You need to wait until the photo's have been uploaded", {
      duration: 5000,
    });
    return
  }

  fileUploads = fileUploads.filter(f => f.status == "idling" || f.status == "uploading");
}
