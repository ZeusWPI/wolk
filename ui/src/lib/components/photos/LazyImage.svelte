<script lang="ts">
	import IntersectionObserver from '../IntersectionObserver.svelte';
	import * as Dialog from '../ui/dialog';

	let { url, thumbnail }: { url: string; thumbnail: string } = $props();

	let intersecting = $state(false);

	let element = $state<HTMLElement>();
</script>

<IntersectionObserver {element} bind:intersecting>
	<Dialog.Root>
		<Dialog.Trigger>
			<div class="h-[150px] w-[150px] object-contain" bind:this={element}>
				{#if intersecting}
					<img src={thumbnail} alt="" class="h-full w-full" />
				{/if}
			</div>
		</Dialog.Trigger>
		<Dialog.Content class="max-w-screen-2xl" hideCloseButton>
			<div class="relative">
				<img src={url} alt="" class="mx-auto max-h-[90vh] w-[95%] object-contain" />
			</div>
		</Dialog.Content>
	</Dialog.Root>
</IntersectionObserver>
