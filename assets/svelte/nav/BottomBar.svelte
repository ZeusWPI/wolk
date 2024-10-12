<script>
  import Button from "$lib/ui/Button.svelte";
  import { HeadCircuit, Image, Images, SignIn, SignOut } from "phosphor-svelte";

  export let user;
</script>

<footer
  class="fixed bottom-0 h-16 w-full bg-white border-t border-gray-100 px-4 flex items-center justify-between"
>
  <div class="flex items-center gap-2">
    <a href="/albums"><Button icon={Images}>Albums</Button> </a>
    <a href="/kiekjes"> <Button icon={Image}>Kiekjes</Button></a>
    <a href="/hoofdjes"> <Button icon={HeadCircuit}>Hoofdjes</Button></a>
  </div>
  {#if user}
    <div class="flex items-center gap-2">
      <p class="text-lg font-semibold">{user.name}</p>
      <a href="/auth/logout">
        <Button icon={SignOut}>Logout</Button>
      </a>
    </div>
  {:else}
    <a href="/auth/zauth">
      <Button icon={SignIn}>Login</Button>
    </a>
  {/if}
</footer>
