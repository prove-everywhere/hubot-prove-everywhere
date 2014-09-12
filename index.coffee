fs   = require 'fs'
path = require 'path'

module.exports = (robot) ->
  srcPath = path.resolve __dirname, 'src'
  fs.exists srcPath, (exists) ->
    if exists
      robot.loadFile srcPath, file for file in fs.readdirSync(srcPath)
