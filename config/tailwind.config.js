const defaultTheme = require("tailwindcss/defaultTheme");
const colors = require("tailwindcss/colors");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./app/components/**/*",
    "./public/**/*.svg",
  ],
  theme: {
    colors: {
      pink: {
        DEFAULT: "#DE73C5",
      },
      blue: {
        DEFAULT: "#0043C0",
      },
      yellow: {
        DEFAULT: "#E9D502",
      },
      gray: colors.gray,
      white: "#fff",
    },
    extend: {
      fontFamily: {
        sans: ["National", "Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
