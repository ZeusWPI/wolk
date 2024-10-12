<script>
  import { cn } from "$lib/lib/util";

  export let icon;

  let className = "";
  export { className as class };
</script>

<button
  class={cn(
    className,
    "py-2 px-3 text-sm font-semibold bg-gray-100 rounded-lg hover:bg-gray-300",
    icon && "flex items-center gap-2",
  )}
  {...$$restProps}
>
  {#if icon}
    <svelte:component this={icon} />
  {/if}
  <slot />
</button>
