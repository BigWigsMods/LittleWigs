-- XXX Ulic: The one time I tried it, people thought he was bugged, so aftet
-- XXX one attempt we gave up, would be nice to know who he's chasing if during
-- XXX the WW if it's possible to detect

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Augh", "Lost City of the Tol'vir")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(49045)
mod.toggleOptions = {
	84784,
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 84784)

	self:Death("Win", 49045)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Whirlwind(_, spellId, _, _, spellName)
	self:Message(84784, spellName, "Important", spellId)
	self:Bar(84784, spellName, 20, spellId)
end

