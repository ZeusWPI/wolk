<script lang="ts">
	import { createQuery } from '@tanstack/svelte-query';
	import ErrorView from '../ErrorView.svelte';
	import LoadingSpinner from '../LoadingSpinner.svelte';
	import type { Kiekje } from '$lib/types';
	import LazyImage from './LazyImage.svelte';

	const { albumId, date }: { albumId: string; date: string } = $props();

	const photosQuery = createQuery<{ kiekjes: Kiekje[] }>({
		queryKey: ['albums', albumId, 'photos', date],
		queryFn: async () => {
			const resp = await fetch(`/api/albums/${albumId}/${date}`);
			if (!resp.ok) {
				throw new Error('Failed to fetch photos');
			}
			return await resp.json();
		}
	});
</script>

{#if $photosQuery.isSuccess}
	<div class="flex flex-wrap">
		{#each $photosQuery.data.kiekjes as kiekje}
			<LazyImage url={kiekje.url} thumbnail={kiekje.thumbnail_url} />
		{/each}
	</div>
{:else if $photosQuery.isError}
	<ErrorView error={$photosQuery.error} />
{:else}
	<LoadingSpinner thing={'photos'} />
{/if}
