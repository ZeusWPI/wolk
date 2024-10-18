<script lang="ts">
  import { Plus } from "phosphor-svelte";
  import Button from "$lib/ui/Button.svelte";
  import Input from "$lib/ui/Input.svelte";
  import type { Live } from "live_svelte";

  export let live: Live;
  export let albums: { name: string; id: number }[];

  export let admin = false;
  let newAlbumModal: HTMLDialogElement;

  const createAlbum = (e: SubmitEvent) => {
    e.preventDefault();
    const form = e.target as HTMLFormElement;
    const data = new FormData(form);
    live.pushEvent(
      "create_album",
      { album: { name: data.get("name") } },
      () => {},
    );
  };
</script>

<div class="flex justify-between items-center">
  <h1 class="text-2xl font-semibold">Albums</h1>
  {#if admin}
    <Button variant="primary" on:click={() => newAlbumModal.showModal()}>
      Create album
      <Plus weight="bold" size="1rem" slot="icon" />
    </Button>
    <dialog
      bind:this={newAlbumModal}
      class="w-96 h-44 p-4 rounded-lg border border-gray-400 shadow-lg"
    >
      <form class="space-y-2" on:submit={createAlbum}>
        <label>
          Album name:
          <Input name="name" />
        </label>
        <Button variant="primary">Create</Button>
      </form>
    </dialog>
  {/if}
</div>
<div class="flex flex-wrap gap-4">
  {#each albums as album (album.id)}
    <a
      href={`/albums/${album.id}`}
      data-phx-link="patch"
      data-phx-link-state="push"
    >
      <div
        class="h-40 w-40 shadow-lg rounded bg-gradient-to-b from-black/15 to-50% cursor-pointer"
      >
        <p class="p-2 white font-sm">{album.name}</p>
      </div>
    </a>
  {/each}
</div>
