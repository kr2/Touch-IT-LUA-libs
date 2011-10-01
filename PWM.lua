--[[****************************************************************/
/* __/\\\________/\\\____/\\\\\\\\\________/\\\\\\\\\_____         */
/*  _\/\\\_____/\\\//___/\\\///////\\\____/\\\///////\\\___        */
/*   _\/\\\__/\\\//_____\/\\\_____\/\\\___\///______\//\\\__	   */
/*    _\/\\\\\\//\\\_____\/\\\\\\\\\\\/______________/\\\/___	   */
/*     _\/\\\//_\//\\\____\/\\\//////\\\___________/\\\//_____	   */
/*      _\/\\\____\//\\\___\/\\\____\//\\\_______/\\\//________	   */
/*       _\/\\\_____\//\\\__\/\\\_____\//\\\____/\\\/___________   */
/*        _\/\\\______\//\\\_\/\\\______\//\\\__/\\\\\\\\\\\\\\\_  */
/*         _\///________\///__\///________\///__\///////////////__ */
/*                                                                 */
/****************************************************************--]] 

--[[
* @file 	PWM.lua
* @path		-
* @version	1
*
* @date		28.09.2011
* @author	KR2
*
* @brief 	PWM object
*
* Pwm objects to generate an pwm output singal by setting duty Cycle and period time.
* The main function have to be called periodicaly determineds the accuracy.

example:


--]]



local C = {}
PWM = C

require "Object"	
C = Object:new()

StopWatch = require "StopWatch"




C.period = 0 -- period of one pwm cycle in seconds
C.onTime = 0.0 -- duty cycle in percent (on time in percent of the period)
C.onFoo = nil -- function calld for switching on
C.offFoo = nil -- function calld for switching off

C.OutStatus = 0 -- function calld for switching off

C.stopWatch1= StopWatch:new()



function C:new(o)
	local res = o or {}
	setmetatable(res, self)
	self.__index = self

	
	self.stopWatch1:start()
	
	return res
end


------ Setter ----
function C:setFunctions(OnFunctionAdd,OffFunctionAdd)	
	self.onFoo = OnFunctionAdd
	self.offFoo = OffFunctionAdd
end

function C:setPeriod(PeriodTimeSec)
	if PeriodTimeSec < 10 then
		self.period = 10
	else
		self.period = PeriodTimeSec
	end
	self:main()
end


-- DutyCyclePercent: 0..1
function C:setDutyCycle(DutyCyclePercent)
	self.onTime = (DutyCyclePercent*self.period)

    if self.stopWatch1:elapsed() > self.onTime then -- check if posible to use aktual cycle else restart
      self.stopWatch1:start()
    end
    self:main()

end



------

function C:callOnOff(val)
    --print("status: " .. self.OutStatus .. "val:" .. val)
	if val ~= self.OutStatus then
		if val == 0 then
            self.OutStatus = 0
			self.offFoo()
        else
            self.OutStatus = 1
			self.onFoo()
		end
	end
end

function C:main(timeSinceLastCallMS)
    --print("pwm main on time:" .. self.onTime)

	local time = self.stopWatch1:elapsed()

	--print("pwm elapsed time:" .. time)

	if time >= self.period then
		self.stopWatch1:start()
		
		time = 0
        --print("pwm new period elapest time:" .. time)
	end

   --print("time: " .. time .. "onTime: " .. self.onTime)
	if time < self.onTime then
        --print("switch on")
		self:callOnOff(1)
    else
        --print("switch off")
		self:callOnOff(0)
	end	
end


return C