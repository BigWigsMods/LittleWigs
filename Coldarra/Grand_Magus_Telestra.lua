------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Grand Magus Telestra"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local split1announced = nil
local split2announced = nil
local difficulty

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Coldarra/Grand_Magus_Telestra", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Nexus"]
mod.enabletrigger = {boss} 
mod.guid = 26731
mod.toggleoptions = {"split", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("UNIT_HEALTH")

	split1announced = nil
	split2announced = nil

	difficulty = GetInstanceDifficulty()
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.split then return end
	if UnitName(arg1) == boss then
		local currentHealth = UnitHealth(arg1)
		local maxHealth = UnitHealthMax(arg1)
		local percentHealth = (currentHealth/maxHealth)*100
		if percentHealth > 51 and percentHealth <= 54 and not split1announced then
			self:Message(L["split_soon_message"], "Attention")
			split1announced = true
		elseif difficulty == 2 and not split2announced and perecentHealth > 11 and precentHealth <= 14 then
			self:Message(L["split_soon_message"], "Attention")
			split2announced = true
		elseif percentHealth > 60 and (split1announced or split2announced) then
			split1announced = false
			split2announced = false
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L["split_trigger1"] or msg == L["split_trigger2"]) then
		if self.db.profile.split then
			self:IfMessage(L["split_message"], "Important", 19569)
		end
	elseif msg == L["merge_trigger"] then
		if self.db.profile.split then
			self:Message(L["merge_message"], "Important")
		end
	end
end

