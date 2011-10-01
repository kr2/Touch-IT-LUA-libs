module(..., package.seeall)


require "knx"
require "sys"
require "socket" 

function intiSocket()
	local host, port = "localhost", 3663
	
	local ip = socket.dns.toip(host)
	
	local master, error = socket.tcp()
	if master == nil then
		print("faild to make socket: " .. error)
	end
	
	local done, error = master:connect(ip, port)
	if done == nil then
		print("faild to make socket: " .. error)
	else
		_G._debugClientTcpSocket = master
	end
	_G._debugClientTcpSocket:settimeout(0) -- make socket non blocking
end


function split(str, pat)
 	r = {}
 	last = 1
 	for i=1,str:len() do
 		if string.sub(str, i,i) == pat then
 			if last ~= i then
 				table.insert(r,string.sub(str, last,i-1))
 			else
 				table.insert(r,"")
 			end
 			last = i+1
 		end
 	end
 	table.insert(r,string.sub(str, last,str:len()))

	return r
end


-- overwrite default output
function out(...)
	
	local st=""
	for index, val in ipairs(arg) do
		if type(val) == "boolean" then
			if val == true then
				st = st .. "true" .. " "
			else
				st = st .. "false" .. " "
			end
		else
			st = st .. val .. " "
		end
	end
	
	if _G._debugClientTcpSocket ~= -1 then
		_G._debugClientTcpSocket:send("DebugOut;D;".. st .. "\n")
	else
		_defPrint(st)
	end
end
_G.print = out




-- main system



--function dispatcher ()
--  while true do
--    local n = table.getn(threads)
--    if n == 0 then break end   -- no more threads to run
--    for i=1,n do
--    	if coroutine.status (threads[i]) ~= "dead" then
--    		local status, errorMsg = coroutine.resume(threads[i])
--    		if not status then
--    			print(errorMsg)
--    		end
--    	else
--    		table.remove(threads, i)
--    	end       
--    end
 -- end
--end


-- handel socket receive
function receive()
	local val
    local status
    val,status = _G._debugClientTcpSocket:receive('*l')
	if val ~= nil then

		args = split(val,";")
		if args[1] == "SetObjVal" then
			knx.set_float(tonumber(args[2]),tonumber(args[3]))			
		end
		
		--_G._debugClientTcpSocket:send("DebugOut;D;" .. val .. "\n")
	end
end


-- for timer callback
function timerCallback()
	if _timerIsRunning ~= 0 then
		makeCall = 0
	
		if (_lastTimeCalled == -1) 
			or ((socket.gettime()*1000 -  _lastTimeCalled ) >= _actualTimeout) then
			
			if _CallBackTimeout ~= -1 then
				_lastTimeCalled = socket.gettime()*1000
				
				local retVal
				if _actualTimerHandover ~= -1 then
					retVal = _CallBackTimeout(_actualTimerHandover)
				else
					retVal = _CallBackTimeout()
				end
				
				-- stop if 1 returned
				if retVal == 1 then
					_timerIsRunning = 0
				end
			else
				print("Timer: No Callback Function Defined")
			end
		end
	end	
end


function init()
    intiSocket()

	_G._debugClientTcpSocket:send("START " .. os.date("%X") .. "\n")
end


function main()

	while true do
		receive()
		timerCallback()
	end
	
	--local co = coroutine.create(function()
	--	receive()
	--end)
	--table.insert(threads,co)
	
	--co = coroutine.create(function()
	--	timerCallback()
	--end)
	--table.insert(threads,co)
	
	
	--dispatcher()
	
	
end





