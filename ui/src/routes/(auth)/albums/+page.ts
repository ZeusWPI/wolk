import { albumSchema } from '$lib/schemas';
import { superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';

export const load = async () => {
  const form = await superValidate(zod(albumSchema));

  return { form };
};
