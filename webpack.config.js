var path = require('path');
var plugins = [];

module.exports = {
  devtool: "source-map",
  mode: "development",
  entry: "./index.js",
  output: {
    path: __dirname + "/dist",
    filename: "bundle.js",
    sourceMapFilename: "bundle.js.map"
  },
  plugins: plugins,
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules\//,
        loader: "babel-loader"
      },
    ]
  }
}