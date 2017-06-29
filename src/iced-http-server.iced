# A custom express http server.
# Example usage:
# srv = new HttpServer
#	port: 5555

express = require 'express'
fupload = require 'express-fileupload'
bodyParser = require 'body-parser'

class IcedHttpServer

	name: 'HttpServer'

	constructor: ({@port})->
		@app = express()
		@app.use bodyParser.urlencoded
			extended: true
			limit:'2mb'
			parameterLimit: 100000
		@app.use bodyParser.json limit:'2mb'
		@app.use fupload()
		@app.use @logger
		@install()
		@listen()

	logger: (req, resp, next)=>
		console.log "#{req.method} #{req.path}"
		next()

	install: =>
		@app.get '/', (req, resp)=>
			resp.json
				name: @name
				port: @port

	listen: =>
		@app.listen @port, @startup

	startup: => console.log "#{@port} :: #{@name}"

module.exports = IcedHttpServer
