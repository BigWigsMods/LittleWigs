-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Commander Springvale", "Shadowfang Keep")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(4278)
mod.toggleOptions = {
	93687, -- Desecration
	93736, -- Shield of the Perfidious
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Desecration", 93687)
	self:Log("SPELL_AURA_APPLIED", "Shield", 93736)

	self:Death("Win", 4278)
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Desecration(_, spellId, _, _, spellName)
	self:Message(93687, spellName, "Info", spellId)
end

function mod:Shield(_, spellId, _, _, spellName)
	self:Message(93736, spellName, "Alert", spellId)
end