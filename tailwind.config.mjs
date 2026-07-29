/*
    2026-07-29 Tailwind configuration
*/

/** daisyui is a plugin-added key that tailwind's own Config type does not know
 * @type {import('tailwindcss').Config & { daisyui?: Record<string, unknown> }} */

export default {
  daisyui: {
    themes: ["light", "dark"], // true: all themes | false: only light + dark | array: specific themes ["light", "dark", "cupcake"]
    darkTheme: "dark", // Name of one of the included themes for dark mode
    logs: true, // Shows info about daisyUI version and used config in the console when building your CSS
  },
  plugins: [],
  theme: {
    extend: {},
  },
}
