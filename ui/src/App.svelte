<script lang="ts">
	import { Router, createRouter } from '@roxi/routify';
	import routes from '../.routify/routes.default.js';
	import './app.css';
	import { QueryClientProvider } from '@tanstack/svelte-query';
	import { queryClient } from '$lib/query';

	const router = createRouter({ routes });
</script>

<QueryClientProvider client={queryClient}>
	<Router {router} />
</QueryClientProvider>
