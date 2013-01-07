AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")
include("db.lua")

function GM:PlayerConnect(name, ip)
	print ("Player " .. name .. "has joined the game.")
end

function GM:PlayerInitialSpawn(ply)
	print ("Player " .. ply:Nick() .. "has spawned.")
end

function GM:PlayerSpawn(ply)
	ply:SetModel("models/player/group01/male_07.mdl")
end

function GM:PlayerAuthed(ply, steamID, uniqueID)
	print ("Player " .. ply:Nick() .. "has authenticated.")
end
