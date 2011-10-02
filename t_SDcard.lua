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
* @file 	${NAME}
* @path		-
* @version	1
*
* @date		02.10.11 15:49
* @author	KR2
*
* @description 	SDcard lib test
*
* long
--]]

_isSimulation = true

require 'SDcard'
require 'fileSystemHelper'


SDrootDir = SDcard.getRootDir()   -- mounts the sd carde if neccery

fileSystemHelper.mkfile(SDrootDir,"test.txt")

temp = SDrootDir .. "test.txt"

file, e = io.open(temp,"a")

if not file then
	error(e);
end

file:write("This is an test *.txt file. \n")
file:write("This is for testing the SD card with lua. \n")
file:flush()


file:close()

SDcard.unmount()
