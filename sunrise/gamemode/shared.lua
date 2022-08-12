GM.Name 	= "Sunrise - Space"
GM.Author 	= "BardWire - Sunrise Team"
GM.Version	= ""
GM.Folder = "sunrise"

print( "[NetWrapper] Initializing netwrapper library" )

local base = "netvars/"

if ( SERVER ) then

	-- Server functions
	include( base .. "sv_netwrapper.lua" )

	-- Shared functions
	include( base .. "sh_netwrapper.lua" )

	-- Client functions
	AddCSLuaFile( base .. "cl_netwrapper.lua" )
	
elseif ( CLIENT ) then
	
	-- Shared functions
	include( base .. "sh_netwrapper.lua" )

	-- Client functions
	include( base .. "cl_netwrapper.lua" )
	
end