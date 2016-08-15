-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Talon King Ikiss", 723, 543)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18473)
mod.toggleOptions = {
	38197, -- Arcane Explosion
	{38245, "ICON"}, -- Polymorph
}

-------------------------------------------------------------------------------
--  Locals

local aeName = GetSpellInfo(38197)

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AE", 38194)
	self:Log("SPELL_AURA_APPLIED", "Poly", 38245, 43309)
	self:Log("SPELL_AURA_REMOVED", "PolyRemoved", 38245, 43309)
	self:Death("Win", 18473)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:AE()
	self:Message(38197, CL["casting"]:format(aeName), "Urgent", 38197)
end

function mod:Poly(player, spellId, _, _, spellName)
	self:Message(38245, spellName..": "..player, "Attention", spellId)
	self:Bar(38245, player..": "..spellName, 6, spellId)
	self:PrimaryIcon(38245, player, "icon")
end

function mod:PolyRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
	self:PrimaryIcon(38245, false)
end
