<script>
  import Button from "$lib/ui/Button.svelte";
  import { HeadCircuit, Image, Images, SignIn, SignOut } from "phosphor-svelte";

  export let user;
</script>

<footer
  class="fixed bottom-0 h-16 w-full bg-white border-t border-gray-100 px-4 flex items-center justify-between"
>
  <div class="flex items-center gap-2">
    <a href="/albums"
      ><Button>
        <span>Albums</span>
        <Images slot="icon" />
      </Button>
    </a>
    <a href="/kiekjes">
      <Button>
        <span> Kiekjes </span>
        <Image slot="icon" />
      </Button>
    </a>
    <a href="/hoofdjes">
      <Button>
        <span>Hoofdjes</span>
        <HeadCircuit slot="icon" />
      </Button>
    </a>
  </div>
  {#if user}
    <div class="flex items-center gap-2">
      <p class="text-lg font-semibold">{user.name}</p>
      <a href="/auth/logout">
        <Button>
          <span>Logout</span>
          <SignOut slot="icon" />
        </Button>
      </a>
    </div>
  {:else}
    <a href="/auth/zauth">
      <Button>
        <span>Login</span>
        <SignIn slot="icon" />
      </Button>
    </a>
  {/if}
</footer>
