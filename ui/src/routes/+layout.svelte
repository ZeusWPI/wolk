<script lang="ts">
	import { QueryClientProvider } from '@tanstack/svelte-query';
	import { Toaster } from '$lib/components/ui/sonner';
	import '../app.css';
	import { queryClient } from '../lib/query';
	let { children } = $props();
</script>

<svelte:head>
	<title>Wolk - Zeus WPI</title>
</svelte:head><QueryClientProvider client={queryClient}>
	<Toaster richColors />
	{@render children()}
</QueryClientProvider>
