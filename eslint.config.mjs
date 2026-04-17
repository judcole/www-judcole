/*
    2026-04-16  Eslint configuration
*/

import { FlatCompat } from "@eslint/eslintrc"
import js from "@eslint/js"
import astro from "eslint-plugin-astro"
import globals from "globals"
import path from "node:path"
import { fileURLToPath } from "node:url"

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all,
})

export default [
  {
    ignores: [
      "!**/.env.example",
      ".astro",
      "**/.DS_Store",
      "**/.env.*",
      "**/.env",
      "**/node_modules",
      "**/package-lock.json",
      "**/pnpm-lock.yaml",
      "**/yarn.lock",
      "dist",
      "package",
    ],
  },
  ...compat.extends("eslint:recommended", "eslint-config-prettier"),
  {
    plugins: {
      astro,
    },

    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
      },

      ecmaVersion: 2020,
      sourceType: "module",
    },
  },
]
