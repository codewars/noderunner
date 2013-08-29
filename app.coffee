express = require("express")
JsRunner = require('./lib/js_runner')

app = express()
app.use express.bodyParser()
app.use express.methodOverride()
app.use (err, req, res, next) ->
  console.log 1
  console.log(err)
  err.request = req
  res.send(500, { error: err })

app.get '/', (req, res) ->
  res.type("text/plain")
  res.send(200, "NodeRunner is live!")


app.get '/run', (req, res) ->
  try
    console.log("\n\nRunning code with params:\n")
    console.log(req.query)
    new JsRunner(req.query.lang).run req.query.code, (output) ->
      console.log('\nOutput: \n')
      console.log(output)

      res.send(200, output)

app.post '/run', (req, res) ->
  try
    console.log("\n\nRunning code with post data:\n")
    console.log(req.body)
    new JsRunner(req.body.lang).run req.body.code, (output) ->
      console.log('\nOutput: \n')
      console.log(output)

      res.send(200, output)

module.exports = app