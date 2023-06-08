const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    colors: {
      magenta: {
        50: "#feedf1",
        100: "#fddbe3",
        200: "#fbb7c7",
        300: "#fa94aa",
        400: "#f8708e",
        500: "#f64c72",
      },
      blue: {
        50: "#eaeaf6",
        100: "#d5d5ec",
        200: "#acacda",
        300: "#8282c7",
        400: "#5959b5",
        500: "#2f2fa2",
      },
      gray: {
        25: "#f5f5f7",
        50: "#ebebef",
        100: "#d7d8df",
        200: "#b0b0bf",
        300: "#8889a0",
        400: "#616180",
        500: "#393a60",
        600: "#2e2e4d",
        700: "#22233a",
        800: "#171726",
        900: "#0b0c13",
      },
      white: "#fff",
    },
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
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
