Sandbox = require("sandbox")
fs = require("fs")
{spawn} = require 'child_process'

module.exports = class JsRunner
  constructor: (language) ->
    @sandbox = new Sandbox()
    @language = language || 'javascript'

  # runs a script, in this case the script should be an actual script that needs to be evaluated
  runScript: (path, cb) ->
    @readScript path, (code) =>
#      console.log "script code: #{code}"
      @run(code, cb)

  # reads contents out of a file
  readScript: (path, cb) ->
    fs.readFile "./scripts/#{path}", 'utf8', (err, data) =>
      cb(data)

  run: (code, cb) ->
    if @language == 'coffeescript'
      @execCoffee(code, cb)
    else
      @exec(code, cb)

  # directly executes the code without loading language specific compilers or wrapping anything
  exec: (code, cb) ->
    try
      @sandbox.run code, (output) ->
        output.result = null if output.result == 'null'
        if output.result == 'TimeoutError'
          output.timed_out = true
          output.error = 'Code timed out'
          output.result = null

        output.success = !output.error and !!output.success_id
        cb(output)
    catch ex
      cb(result: null, ex: ex)

  execCoffee: (code, cb) ->
    coffee = spawn 'coffee', ['-b', '-p', '-e', code]
    coffee.stderr.on 'data', (data) ->
      cb(error: 'Unable to compile CoffeeScript', success: false, result: null, success_id: null)

    coffee.stdout.on 'data', (data) =>
      @exec(data.toString(), cb)

    coffee.on 'exit', (code) ->
      callback?() if code is 0



