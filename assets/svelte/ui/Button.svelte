<script lang="ts">
  import { cn } from "../lib/util";
  import { type VariantProps, tv } from "tailwind-variants";
  cn;

  type Variant = VariantProps<typeof buttonVariants>["variant"];
  type Props = Partial<HTMLButtonElement> & {
    variant?: Variant;
  };

  const buttonVariants = tv({
    base: "py-2 px-3 text-sm font-semibold rounded-lg flex items-center gap-2",
    variants: {
      variant: {
        default: "bg-gray-100 hover:bg-gray-300",
        primary: "bg-[#ff7f00] text-white",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  });

  type $$Props = Props;

  let className = undefined;
  export let variant: $$Props["variant"] = "default";
  export { className as class };
</script>

<button
  class={cn(buttonVariants({ variant, className }))}
  {...$$restProps}
  on:click
  on:keydown
>
  <slot name="icon"></slot>
  <slot />
</button>
