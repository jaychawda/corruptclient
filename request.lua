
request = function() 

	local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	local length = 260
	local randomString = ''

	math.randomseed(os.time())

	charTable = {}
	for c in chars:gmatch"." do
	    table.insert(charTable, c)
	end

	for i = 1, length do
	    randomString = randomString .. charTable[math.random(1, #charTable)]
	end


	local payload = randomString

	
	local hmac = string.reverse(payload)

	wrk.method = "POST"
	wrk.body   = ("payload="..payload.."&hmac="..hmac)
	wrk.headers["Content-Type"] = "application/x-www-form-urlencoded"
	wrk.headers["HMAC"] = hmac
	return wrk.format("POST",wrk.path,wrk.headers,wrk.body)
end
