
function base64enc(data)
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
request = function() 

	local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^*()_+-{}|[]~'
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


	local payload = ("payload=" .. randomString)

	
	local hmac = base64enc(randomString)

	wrk.method = "POST"
	wrk.body   = ("payload="..payload.."&hmac="..hmac)
	wrk.headers["Content-Type"] = "application/x-www-form-urlencoded"
	wrk.headers["HMAC"] = hmac
	return wrk.format("POST",wrk.path,wrk.headers,wrk.body)
end
