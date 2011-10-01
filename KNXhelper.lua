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
* @file 	KNXhelper.lua
* @path		-
* @version	1
*
* @date		29.09.2011
* @author	KR2
*
* @brief 	KNX helper functions
*
--]]


module(..., package.seeall)

-- sets output only if value has canged
function setComObj_int(objNr ,bytes ,val) 
	if knx.get_integer(objNr) ~= val then
		knx.set_integer(objNr,bytes,val)
		sys.signal_obj(objNr)
	end
end


function set_2Bfloat(objNr,val)
   temp = val * 100
   temp = knx.int_to_dpt9(temp)

   setComObj_int(objNr,2,temp)
end



function get_2Bfloat(objNr)
	temp = knx.get_integer(objNr)
	temp = knx.dpt9_to_int(temp)
	temp = (0.0 + temp) / 100
	return temp
end


