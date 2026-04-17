// 2026-04-17     Astro configuration

import mdx from "@astrojs/mdx"
import sitemap from "@astrojs/sitemap"
import tailwindcss from "@tailwindcss/vite"
import { defineConfig } from "astro/config"

export default defineConfig({
  integrations: [mdx(), sitemap()],
  site: "https://www.judcole.com",
  trailingSlash: "always",
  vite: {
    plugins: [tailwindcss()],
  },
})
