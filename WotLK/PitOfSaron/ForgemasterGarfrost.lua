-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Forgemaster Garfrost", 602)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36494)
mod.toggleOptions = {
	70381, -- Deep Freeze
	{68789, "FLASHSHAKE"}, -- Boulder Throw
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["throw_message"] = "Saronite Boulder Incoming!"--@end-do-not-package@
--@localization(locale="enUS", namespace="Frozen_Halls/Forgemaster_Garfrost", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Freeze", 70381)
	self:Log("SPELL_AURA_REMOVED", "FreezeRemoved", 70381)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
	self:Death("Win", 36494)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Freeze(player, spellId, _, _, spellName)
	self:TargetMessage(70381, spellName, player, "Personal", spellId, "Alert")
	self:Bar(70381, player..": "..spellName, 14, spellId)
	self:PrimaryIcon(70381, player)
end

function mod:FreezeRemoved()
	self:PrimaryIcon(70381, false)
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(event, msg)
	self:LocalMessage(68789, L["throw_message"], "Personal", 68789)
	self:FlashShake(68789)
end
