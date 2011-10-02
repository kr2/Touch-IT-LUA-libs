-- !!! Set if this runs as simulation
_isSimulation = false
if _isSimulation then
	_timerIsRunning = 0
	_actualTimeout = -1
	_actualTimerHandover = -1
	_lastTimeCalled = -1
	
	_debugClientTcpSocket = -1
	
	_CallBackSettings_set = -1
	_CallBackKnx_value_changed = -1
	_CallBackKnx_value_update = -1
	_CallBackTimeout = -1
	
	_defPrint = _G.print
	threads = {} -- gloabl thread tabel
	
	require "Simulator"	
	
end
-- !!! --


------------- OBJECT NUMMBERS -------
-- if there is an |LOGIC_OBJ| in the comment the object have to be one of the logic objects in the ETS application 
temp_ObjNr                = 240 -- [IN][2 Byte floate |LOGIC_OBJ|]
hum_ObjNr                = 241 -- [IN][2 Byte floate |LOGIC_OBJ|]
co_ObjNr                = 248 -- [IN][2 Byte floate |LOGIC_OBJ|]


settings={
	 {name="Example";min=0.5;max=6.0;val=1.0;dc=1};
	 {name="Example";min=0.5;max=6.0;val=2.5;dc=1};
}

function settings_set(x)
 sys.write_settings(x)

end



require 'SDcard'
require 'fileSystemHelper'
require 'KNXhelper'
require 'time'

SDrootDir = SDcard.getRootDir()   -- mounts the sd carde if neccery

time.sleep(2)

fileSystemHelper.mkfile(SDrootDir,"log.csv")
temp = SDrootDir .. "log.csv"
time.sleep(2)

file, e = io.open(temp,"a")
file:write("\n \n")
file:write("New Log: \n")
file:write("Date; Time; ObjNr; Value; Comment \n")
file:flush()
file:close()


time.sleep(10)
sys.message("mounted and first lines done")

-------------------------------------------------------------------------------------------------

function timeout(x)
    file, e = io.open(temp,"a")
    file:write(os.date("%x") .."; " .. os.date("%X") .."; " .. temp_ObjNr .."; " .. KNXhelper.get_2Bfloat(temp_ObjNr) .."; Temperature \n")
    file:write(os.date("%x") .."; " .. os.date("%X") .."; " .. hum_ObjNr .."; " .. KNXhelper.get_2Bfloat(hum_ObjNr) .."; Humidity \n")
    file:write(os.date("%x") .."; " .. os.date("%X") .."; " .. co_ObjNr .."; " .. knx.get_float(co_ObjNr) .."; CO2 \n")
	file:flush()
    file:close()
	return 0
end
if _isSimulation then _CallBackTimeout = timeout end




if _isSimulation then Simulator.init() end




sys.timeout(60 * 1000)



if _isSimulation then Simulator.main() end