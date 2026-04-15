import mdx from "@astrojs/mdx"
import sitemap from "@astrojs/sitemap"
import tailwindcss from "@tailwindcss/vite"
import { defineConfig } from "astro/config"

export default defineConfig({
  integrations: [mdx(), sitemap()],
  outDir: "./build",
  site: "https://www.judcole.com",
  vite: {
    plugins: [tailwindcss()],
  },
})
