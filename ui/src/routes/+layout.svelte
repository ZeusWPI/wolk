<script lang="ts">
	import { QueryClientProvider } from '@tanstack/svelte-query';
	import '../app.css';
	import { queryClient } from '../lib/query';
	let { children } = $props();

	export const ssr = false;
</script>

<QueryClientProvider client={queryClient}>
	{@render children()}
</QueryClientProvider>
