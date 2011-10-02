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
* @date		02.10.11 15:31
* @author	KR2
*
* @description 	Comands for SDcard mounting and handling
*
* long
--]]


module(..., package.seeall)


local system = "UNIX" -- operating System

if _G._isSimulation then
   system = "WIN"
end

local SDcardMounted = false

function mount()
  if not(SDcardMounted) then
    SDcardMounted = true
    if system == "UNIX" then
      return io.popen("mount /dev/mmcblk0p1 /mnt/")
    end
  else
      return "SD card already mounted"
  end
end

function unmount()
  if SDcardMounted then
    if system == "UNIX" then
      return io.popen("umount /mnt/")
    end
  else
      return "no SD card to unmount"
  end
end

function getRootDir()
  if not(SDcardMounted)then
    mount()
  end

  if system == "UNIX" then
    return "/mnt/"
  else
    return "C:\\logic\\"
  end
end