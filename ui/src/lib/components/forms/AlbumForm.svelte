<script lang="ts">
	import * as Form from '$lib/components/ui/form';
	import { Input } from '$lib/components/ui/input';
	import { albumSchema, type AlbumSchema } from '$lib/schemas';
	import { type SuperValidated, type Infer, superForm } from 'sveltekit-superforms';
	import { zodClient } from 'sveltekit-superforms/adapters';

	let {
		data,
		submit
	}: { data: SuperValidated<Infer<AlbumSchema>>; submit: (data: Infer<AlbumSchema>) => void } =
		$props();

	const form = superForm(data, {
		validators: zodClient(albumSchema),
		SPA: true,
		onUpdate({ form }) {
			if (form.valid) {
				submit(form.data);
			}
		}
	});

	const { form: formData, enhance } = form;
</script>

<form method="POST" use:enhance>
	<Form.Field {form} name="name">
		<Form.Control let:attrs>
			<Form.Label>Name</Form.Label>
			<Input {...attrs} bind:value={$formData.name} />
		</Form.Control>
		<Form.FieldErrors />
	</Form.Field>
	<Form.Button>Submit</Form.Button>
</form>
