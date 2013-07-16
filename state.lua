--[[states.lua   Created by: Michael Groll
games states for Pong

Functions: new, activate, getActive
--------------------------------------------]]
gameStates = {}

State = {}
local State.__index = State

function State:new(name)
	local name = setmetatable( {{, State )
	
	name.active = false
	
	return name
end

function State:load()
	--[[GAME STATES -----]]
	gameStates[#gameStates+1] = State:new("title")
	gamesStates.title.active = true
	gameStates[#gameStates+1] = State:new("live")
	gameStates[#gameStates+1] = State:new("paused")
end