<script lang="ts">
	import { tick, type Snippet } from 'svelte';

	let {
		children,
		intersecting = $bindable(),
		element
	}: { children: Snippet; intersecting: boolean; element: HTMLElement } = $props();
	let observer = $state<IntersectionObserver | null>(null);
	let prevElement = $state<HTMLElement | null>(null);

	const initialize = () => {
		observer = new IntersectionObserver((entries) => {
			entries.forEach((_entry) => {
				intersecting = _entry.isIntersecting;
			}, {});
		});
	};

	$effect.root(() => {
		$effect(() => initialize());

		return () => {
			if (observer) {
				observer.disconnect();
				observer = null;
			}
		};
	});

	$effect(() => {
		tick().then(() => {
			if (element && element !== prevElement) {
				observer?.observe(element);

				if (prevElement) observer?.unobserve(prevElement);
				prevElement = element;
			}
		});
	});
</script>

{@render children()}
