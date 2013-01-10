-- AddCSLuaFile( String FileName )
-- Sending to the clients the files they need
-- http://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/indexe9af-2.html
--
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

-- 	include( String Filename )
--
include("utilities/install.lua")
include("shared.lua")
include("utilities/db.lua")

-- GM:PlayerConnect( String name, String address ) 
-- Called whenever a player connects
-- http://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index0d60.html
--
function GM:PlayerConnect(name, ip)
	print ("Player " .. name .. "has joined the game.")
end

--  GM:PlayerInitialSpawn( Player Player )
--  Is called when the player first spawns into the world. 
--  http://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index2901.html
--
function GM:PlayerInitialSpawn(ply)
	print ("Player " .. ply:Nick() .. "has spawned.")
end

--  GM:PlayerSpawn( Player Player ) 
--  Called whenever a player respawns. 
--  http://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index249d.html
--
function GM:PlayerSpawn(ply)
	ply:SetModel("models/player/group01/male_07.mdl")
end

--  GM:PlayerAuthed( Player ply, String SteamID, Integer UniqueID ) 
--  Called whenever the player is Authed with Steam and recieves the SteamID 
--  http://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/indexc4b1.html
--
function GM:PlayerAuthed(ply, steamID, uniqueID)
	print ("Player " .. ply:Nick() .. "has authenticated.")
end
