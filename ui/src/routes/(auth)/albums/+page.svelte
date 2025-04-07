<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import { createQuery } from '@tanstack/svelte-query';
	import { Album, LucideUploadCloud, PlusIcon } from 'lucide-svelte';
	import * as Dialog from '$lib/components/ui/dialog';
	import AlbumForm from '$lib/components/forms/AlbumForm.svelte';
	import ExistingAlbumForm from '$lib/components/forms/ExistingAlbumForm.svelte';
	import type { PageData } from './$types';
	import { getUserContext } from '$lib/context/user';
	import { queryClient } from '$lib/query';
	import { toast } from 'svelte-sonner';
	import { addFileUpload, processUploads } from '$lib/context/uploads.svelte';

	let { data }: { data: PageData } = $props();

	let albumQuery = createQuery<{ data: Album[] }>({
		queryKey: ['albums'],
		queryFn: async () => {
			const resp = await fetch('/api/albums');
			if (!resp.ok) {
				throw new Error('Failed to fetch albums');
			}
			return resp.json();
		}
	});

	const query = getUserContext();

	let isAdmin = $derived.by(() => {
		return $query.data?.admin ?? false;
	});

	const createNewAlbum = async (name: string) => {
		const resp = await fetch('/api/albums', {
			method: 'POST',
			body: JSON.stringify({ album: { name } }),
			headers: {
				'Content-Type': 'application/json'
			}
		});
		if (!resp.ok) {
			toast.error('Failed to create album');
			return;
		}
		const body = await resp.json();
		toast.success('Album created!');
		queryClient.invalidateQueries({ queryKey: ['albums'] });
		return body.data.id;
	};

	const uploadExistingAlbum = async (name: string, files: FileList) => {
		const albumId = await createNewAlbum(name);
		if (!albumId) {
			throw new Error('No albumID retrieved from album creation');
		}
		for (let i = 0; i < files.length; i++) {
			addFileUpload(files[i], albumId);
		}
		processUploads();
	};
</script>

<div class="flex items-center justify-between">
	<h1 class="text-2xl font-semibold">Albums</h1>
	{#if isAdmin}
		<div class="flex items-center gap-2">
			<Dialog.Root>
				<Dialog.Trigger><Button><PlusIcon class="mr-2" />Create</Button></Dialog.Trigger>
				<Dialog.Content>
					<Dialog.Header>
						<Dialog.Title>Create new album</Dialog.Title>
						<Dialog.Description>
							<AlbumForm data={data.form} submit={(d) => createNewAlbum(d.name)} />
						</Dialog.Description>
					</Dialog.Header>
				</Dialog.Content>
			</Dialog.Root>
			<Dialog.Root>
				<Dialog.Trigger
					><Button><LucideUploadCloud size={16} class="mr-2" />Upload</Button></Dialog.Trigger
				>
				<Dialog.Content>
					<Dialog.Header>
						<Dialog.Title>Upload album</Dialog.Title>
						<Dialog.Description>
							<ExistingAlbumForm
								data={data.form}
								submit={(d) => uploadExistingAlbum(d.name, d.files)}
							/>
						</Dialog.Description>
					</Dialog.Header>
				</Dialog.Content>
			</Dialog.Root>
		</div>
	{/if}
</div>
{#if $albumQuery.isLoading}
	<p>Loading albums...</p>
{:else if $albumQuery.isError}
	<p>An error occurred while fetching the albums: {$albumQuery.error.message}</p>
{:else if $albumQuery.isSuccess}
	<div class="flex flex-wrap gap-2">
		{#each $albumQuery.data.data as album}
			<a href={`/albums/${album.id}`}>
				<div
					class="h-40 w-40 cursor-pointer rounded bg-gradient-to-b from-black/15 to-50% shadow-lg"
				>
					<p class="white font-sm p-2">{album.name}</p>
				</div>
			</a>
		{/each}
	</div>
{/if}
