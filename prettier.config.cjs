/*
    07/05/24  Prettier configuration
*/
module.exports = {
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
    semi: true,
    singleQuote: false,
    tabWidth: 4,
    trailingComma: "all",
};
