<script lang="ts">
	import {
		LucideChevronUp,
		LucideCircleCheck,
		LucideCircleHelp,
		LucideLoader,
		LucideLoaderCircle,
		LucideOctagonAlert,
		LucideTrash2
	} from 'lucide-svelte';
	import { Button, buttonVariants } from '$lib/components/ui/button';
	import { cn } from '$lib/utils';
	import { cleanupUploads, getFileUploads } from '$lib/context/uploads.svelte';
	import * as Tooltip from '$lib/components/ui/tooltip';

	let opened = $state(false);

	$effect(() => {
		opened = getFileUploads().length > 0;
	});
</script>

{#if getFileUploads().length > 0}
	<div
		class={cn(
			'fixed bottom-16 right-4 w-1/4 rounded-t-lg border border-zinc-400 border-b-white bg-white transition-all',
			opened ? 'h-80' : 'h-12'
		)}
	>
		<div class={'flex h-12 items-center justify-between border-b border-b-zinc-400 px-2'}>
			<p>Pending Uploads</p>
			<div class="flex gap-2">
				{#if opened}
					<Tooltip.Provider>
						<Tooltip.Root>
							<Tooltip.Trigger
								class={buttonVariants({ size: 'icon', variant: 'ghost' })}
								onclick={() => cleanupUploads()}
							>
								<LucideTrash2 size="1rem" />
							</Tooltip.Trigger>
							<Tooltip.Content>
								<p>Remove all completed or failed uploads</p>
							</Tooltip.Content>
						</Tooltip.Root>
					</Tooltip.Provider>
				{/if}
				<Button
					variant="ghost"
					size="icon"
					class={cn('transition-transform', opened ? 'rotate-180' : 'rotate-0')}
					onclick={() => {
						opened = !opened;
					}}><LucideChevronUp /></Button
				>
			</div>
		</div>
		<div class="h-[17rem] overflow-x-auto">
			<div class="h-max">
				{#each getFileUploads() as upload}
					<div class="flex h-12 items-center gap-2 border-b border-b-zinc-300 px-2">
						<img
							class="h-8 w-8 object-contain"
							src={URL.createObjectURL(upload.file)}
							alt="to be uploaded"
						/>
						<Tooltip.Provider>
							<Tooltip.Root>
								<Tooltip.Trigger
									class="w-inherit max-w-[75%] flex-1 overflow-hidden text-ellipsis whitespace-nowrap text-left text-xs"
								>
									{upload.file.name}
								</Tooltip.Trigger>
								<Tooltip.Content>
									<p>{upload.file.name}</p>
								</Tooltip.Content>
							</Tooltip.Root>
						</Tooltip.Provider>
						<div>
							{#if upload.status === 'idling'}
								<LucideLoader class="animate-spin" />
							{:else if upload.status === 'uploading'}
								<LucideLoaderCircle class="animate-spin" />
							{:else if upload.status === 'uploaded'}
								<LucideCircleCheck class="text-green-500" />
							{:else if upload.status === 'failed'}
								<LucideOctagonAlert class="text-red-500" />
							{:else}
								<LucideCircleHelp />
							{/if}
						</div>
					</div>
				{/each}
			</div>
		</div>
	</div>
{/if}
