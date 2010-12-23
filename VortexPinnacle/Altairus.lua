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
	88308, -- Breath
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Upwind", 88282)
	self:Log("SPELL_AURA_APPLIED", "Downwind", 88286)
	self:Log("SPELL_CAST_START", "Breath", 88308, 93989)

	self:Death("Win", 43873)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Upwind(unit, spellId, _, _, spellName)
	if UnitIsUnit("player", unit) then
		self:LocalMessage(88282, spellName, "Positive", "Info", spellId)
	end
end

function mod:Downwind(unit, spellId, _, _, spellName)
	if UnitIsUnit("player", unit) then
		self:LocalMessage(88286, spellName, "Attention", "Alert", spellId)
	end
end

function mod:Breath(_, spellId, _, _, spellName)
	self:Bar(88308, LW_CL["next"]:format(spellName), 12, spellId)
	self:TargetMessage(88308, spellName, UnitTarget("boss1"), "Urgent", spellId)
end

