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
Example_ObjNr                = 240 -- [IN][2 Byte floate |LOGIC_OBJ|]


settings={
	 {name="Example";min=0.5;max=6.0;val=1.0;dc=1};
	 {name="Example";min=0.5;max=6.0;val=2.5;dc=1};
}

function settings_set(x)
 sys.write_settings(x)

end

-------------------------------------------------------------------------------------------------

function timeout(x)

	
	return 0
end
if _isSimulation then _CallBackTimeout = timeout end

-------------------------------------------------------------------------------------------------
--------------------------------- knx_value_changed ----------------------------------------------
function knx_value_changed(x)

	if (x == Example_ObjNr) then

	end

end 
if _isSimulation then _CallBackKnx_value_changed = knx_value_changed end




-------------------------------------------------------------------------------------------------
--------------------------------- knx_value_update ----------------------------------------------
function knx_value_update(x)

end
if _isSimulation then _CallBackKnx_value_update = knx_value_update end



if _isSimulation then Simulator.init() end


sys.timeout(TIMECYCLEsec * 1000)



if _isSimulation then Simulator.main() end