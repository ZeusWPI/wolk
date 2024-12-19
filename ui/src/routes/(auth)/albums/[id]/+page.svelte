<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import * as Dialog from '$lib/components/ui/dialog';
	import { FileInput } from '$lib/components/ui/input';
	import { LucideUploadCloud } from 'lucide-svelte';
	import { page } from '$app/stores';

	let pictures = $state<FileList>();

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

		const kiekjeIds = kiekjes.filter((k) => k.status == 'fulfilled').map((k) => k.value.data.id);

		if (kiekjeIds.length == 0) {
			return;
		}

		const resp = await fetch(`/api/albums/${$page.params.id}/add`, {
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

<div class="flex justify-between">
	<p>Album</p>
	<Dialog.Root>
		<Dialog.Trigger
			><Button class="gap-2"><LucideUploadCloud size={16} />Upload</Button></Dialog.Trigger
		>
		<Dialog.Content>
			<Dialog.Header>
				<Dialog.Title>Upload new kiekjes!</Dialog.Title>
				<Dialog.Description class="space-y-2">
					<FileInput
						id="pictures"
						type="file"
						multiple
						accept="image/png, image/jpeg, image/webp"
						bind:files={pictures}
					/>
					<Button class="float-right" onclick={uploadPictures}>Submit</Button>
				</Dialog.Description>
			</Dialog.Header>
		</Dialog.Content>
	</Dialog.Root>
</div>
