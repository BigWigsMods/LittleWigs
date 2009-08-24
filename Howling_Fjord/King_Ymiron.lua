----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["King Ymiron"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26861
mod.toggleOptions = {"bane", "baneBar", -1, "rot", "rotBar", "bosskill"}


--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Howling_Fjord/King_Ymiron", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Bane", 48294, 59301)
	self:AddCombatListener("SPELL_AURA_APPLIED", "BaneAura", 48294, 59301)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BaneAuraRemoved", 48294, 59301)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Rot", 48291, 59300)
	self:AddCombatListener("SPELL_AURA_REMOVED", "RotRemoved", 48291, 59300)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Bane(_, spellId, _, _, spellName)
	if self.db.profile.bane then
		self:IfMessage(L["bane_message"], "Urgent", spellId)
	end
end

function mod:BaneAura(player, spellId, _, _, spellName)
	if player ~= boss then return end
	if self.db.profile.baneBar then
		self:Bar(spellName, 5, spellId)
	end
end

function mod:BaneAuraRemoved(player, spellId, _, _, spellName)
	if player ~= boss then return end
	if self.db.profile.bane then
		self:IfMessage(L["bane_ended"], "Positive", spellId)
	end
	if self.db.profile.baneBar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Rot(player, spellId, _, _, spellName)
	if self.db.profile.rot then
		self:IfMessage(L["rot_message"]:format(spellName, player), "Urgent", spellId)
	end
	if self.db.profile.rotBar then
		self:Bar(L["rot_message"]:format(spellName, player), 9, spellId)
	end
end

function mod:RotRemoved(player, _, _, _, spellName)
	if self.db.profile.rotBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["rot_message"]:format(spellName, player))
	end
end
