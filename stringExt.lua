module(..., package.seeall)

--[[
splits the string on the singel care pat an returns the string parts in an tabel
example:
args = stringExt.split(val,";")
if args[1] == "SetObjVal" then
	knx.set_float(tonumber(args[2]),tonumber(args[3]))			
end
--]]
function split(str, pat)
 	r = {}
 	last = 1
 	for i=1,str:len() do
 		if string.sub(str, i,i) == pat then
 			if last ~= i then
 				table.insert(r,string.sub(str, last,i-1))
 			else
 				table.insert(r,"")
 			end
 			last = i+1
 		end
 	end
 	table.insert(r,string.sub(str, last,str:len()))

	return r
end
