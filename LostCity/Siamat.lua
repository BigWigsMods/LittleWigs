-- XXX Ulic: Other suggestions?  This guy really sucked for my HEROIC group
-- XXX Second time I ran it on heroic (w/Raid Pre-Made) it was a lot easier.
-- XXX I didn't notice any storm clouds like what I thought Gathering Storms
-- XXX was though, right now that warning is seeming pointless, I'm not sure
-- XXX it can be avoided.

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Siamat", "Lost City of the Tol'vir")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(44819)
mod.toggleOptions = {
	{90011, "FLASHSHAKE"}, -- Gathered Storms
	"servant",
	"phase",
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local adds = 0

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["engage_trigger"] = "Winds of the south, rise and come to your master's aid!"
L["phase"] = "Phase 2"
L["phase_desc"] = "Warn when Siamat is close to phase 2."
L["phase_warning"] = "Phase 2 soon!"
L["servant"] = "Summon Servant"
L["servant_desc"] = "Warn when a Servant of Siamat is summoned."
L["servant_message"] = "Servant of Siamat Summoned!"--@end-do-not-package@
--@localization(locale="enUS", namespace="Tol_vir/Siamat", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()
BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	--self:Death("Adds", 45268, 45269, 45259)
	self:Log("SPELL_DAMAGE", "Storm", 90011, 94987)
	self:Log("SPELL_SUMMON", "Servant", 90013, 84553)
	
	self:Yell("Engage", L["engage_trigger"])
	
	self:Death("Win", 44819)
end

function mod:OnEngage()
	adds = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

local last = 0
function mod:Storm(player, spellId, _, _, spellName)
	local time = GetTime()
	if (time - last) > 2 then
		last = time
		if UnitIsUnit(player, "player") then
			self:LocalMessage(90011, BCL["you"]:format(spellName), "Personal", spellId, "Info")
			self:FlashShake(90011)
		end
	end
end

function mod:Servant(_, spellId)
	adds = adds + 1
	if adds == 3 then
		self:Message("phase", L["phase_warning"], "Positive")
		adds = 0
	end
	self:Message(90013, L["servant_message"], "Important", spellId, "Alert")
end
