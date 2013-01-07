schema = {}

-- Load Abstracted DB Schema
include("../modules/player/playerdb.lua")
include("../modules/groups/groupsdb.lua")
include("../modules/characters/charactersdb.lua")

for i,v in pairs(schema) do
	print (i, v)
	for j,k in pairs(v) do
		print (j,k)
		if type(k) == 'table'  then
			for l,m in pairs(k) do
				print (l,m)
				if type(m) == 'table' then
					for n,o in pairs(m) do
						print (n,o)
					end
				end
			end	
		end
	end
end
