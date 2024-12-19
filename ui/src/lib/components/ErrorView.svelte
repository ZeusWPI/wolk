<script lang="ts">
	import { LucideTriangleAlert } from 'lucide-svelte';
	import { dev } from '$app/environment';

	const { error }: { error: Error } = $props();
</script>

<div class="flex flex-col items-center space-y-2">
	<LucideTriangleAlert color={'#ff6700'} />
	<p>{error.message}</p>
	{#if dev && error.stack}
		<pre>{error.stack}</pre>
	{/if}
</div>
