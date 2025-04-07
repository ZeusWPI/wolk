<script lang="ts">
	import { createQuery } from '@tanstack/svelte-query';
	import ErrorView from '$lib/components/ErrorView.svelte';
	import LoadingSpinner from '$lib/components/LoadingSpinner.svelte';
	import dayjs from 'dayjs';
	import customParseFormat from 'dayjs/plugin/customParseFormat';
	import LazyPhotoList from './LazyPhotoList.svelte';

	dayjs.extend(customParseFormat);

	const { albumId }: { albumId: number } = $props();

	const activeMonthQuery = createQuery<string[]>({
		queryKey: ['albums', albumId, 'activeMonth'],
		queryFn: async () => {
			const resp = await fetch(`/api/albums/${albumId}/active_months`);
			if (!resp.ok) {
				throw new Error('Failed to fetch active month');
			}
			return await resp.json();
		}
	});
</script>

{#if $activeMonthQuery.isSuccess}
	<div>
		{#each $activeMonthQuery.data as month}
			<h2 class="text-xl font-bold text-gray-500">
				{dayjs(month, 'M-YYYY').format('MMMM YYYY').toUpperCase()}
			</h2>
			<LazyPhotoList {albumId} date={month} />
		{/each}
	</div>
{:else if $activeMonthQuery.isError}
	<ErrorView error={$activeMonthQuery.error} />
{:else}
	<LoadingSpinner thing={'photos'} />
{/if}
