<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import { createQuery } from '@tanstack/svelte-query';
	import { Album, PlusIcon } from 'lucide-svelte';
	import * as Dialog from '$lib/components/ui/dialog';
	import AlbumForm from '$lib/components/forms/AlbumForm.svelte';
	import type { PageData } from './$types';
	import { getUserContext } from '$lib/context/user';

	export const ssr = false;
	let { data }: { data: PageData } = $props();

	let albumQuery = createQuery<Album[]>({
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
</script>

<div class="align-center flex justify-between">
	<h1>Albums</h1>
	{#if isAdmin}
		<Dialog.Root>
			<Dialog.Trigger><Button><PlusIcon /> Create</Button></Dialog.Trigger>
			<Dialog.Content>
				<Dialog.Header>
					<Dialog.Title>Create new album</Dialog.Title>
					<Dialog.Description>
						<AlbumForm data={data.form} submit={(d) => console.log(d)} />
					</Dialog.Description>
				</Dialog.Header>
			</Dialog.Content>
		</Dialog.Root>
	{/if}
</div>
{#if $albumQuery.isLoading}
	<p>Loading albums...</p>
{:else if $albumQuery.isError}
	<p>An error occurred while fetching the albums: {$albumQuery.error.message}</p>
{:else if $albumQuery.isSuccess}
	<div>
		{#each $albumQuery.data as album}
			<a href={`/albums/${album.id}`}>{album.name}</a>
		{/each}
	</div>
{/if}
