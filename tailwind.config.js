/** @type {import('tailwindcss').Config} */
module.exports = {
  purge: [
    "./app/views/categories/index.html.erb",
    "./app/views/products/index.html.erb",
    "./app/views/products/show.html.erb",
    "./app/views/layouts/application.html.erb",
    "./app/views/shared/_header.html.erb",
    // Add any other paths or files where Tailwind CSS classes are used
  ],
  content: [
    "./app/views/categories/index.html.erb",
    "./app/views/products/index.html.erb",
    "./app/views/products/show.html.erb",
    "./app/views/layouts/application.html.erb",
    "./app/views/shared/_header.html.erb",
  ],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/aspect-ratio")],
};
