-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Slad'ran", "Gundrak")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(29304)
mod.toggleOptions = {
	55081, -- Poison Nova
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PoisonCast", 55081, 59842)
	self:Log("SPELL_AURA_APPLIED", "Poison", 55081, 59842)
	self:Log("SPELL_AURA_REMOVED", "PoisonRemoved", 55081, 59842)
	self:Death("Win", 29304)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:PoisonCast(_, _, _, _, spellName)
	self:Message(55081, LCL["casting"]:format(spellName), "Attention", spellId)
	self:Bar(55081, spellName, 3.5, spellId)
end

function mod:Poison(player, spellId, _, _, spellName)
	self:Message(55081, spellName..": "..player, "Urgent", spellId)
	self:Bar(55081, player..": "..spellName, 6, spellId)
end

function mod:PoisonRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
