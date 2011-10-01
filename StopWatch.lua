local C = {}
StopWatch = C

Object = require "Object"
C = Object:new()

require "time"	

C.startTime = 0
C.ElapsedTime = 0
C.isRunning = false


function C:elapsed()
	if self.isRunning == true then
		return (time.getUptime()-self.startTime)
	else
		return self.ElapsedTime
	end
end

function C:elapsedMilliseconds()
	return self:elapsed()*1000
end

function C:setElapsedTime(TimeSec)
	self.ElapsedTime = TimeSec
	self.startTime = time.getUptime() - TimeSec
	if self.startTime < 0 then
		self.startTime = 0
	end
end

function C:start()
	self.startTime=time.getUptime()
	self.isRunning = true
end

function C:stop()
	self.ElapsedTime = (time.getUptime()-self.startTime)
	self.isRunning = false
end

function C:reset()
	self.ElapsedTime = 0
	self.isRunning = false
end


return C