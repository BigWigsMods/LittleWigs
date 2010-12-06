-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Altairus", "The Vortex Pinnacle")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43873)
mod.toggleOptions = {
	88286, -- Downwind of Altairus
	88282, -- Upwind of Altairus
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals
local pName = GetUnitName("player")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Upwind", 88282)
	self:Log("SPELL_AURA_APPLIED", "Downwind", 88286)

	self:Death("Win", 43873)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Upwind(unit, spellId, _, _, spellName)
	if pName == GetUnitName(unit) then
		self:Message(88286, spellName, "Positive", spellId, "Info")
	end
end

function mod:Downwind(unit, spellId, _, _, spellName)
	if pName == GetUnitName(unit) then
		self:Message(88286, spellName, "Attention", spellId, "Alert")
	end
end