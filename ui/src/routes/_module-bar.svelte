<script lang="ts">
	import Navbar from '$lib/components/Navbar.svelte';
	import { createQuery } from '@tanstack/svelte-query';
	import type { User } from '$lib/types';

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
</script>

<main class="mb-20 px-4 py-2 sm:px-6 lg:px-8">
	<div class="container mx-auto">
		<slot />
	</div>
</main>
<Navbar name={$authQuery.data?.name} />
