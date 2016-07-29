-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Varos Cloudstrider", 528)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27447)
mod.toggleOptions = {
	51054, -- Amplify Magic
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "AmplifyMagic", 51054, 59371)
	self:Log("SPELL_AURA_REMOVED", "AmplifyMagicRemoved", 51054, 59371)
	self:Death("Win", 27447)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:AmplifyMagic(player, spellId, _, _, spellName)
	self:Message(51054, spellName..": "..player, "Important", spellId)
	self:Bar(51054, player..": "..spellName, 30, spellId)
end

function mod:AmplifyMagicRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
