<script lang="ts">
	import * as Form from '$lib/components/ui/form';
	import { Input } from '$lib/components/ui/input';
	import { existingAlbumSchema, type ExistingAlbumSchema } from '$lib/schemas';
	import { type SuperValidated, type Infer, superForm } from 'sveltekit-superforms';
	import { zodClient } from 'sveltekit-superforms/adapters';
	import FileInput from '../ui/input/fileInput.svelte';

	let {
		data,
		submit
	}: {
		data: SuperValidated<Infer<ExistingAlbumSchema>>;
		submit: (data: Infer<ExistingAlbumSchema>) => void;
	} = $props();

	const form = superForm(data, {
		validators: zodClient(existingAlbumSchema),
		SPA: true,
		onUpdate({ form }) {
			if (form.valid) {
				submit(form.data);
			}
		}
	});

	const { form: formData, enhance } = form;
</script>

<form method="POST" enctype="multipart/form-data" use:enhance>
	<Form.Field {form} name="name">
		<Form.Control let:attrs>
			<Form.Label>Name</Form.Label>
			<Input {...attrs} bind:value={$formData.name} />
		</Form.Control>
		<Form.FieldErrors />
	</Form.Field>
	<Form.Field {form} name="files">
		<Form.Control let:attrs>
			<Form.Label>Folder</Form.Label>
			<FileInput
				{...attrs}
				type="file"
				webkitdirectory
				multiple
				bind:files={$formData.files}
				accept="image/png, image/jpeg, image/webp"
			/>
		</Form.Control>
		<Form.FieldErrors />
	</Form.Field>
	<Form.Button>Submit</Form.Button>
</form>
