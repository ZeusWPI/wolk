<script lang="ts">
	import {
		BabyIcon,
		GalleryVerticalEndIcon,
		ImageIcon,
		LogInIcon,
		LogOutIcon
	} from 'lucide-svelte';
	import { Button } from '$lib/components/ui/button';

	export let name: string | undefined = undefined;
</script>

<footer
	class="fixed bottom-0 flex h-16 w-full items-center justify-between border-t border-gray-100 bg-white px-4"
>
	<div class="flex items-center gap-2">
		<a href="/albums">
			<Button variant="secondary">
				<GalleryVerticalEndIcon class="h-4 w-4" />
				<span>Albums</span>
			</Button>
		</a>
		<a href="/kiekjes">
			<Button variant="secondary">
				<ImageIcon class="h-4 w-4" />
				<span>Kiekjes</span>
			</Button>
		</a>
		<a href="/hoofdjes">
			<Button variant="secondary">
				<BabyIcon class="h-4 w-4" />
				<span>Hoofdjes</span>
			</Button>
		</a>
	</div>
	{#if name}
		<div class="flex items-center gap-2">
			<p class="text-lg font-semibold">{name}</p>
			<a href="/api/auth/logout" target="_self">
				<Button variant="secondary">
					<LogOutIcon class="h-4 w-4" />
					<span>Logout</span>
				</Button>
			</a>
		</div>
	{:else}
		<a href="/api/auth/zauth" target="_self">
			<Button variant="secondary">
				<LogInIcon class="h-4 w-4" />
				<span>Login</span>
			</Button>
		</a>
	{/if}
</footer>
