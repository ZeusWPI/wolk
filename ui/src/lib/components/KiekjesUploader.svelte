<script lang="ts">
	import { addFileUpload, processUploads } from '$lib/context/uploads.svelte';
	import { Button } from './ui/button';
	import FileInput from './ui/input/fileInput.svelte';

	let pictures = $state<FileList>();

	let { albumId, afterUpload }: { albumId: number; afterUpload?: () => void } = $props();

	const uploadPictures = async () => {
		if (!pictures) return;

		for (let i = 0; i < pictures.length; i++) {
			addFileUpload(pictures![i], albumId);
		}

		processUploads();
		afterUpload?.();
	};
</script>

<div class="space-y-2">
	<FileInput
		id="pictures"
		type="file"
		multiple
		accept="image/png, image/jpeg, image/webp"
		bind:files={pictures}
	/>
	<Button class="float-right" onclick={uploadPictures}>Submit</Button>
</div>
