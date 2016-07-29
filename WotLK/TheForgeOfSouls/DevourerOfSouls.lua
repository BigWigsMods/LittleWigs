-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Devourer of Souls", 601)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36502)
mod.toggleOptions = {
	69051, -- Mirrored Soul
	68912, -- Wailing Soul
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Mirror", 69051)
	self:Log("SPELL_AURA_REMOVED", "MirrorRemoved", 69051)
	self:Log("SPELL_AURA_APPLIED", "Wailing", 68912)
	self:Death("Win", 36502)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Mirror(unit, spellId, _, _, spellName)
	if unit == mod.displayName then return end
	self:TargetMessage(69051, spellName, unit, "Personal", spellId, "Alert")
	self:Bar(69051, unit..": "..spellName, 8, spellId)
	self:PrimaryIcon(69051, unit)
end

function mod:MirrorRemoved(unit, spellId, _, _, spellName)
	if unit == mod.displayName then return end
	self:PrimaryIcon(69051, false)
end

function mod:Wailing(player, spellId, _, _, spellName)
	self:Message(68912, spellName, "Important", spellId)
	self:Bar(68912, spellName, 15, spellId)
end
