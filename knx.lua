module(..., package.seeall)



local ObjValue = { }
--Types = dpt1, dpt2...
local ObjType = { }
local ObjLength = { } -- in bit
local ObjChanged = { } -- in bit
local function initObjStatus()
	for i = 0,255 do
		ObjValue[i] = 0	
		ObjType[i] = "x"
		ObjLength[i] = 1
		ObjChanged[i] = false
	end
end
initObjStatus()

function get_integer(...)
	local ret={}
	for index, val in ipairs(arg) do
		table.insert(ret,ObjValue[val])
	end
	return unpack(ret)
end


function set_integer(ObjNr, length, val)
	if val ~= ObjValue[ObjNr] then
		ObjChanged[ObjNr] = true
	end
	ObjValue[ObjNr] = val
	ObjType[ObjNr] = "x"
	ObjLength[ObjNr] = length * 8
	
	updateServer(ObjNr,val)
	makeKNXcallback(ObjNr)
end

function get_float(...)
	local ret={}
	for index, val in ipairs(arg) do
		table.insert(ret,ObjValue[val])
	end
	return unpack(ret)
end


function set_float(ObjNr, val)
	if val ~= ObjValue[ObjNr] then
		ObjChanged[ObjNr] = true
	end
	ObjValue[ObjNr] = val
	ObjType[ObjNr] = "4ByteFloat"
	ObjLength[ObjNr] = 4 * 8
	
	updateServer(ObjNr,val)
	makeKNXcallback(ObjNr)
end

function dpt9_to_int(val)
	return val
end


function int_to_dpt9(val)
	return val
end

function tx_idle(ObjNr)
	return true
end

--update server
function updateServer(ObjNr, val)
	_G._debugClientTcpSocket:send("SetObjVal;".. ObjNr .. ";" .. val .. "\n")
end

--Make Callback if
function makeKNXcallback(ObjNr)
	if ObjChanged[ObjNr] then
		ObjChanged[ObjNr] = false
		if _CallBackKnx_value_changed ~=-1 then
			_CallBackKnx_value_changed(ObjNr)
		else
			print("KNX value Changed callback function not defined")
		end
	else
		if _CallBackKnx_value_update ~=-1 then
			_CallBackKnx_value_update(ObjNr)
		else
			print("KNX value update callback function not defined")
		end
	end
end


