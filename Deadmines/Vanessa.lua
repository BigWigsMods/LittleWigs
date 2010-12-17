-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Vanessa VanCleef", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(49541)
mod.toggleOptions = {
	92614,
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Deflection", 92614)

	self:Death("Win", 49541) -- Possibly 42371
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Deflection(_, spellId, _, _, spellName)
	self:Message(92614, spellName, "Urgent", spellId)
	self:Bar(92614, spellName, 10, spellId)
end