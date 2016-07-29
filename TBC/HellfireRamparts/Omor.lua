-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Omor the Unscarred", 797, 528)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17308)
mod.toggleOptions = {{30695, "ICON", "WHISPER"}}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Curse", 30695, 37566, 37567, 39298) -- verify 37566(Bane of Treachery) on heroic 
	self:Log("SPELL_AURA_REMOVED", "CurseRemove", 30695, 37566, 37567, 39298) -- verify 37566(Bane of Treachery) on heroic
	self:Death("Win", 17308)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Curse(player, spellId, _, _, spellName)
	self:Message(30695, spellName..": "..player, "Urgent", spellId)
	self:Bar(30695, player..": "..spellName, 15, spellId)
	self:Whisper(30695, player, spellName)
	self:PrimaryIcon(30695, player)
end

function mod:CurseRemove(player, spellId, _, _, spellName)
	self:PrimaryIcon(30695, false)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
