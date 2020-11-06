--[[
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lord Ahune", 547)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.RegisterEnableMob(25740, 25697)
mod.toggleOptions = {
	"state",
}

-------------------------------------------------------------------------------
--  Locals

local standing = nil

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["state"] = "State"
	L["state_desc"] = "Display information about the state of Ahune (Submerged/Emerged)"
	L["attack_message"] = "Ahune is Attackable"
	L["stand_message"] = "Ahune Emerged"
	L["stand_soon"] = "Emerge Soon"
	L["submerge_message"] = "Ahune Submerged"
	L["submerge_soon"] = "Submerge Soon"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_REMOVED", "Submerge", 45954)
	self:Log("SPELL_AURA_REMOVED", "Attack", 45954)
	self:Log("SPELL_AURA_APPLIED", "Stand", 45954)
	self:Death("Win", 25740)
end

function mod:OnEngage()
	standing = false
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Submerge()
	self:MessageOld("state", L["submerge_message"], "yellow")
	self:Bar("state", L["submerge_message"], 39)
	self:DelayedMessage("state", 29, L["stand_soon"], "yellow")
	standing = false
end

function mod:Stand()
	self:MessageOld("state", L["stand_message"], "yellow")
	self:Bar("state", L["stand_message"], 94)
	self:DelayedMessage("state", 86, L["submerge_soon"], "yellow")
	standing = true
end

function mod:Attack()
	self:MessageOld("state", L["attack_message"], "yellow")
	self:Bar("state", L["attack_message"], 45)
	standing = false
end
]]
