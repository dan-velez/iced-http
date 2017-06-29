# Child of HttpServer class with SSL support.
# Construct an HttpsServer with a creds{} struct to 
# point the server to the location of the SSL certificates.

https = require 'https'
IcedHttpServer = require 'IcedHttpServer'

class IcedHttpsServer extends IcedHttpServer

	name: 'IcedHttpsServer'

	creds:
		ca: ''
		cert: ''
		key: ''

	install: =>
		@app.get '/', (req, resp)=> httpsServer:true

	logger: (req, resp, next)=>
		out "#{req.method} #{req.path}"
		next()

	listen: =>
		httpsServer = https.createServer @creds, @app
		httpsServer.listen @port, @startup

module.exports = IcedHttpsServer
