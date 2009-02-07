----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Zuramat the Obliterator"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 29314
mod.toggleoptions = {"voidShift", "voidShiftBar", -1, "darkness", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dalaran/Zuramat_the_Obliterator", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "VoidShift", 54361, 59743)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Darkness", 54524, 59745)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:VoidShift(player, spellId)
	if self.db.profile.voidShift then
		local other = L["voidShift_other"]:format(player)
		if player == pName then
			self:Message(L["voidShift_you"], "Personal", true, "Alert", nil, spellId)
			self:Message(other, "Attention", nil, nil, true)
		else
			self:Message(other, "Attention", nil, nil, nil, spellId)
			self:Whisper(player, L["voidShift_you"])
		end
		self:Icon(player, "icon")
		if self.db.profile.voidShiftBar then
			self:Bar(other, 15, spellId)
		end
	end
end

function mod:Darkness(_, spellId)
	if self.db.profile.darkness then
		self:IfMessage(L["darkness_message"], "Important", spellId)
	end
end
