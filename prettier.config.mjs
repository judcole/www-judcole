/*
    2026-05-20  Prettier configuration
*/

/** @type {import("prettier").Config} */

export default {
  arrowParens: "always",
  jsxSingleQuote: false,
  overrides: [
    {
      files: "*.astro",
      options: {
        parser: "astro",
      },
    },
  ],
  plugins: [
    "prettier-plugin-astro",
    "prettier-plugin-organize-imports",
    "prettier-plugin-tailwindcss",
    "prettier-plugin-astro-organize-imports",
  ],
  printWidth: 110,
  semi: false,
  singleQuote: false,
  tabWidth: 4,
  trailingComma: "all",
}
