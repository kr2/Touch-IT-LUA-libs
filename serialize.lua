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
* @file 	serialize.lua
* @path		-
* @version	2
*
* @date		30.09.2011
* @author	KR2
*
* @brief 	serializaten and deserialization
*
example:

require 'serialize'

t_original = {'one','two','three','four', { 'five', 'six', 'seven'}, 'eight' }

serialize.serialize(t_original,"test")

print "Saved"

testDes = serialize.deserialize("test")

print (testDes[1])
print (testDes[2])
print (testDes[3])
print (testDes[5][2])

print "done"

--]]


module(..., package.seeall)

fsH = require 'fileSystemHelper'
require 'persistence'

local logicDir = "/userdata/logic/"  -- root path for serialization files
local fileExt = ".lser"  -- root path for serialization files

if _G._isSimulation then
    logicDir = "C:\\logic\\"
end

--- serializes preverable tabels
-- key is as well the filename with the extention fileExt
-- @param what tabel or variable
-- @param key key sting for storing and restoring
--
function serialize(what,key)
   local dir = logicDir .. key .. fileExt
   if (io.open(dir) == nil) then
       fsH.mkfile(logicDir,key .. fileExt)
   end
   persistence.store(dir, what)
end



--- dezerializes stuff and returns it
-- @param key of the stuff to dezerilize
-- @return the stuff dezerilized
--
function deserialize(key)
   local dir = logicDir .. key .. fileExt
   if (io.open(dir) == nil) then
       return nil
   end
   return  persistence.load(dir)
end


