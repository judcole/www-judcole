/** @type {import('tailwindcss').Config} */
module.exports = {
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/typography")],
  daisyui: {
    themes: ["light", "dark"], // true: all themes | false: only light + dark | array: specific themes ["light", "dark", "cupcake"]
    darkTheme: "dark", // Name of one of the included themes for dark mode
    logs: true, // Shows info about daisyUI version and used config in the console when building your CSS
  },
}
