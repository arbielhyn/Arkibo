const path = require("path");
const webpack = require("webpack");
const { WebpackManifestPlugin } = require("webpack-manifest-plugin");

module.exports = {
  mode: "production", // Set mode to 'production' for optimized builds
  source_path: app / javascript, // Entry point of your application
  output: {
    filename: "bundle.js", // Output bundle file name
    path: path.resolve(__dirname, "dist"), // Output directory
    publicPath: "/dist/", // Public path (used by webpack-dev-server)
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          "style-loader",
          "css-loader",
          {
            loader: "postcss-loader",
            options: {
              postcssOptions: {
                plugins: [require("tailwindcss"), require("autoprefixer")],
              },
            },
          },
        ],
      },
      // Add more rules for other file types (e.g., images)
    ],
  },
  plugins: [
    new webpack.ProgressPlugin(), // Show progress during compilation
    new WebpackManifestPlugin(), // Generate manifest file for assets
  ],
};
