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
* @file 	time.lua
* @path		-
* @version	1
*
* @date		28.09.2011
* @author	KR2
*
* @brief 	timer functions
*
* functions to gets system uptime
--]]


module(..., package.seeall)

require "stringExt"	

--[[
@brief   uptime in seconds
!!! very time intensive to improve !!!

returns the uptime in seconds with two digets (returns a number)
example:
time = time.getUptime()

 --]]
function getUptime()
	if _G._isSimulation then
		require "socket" 
		return socket.gettime()
	end

   local f = io.popen('cat /proc/uptime')
   local s = f:read('*a')
   
   s = stringExt.split(s," ")
   
   return tonumber(s[1])
end






-- busy wating
function sleep(n)  -- seconds
  local t0 = os.clock()
  while os.clock() - t0 <= n do end
end