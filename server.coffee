require('nodefly').profile(
  process.env.NODEFLY_APPLICATION_KEY,
  [process.env.APP_NAME, 'Heroku']
)


cluster = require("cluster")

process.execPath = 'coffee'

if cluster.isMaster
  numCPUs = require('os').cpus().length

  cluster.fork() for i in [1..numCPUs]

  cluster.on 'exit', (worker, code, signal) ->
    console.log("Worker #{worker.id} with code:#{code} and signal:#{signal} died :(")
    cluster.fork()
    console.log('New worker forked :)')

else
  app = require('./app')
  app.listen(process.env.PORT || 8888)
