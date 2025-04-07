<script lang="ts">
	import Navbar from '$lib/components/Navbar.svelte';
	import PendingUploads from '$lib/components/PendingUploads.svelte';
	import { setUserContext } from '$lib/context/user';
	import type { User } from '$lib/types';
	import { createQuery } from '@tanstack/svelte-query';
	let { children } = $props();

	const authQuery = createQuery<User>({
		queryKey: ['auth', 'user'],
		queryFn: async () => {
			const resp = await fetch('/api/users/me');
			if (!resp.ok) {
				throw new Error('Failed to fetch user info');
			}
			return (await resp.json())?.data;
		},
		refetchOnWindowFocus: false
	});

	setUserContext(authQuery);
</script>

<main class="relative h-[calc(100vh-4rem)] px-4 py-2 sm:px-6 lg:px-8">
	<div class="container mx-auto">
		{#if $authQuery.isLoading}
			<p>Loading session...</p>
		{:else if $authQuery.isError}
			<p>Auth error: {$authQuery.error.message}</p>
		{:else if $authQuery.isSuccess}
			{@render children()}
		{/if}
	</div>
	<PendingUploads />
</main>
<Navbar name={$authQuery.data?.name} />
