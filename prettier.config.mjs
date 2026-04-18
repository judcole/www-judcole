/*
    2026-04-17 Prettier configuration
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
  plugins: ["prettier-plugin-astro", "prettier-plugin-organize-imports", "prettier-plugin-tailwindcss"],
  printWidth: 110,
  semi: false,
  singleQuote: false,
  tabWidth: 4,
  trailingComma: "all",
}
