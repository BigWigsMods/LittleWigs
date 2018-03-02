-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Erekem", 536)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(29315, 32226)
mod.toggleOptions = {
	54481, -- Chain Heal
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChainHeal", 54481, 59473)
	self:Death("Win", 29315, 32226)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ChainHeal(_, spellId, _, _, spellName)
	self:Message(54481, CL["casting"]:format(spellName), "Urgent", spellId)
end
