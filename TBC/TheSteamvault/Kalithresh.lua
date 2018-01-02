-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Warlord Kalithresh", 727, 575)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17798)
mod.toggleOptions = {
	38592, -- Use a different ID that has a better tooltip
	31543, -- Warlord's Rage
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["engage_message"] = "Engaged - channeling in ~15sec!"
	L["rage_message"] = "Warlord is channeling!"
	L["rage_soon"] = "Channeling Soon"
	L["rage_soonbar"] = "~Possible channeling"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Reflection", 31534)
	self:Log("SPELL_CAST_SUCCESS", "Channel", 31543)
	self:Death("Win", 17798)

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

function mod:OnEngage()
	self:Message(31543, L["engage_message"], "Attention", 31543)
	self:Bar(31543, L["rage_soonbar"], 15, 31543)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Channel()
	self:Message(31543, L["rage_message"], "Urgent", 31543)
	self:Bar(31543, L["rage_soonbar"], 40, 31543)
	self:DelayedMessage(31543, 35, L["rage_soon"], "Urgent")
end

function mod:Reflection(_, _, _, _, spellName)
	self:Message(38592, spellName, "Attention", 31534)
	self:Bar(38592, spellName, 8, 31534)
end
