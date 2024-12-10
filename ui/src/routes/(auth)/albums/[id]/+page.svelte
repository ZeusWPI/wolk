<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import * as Dialog from '$lib/components/ui/dialog';
	import { FileInput } from '$lib/components/ui/input';
	import { LucideUploadCloud } from 'lucide-svelte';
	import { page } from '$app/stores';

	let pictures = $state<FileList>();

	const uploadPictures = () => {
		if (!pictures) return;
		const formData = new FormData();
		for (let i = 0; i < pictures.length; i++) {
			const picture = pictures[i];
			formData.append('pictures', picture);
		}
		fetch(`/api/albums/${$page.params.id}/pictures`, {
			method: 'POST',
			body: formData
		});
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
