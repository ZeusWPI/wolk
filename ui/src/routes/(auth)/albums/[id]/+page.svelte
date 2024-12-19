<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import * as Dialog from '$lib/components/ui/dialog';
	import { LucideChevronLeft, LucideUploadCloud } from 'lucide-svelte';
	import KiekjesUploader from '$lib/components/KiekjesUploader.svelte';
	import { page } from '$app/stores';
	import { createQuery } from '@tanstack/svelte-query';
	import LoadingSpinner from '$lib/components/LoadingSpinner.svelte';
	import ErrorView from '$lib/components/ErrorView.svelte';

	let albumId = $derived($page.params.id);

	const albumDataQuery = createQuery<{ data: { name: string } }>({
		queryKey: ['album', $page.params.id],
		queryFn: async () => {
			const resp = await fetch(`/api/albums/${albumId}`);
			if (!resp.ok) {
				throw new Error('Failed to fetch album information');
			}
			return await resp.json();
		}
	});
</script>

{#if $albumDataQuery.isSuccess}
	<div class="flex justify-between">
		<div class="flex items-center gap-2">
			<a href="/albums">
				<LucideChevronLeft class="cursor-pointer" />
			</a>
			<p class="text-2xl font-semibold">{$albumDataQuery.data.data.name}</p>
		</div>
		<Dialog.Root>
			<Dialog.Trigger
				><Button class="gap-2"><LucideUploadCloud size={16} />Upload</Button></Dialog.Trigger
			>
			<Dialog.Content>
				<Dialog.Header>
					<Dialog.Title>Upload new kiekjes!</Dialog.Title>
					<Dialog.Description class="space-y-2">
						<KiekjesUploader {albumId} />
					</Dialog.Description>
				</Dialog.Header>
			</Dialog.Content>
		</Dialog.Root>
	</div>
{:else if $albumDataQuery.isError}
	<ErrorView error={$albumDataQuery.error} />
{:else}
	<LoadingSpinner thing="album info" />
{/if}
