-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Mennu the Betrayer", 728, 570)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(17941)
mod.toggleOptions = {
	31991,
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "Totem", 31991)
	self:Death("Win", 17941)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Totem(_, spellId, _, _, spellname)
	self:Message(31991, spellname, "Attention", spellId)
end
