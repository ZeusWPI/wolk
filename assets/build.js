const esbuild = require("esbuild")
const sveltePlugin = require("esbuild-svelte")
const importGlobPlugin = require("esbuild-plugin-import-glob").default
const sveltePreprocess = require("svelte-preprocess")

const args = process.argv.slice(2)
const deploy = args.includes("--deploy")
const watch = process.argv.includes("--watch")

let context = {
  entryPoints: ["js/app.js"],
  bundle: true,
  minify: deploy,
  target: "es2017",
  conditions: ["svelte", "browser"],
  outdir: "../priv/static/assets",
  logLevel: "info",
  sourcemap: watch ? "inline" : false,
  tsconfig: "./tsconfig.json",
  plugins: [
    importGlobPlugin(),
    sveltePlugin({
      preprocess: sveltePreprocess({ typescript: true }),
      compilerOptions: { dev: !deploy, hydratable: true, css: "injected" },
    }),
  ],
}

let ssrContext = {
  entryPoints: ["js/server.js"],
  platform: "node",
  bundle: true,
  minify: false,
  target: "node19.6.1",
  conditions: ["svelte"],
  outdir: "../priv/svelte",
  logLevel: "info",
  sourcemap: watch ? "inline" : false,
  tsconfig: "./tsconfig.json",
  plugins: [
    importGlobPlugin(),
    sveltePlugin({
      preprocess: sveltePreprocess({ typescript: true }),
      compilerOptions: { dev: !deploy, hydratable: true, generate: "ssr" },
    }),
  ],
}

async function watchBuild() {
  let ctx = await esbuild.context(context);
  await ctx.watch();
  let ssrCtx = await esbuild.context(ssrContext);
  await ssrCtx.watch();
  console.log("ESBuild is watching for changes...");
}

if (watch) {
  watchBuild();
} else {
  esbuild
    .build({
      minify: true,
      treeShaking: true,
      ...context,
    })
    .catch(() => process.exit(1));

  esbuild.build(ssrContext).catch(() => process.exit(1));
}

// const client = esbuild.build(optsClient)
// const server = esbuild.build(optsServer)
//
// if (watch) {
//   client.then(_result => {
//     process.stdin.on("close", () => process.exit(0))
//     process.stdin.resume()
//   })
//
//   server.then(_result => {
//     process.stdin.on("close", () => process.exit(0))
//     process.stdin.resume()
//   })
// }
