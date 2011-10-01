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
* @version	1
*
* @date		30.09.2011
* @author	KR2
*
* @brief 	serializaten and deserialization
*
example:

fsH = require 'fileSystemHelper'

local logicDir = "/userdata/logic/"  -- root path for serialization files
local fileExt = ".lser"  -- root path for serialization files

fsH.mkfile(logicDir,"test" .. fileExt) -- creates dir with parents and the file test.lser within it


--]]


module(..., package.seeall)


local system = "UNIX" -- operating System

if _G._isSimulation then
   system = "WIN"
end


--- makes an directory with parent dir
-- NO files use mkfile
-- @param dir path/directory to make
--
function mkdir(dir)
  if system == "UNIX" then
    return io.popen("mkdir -p" .. dir)
  else
    return io.popen("mkdir " .. dir)
  end
end


--- maks file and parent directorys if not existing
-- !!! overwrites existing files !!!
-- @param dir directory
-- @param filename file
--
function mkfile(dir,filename)
  mkdir(dir)
  if system == "UNIX" then
    return io.popen('copy /Y  NUL ' .. dir .. filename)
  else
    return io.popen('copy /Y  NUL ' .. dir .. filename)
  end
end

