module(..., package.seeall)

local TimerCalback = nil

function sys(timerCallbackFoo)
	TimerCalback = timerCallbackFoo
end

function timeout(timeoutMS, HandOverVal)
	com = ""
	com = com .. "timeout: " .. timeoutMS
	if HandOverVal ~= nil then
		com = com .. ", " .. HandOverVal
	end
	outToServer(com)


	_G._actualTimeout = timeoutMS
	_G._actualTimerHandover = HandOverVal
	_G._timerIsRunning = 1
end

function message(Msg)
	outToServer("Message Box: " .. Msg)
end

function set_page(a)
	outToServer("set_page: " .. a)
end

function set_Brightness(a)
	outToServer("set_Brightness: " .. a)
end

function beep(a,b,c)
	com = ""
	com = com .. "beep: " .. a
	if b ~= nil then
		com = com .. ", " .. b
	end
	if c ~= nil then
		com = com .. ", " .. c
	end
	outToServer(com)
end


function put_setting(a,b)
	outToServer("put_setting: " .. a .. ", " .. b)
end


function get_setting(a)
	outToServer("get_setting: " .. a)
end


function read_settings(a)
	outToServer("read_settings: " .. a)
end


function signal_obj(a)
	outToServer("signal_obj: " .. a)
end


function settings_dialog(a)
	outToServer("settings_dialog: " .. a)
end


function write_settings(a)
	outToServer("write_settings: " .. a)
end

function read_settings(a)
	outToServer("read_settings: " .. a)
end




--update server
function outToServer(val)
	if _debugClientTcpSocket ~= -1 then
		_G._debugClientTcpSocket:send("SYS;".. val .. "\n")
	else
		_defPrint("SYS;".. val .. "\n")
	end
end