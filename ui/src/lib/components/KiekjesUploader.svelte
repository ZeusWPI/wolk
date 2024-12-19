<script lang="ts">
	import { Button } from './ui/button';
	import FileInput from './ui/input/fileInput.svelte';

	let pictures = $state<FileList>();

	let { albumId }: { albumId: string } = $props();

	const uploadPictures = async () => {
		if (!pictures) return;

		const kiekjes = await Promise.allSettled<{ data: { id: string } }>(
			new Array(pictures.length).fill(0).map(async (_, i) => {
				const formData = new FormData();
				formData.append('image', pictures![i]);
				const resp = await fetch('/api/kiekje', {
					method: 'POST',
					body: formData
				});
				if (!resp.ok) {
					throw new Error('Failed to upload image');
				}
				return resp.json();
			})
		);

		const failedFiles: File[] = [];
		kiekjes.forEach((kiekje, i) => {
			if (kiekje.status === 'rejected') {
				failedFiles.push(pictures![i]);
			}
		});
		console.log(failedFiles);

		const kiekjeIds = kiekjes.filter((k) => k.status == 'fulfilled').map((k) => k.value.data.id);

		if (kiekjeIds.length == 0) {
			return;
		}

		const resp = await fetch(`/api/albums/${albumId}/add`, {
			method: 'POST',
			body: JSON.stringify({
				kiekjes: kiekjeIds
			}),
			headers: {
				'Content-Type': 'application/json'
			}
		});

		if (!resp.ok) {
			console.error('Failed to add kiekjes to album');
		}
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
