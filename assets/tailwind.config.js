// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/*_web.ex",
    "../lib/*_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        "primary-50": "#f0f9ff",
        "primary-100": "#e0f2fe",
        "primary-200": "#bae6fd",
        "primary-300": "#7dd4fc",
        "primary-400": "#38bef8",
        "primary-500": "#0ea4e9",
        "primary-600": "#0285c7",
        "primary-700": "#036aa1",
        "primary-800": "#075985",
        "primary-900": "#0c4a6e"
      },
      fontSize: {
        xxs: "11px",
      },
      height: {
        "[1.875rem]": "1.875rem",
        "[3.75rem]": "3.75rem",
      },

      maxWidth: {
        xxs: "15rem",
      },

      minHeight: (theme) => ({
        ...theme("spacing"),
      }),

      minWidth: (theme) => ({
        ...theme("spacing"),
        "[56px]": "56px",
      }),

      spacing: {
        5: "1.25rem",
        9: "2.25rem",
        11: "2.75rem",
      },

      top: (theme) => ({
        ...theme("inset"),
        "[56px]": "56px",
      }),

      width: (theme) => ({
        ...theme("spacing"),
        "[6rem]": "6rem",
        "[25rem]": "25rem",
      }),
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    plugin(({addVariant}) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"]))
  ]
}
