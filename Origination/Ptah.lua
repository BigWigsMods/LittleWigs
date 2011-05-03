-- XXX Ulic: When last I did this on NORMAL it didn't need any warnings
--[[
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Earthrager Ptah", 759)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39428)
mod.toggleOptions = {"bosskill"}
mod.optionHeaders = {
	bosskill = "general",
}

-------------------------------------------------------------------------------
--  Locals

local deaths = 0

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Deaths", 39428)
end

function mod:OnEngage()
	deaths = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 2 then
		self:Win()
	end
end
]]

