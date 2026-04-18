/*
    2026-04-17 Eslint configuration
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
  // ...astro.configs["recommended"],
  {
    ignores: ["dist"],
  },
  ...compat.extends("eslint:recommended", "eslint-config-prettier"),
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
      },
      ecmaVersion: 2020,
      sourceType: "module",
    },
    plugins: {
      astro,
    },
  },
]
