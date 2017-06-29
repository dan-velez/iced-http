http = require 'http'

class IcedHttpClient

	constructor: ({@host})->

	get: ({path, data}, callb)=>
		opts =
			host: @host
			path: path # Construct query here
			method: 'GET'
		req = http.request opts, (resp)=>
			data = ""
			resp.on 'data', (chunk)=> data+=chunk
			resp.on 'error', (error)=> return out error
			resp.on 'end', => callb
				status: resp.statusCode
				headers: resp.headers
				data: data
		req.end()
		req.on 'error', (error)=> return out error

	post: ({path, postData}, callb)=>
		opts =
			host: @host
			path: path # Construct query here
			method: 'POST'
		req = http.request opts, (resp)=>
			data = ""
			resp.on 'data', (chunk)=> data+=chunk
			resp.on 'error', (error)=> return out error
			resp.on 'end', => callb
				status: resp.statusCode
				headers: resp.headers
				data: data
		# out postData
		req.write postData
		req.end()
		req.on 'error', (error)=> return out error

	put: =>

	delete: =>

	request: =>

module.exports = IcedHttpClient

###
hc = new HttpClient host: 'truckingdatabase.com'
await hc.post
	path: '/companies/search'
	postData:
		'data[Company][search_text=a'
, defer resp
out resp

request = require 'request'
cheerio = require 'cheerio'

formData =
	'data[Company][search_text]': 'a'

out formData

await request.post
	url: 'http://truckingdatabase.com'
	formData: formData
, defer err, resp, body

out body

###
#

# Recursivley gather leads from each page.
# BTW use request module rather than node.js's http module

# $ = cheerio.load body
# console.log $(body).find('div.property')
