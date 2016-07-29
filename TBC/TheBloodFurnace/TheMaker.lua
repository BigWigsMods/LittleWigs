-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("The Maker", 725,555)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17381)
mod.toggleOptions = {30923}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MC", 30923)
	self:Death("Win", "BossDeath")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:MC(player, spellId, _, _, spellName)
	self:fMessage(30923, spellName..": "..player, "Important", spellId)
	self:Bar(30923, player..": "..spellName, 10, spellId) 
end
