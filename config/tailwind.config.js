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
        DEFAULT: "#e7749a",
      },
      blue: {
        DEFAULT: "#0a358a",
      },
      yellow: {
        DEFAULT: "#f0dc00",
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
