fs = require("fs")
{spawn} = require 'child_process'

module.exports = class RubyRunner
  constructor: (language) ->

  run: (code, cb) ->
    child =
