-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Hex Lord Malacrass", 781)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(24239)
mod.toggleOptions = {
	43383, -- Spirit Bolts
	43501, -- Siphon Soul
	43548, -- Healing abilities
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SpiritBolts", 43383)
	self:Log("SPELL_AURA_APPLIED", "SoulSiphon", 43501)
	self:Log("SPELL_CAST_START", "Heal", 43548, 43451, 43431)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 24239)
end

function mod:OnEngage()
	self:Bar(43383, LW_CL["next"]:format(GetSpellInfo(43383)), 30, 43383)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SpiritBolts(_, spellId, _, _, spellName)
	self:Message(43383, spellName, "Important", spellId)
	self:Bar(43383, LW_CL["next"]:format(spellName), 30, spellId)
end

function mod:SoulSiphon(player, spellId, _, _, spellName)
	self:TargetMessage(43501, spellName, player, "Attention", spellId)
	self:Bar(43501, LW_CL["next"]:format(spellName), 60, spellId)
end

function mod:Heal(_, spellId, _, _, spellName)
	self:Message(43548, LW_CL["casting"]:format(spellName), "Urgent", spellId, "Alarm")
end

