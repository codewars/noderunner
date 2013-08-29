JsRunner = require("../lib/js_runner")
Sandbox = require("sandbox")
fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

log = (key, msg) ->
  console.log("\n\n#{key}:")
  console.log(msg)

exports.timeoutErrors = (test) ->
  runner = new JsRunner()
  runner.run "while(true){}", (output) ->
    log 'timeoutErrors', output
    test.ok !output.result
    test.ok output.error
    test.ok output.timed_out
    test.done()

exports.evalCode = (test) ->
  runner = new JsRunner()
  runner.run "$$_SUCCESS__ = '123'; 1+2", (output) ->
    log 'evalCode', output
    test.ok output.result == "3"
    test.ok output.success_id == "123"
    test.done()


exports.badCode = (test) ->
  runner = new JsRunner()
  runner.run "throw 'shit happens'", (output) ->
    log "badCode", output
    test.ok output.error
    test.ok !output.success_id
#    console.log JSON.parse(output.result.substr(1, output.result.length - 2))
    test.done()

exports.consoleTest = (test) ->
  runner = new JsRunner()
  runner.run "console.log(1);1", (output) ->
    log 'console', output
    test.done()


exports.runSuccessJsScript = (test) ->
  runner = new JsRunner()
  runner.runScript "examples/success.js", (output) ->
    log "success", output
    test.ok output.success_id == 'mdtf_qend__'
    test.ok !output.error
    test.ok output.success
    test.done()

exports.runWrongJsScript = (test) ->
  runner = new JsRunner()
  runner.runScript "examples/wrong.js", (output) ->
    log "wrong", output
    test.ok !output.success_id
    test.ok output.error
    test.done()

exports.basicCoffeeScript = (test) ->
  runner = new JsRunner('coffeescript')
  runner.runScript "examples/basic.coffee", (output) ->
    log "basicCoffeeScript", output
    test.ok output.result == '4'
    test.ok !output.error
    test.done()
#
exports.runSuccessCoffeeScript = (test) ->
  runner = new JsRunner('coffeescript')
  runner.runScript "examples/success.coffee", (output) ->
    log "success", output
    test.ok output.success_id == 'mdtf_qend__'
    test.ok !output.error
    test.done()


