import { defineConfig } from 'vite'
import { sveltekit } from '@sveltejs/kit/vite';
import path from "path";

// https://vite.dev/config/
export default defineConfig({
  plugins: [sveltekit()],
  server: {
    port: 3000,
    proxy: {
      "/api": {
        target: "http://localhost:4000",
        changeOrigin: true
      }
    }
  },
  resolve: {
    alias: {
      $lib: path.resolve("./src/lib"),
    },
  },
})
