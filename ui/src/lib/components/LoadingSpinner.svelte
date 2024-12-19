<script lang="ts">
	import { LucideLoaderCircle } from 'lucide-svelte';

	const { thing }: { thing?: string } = $props();
</script>

<div class="flex flex-col items-center space-y-3">
	<LucideLoaderCircle class="animate-spin" />
	<p>Loading {thing}...</p>
</div>
