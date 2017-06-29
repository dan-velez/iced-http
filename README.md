  Http client and server tools built atop of Express.js
  Includes file uploading and body parsing.

## Usage
```coffee
	IcedHttpServer = (require 'iced-http').IcedHttpServer
	path = require 'path'

	class ImageServer extends IcedHttpServer

		install: =>
			@db = new mongodb 'mongodb://url'
			@app.get '/', @index
			@app.get '/img/photo.png', @getPhoto
			@app.post '/upload-image', @uploadImage

		index: (req, resp)=>
			resp.sendFile path.resolve './img/photo.png'

		uploadImage: (req, resp)=>
			files = req.files
			username = req.body.username
			for filename,file of files
				await @db.uploadFile "Files::#{username}", file, defer err, resp
				throw err if err
			resp.json 'files recieved'

	# Quickly deploy a server with file uploading and a body parser
	imageServer = new ImageServer port:80
```
