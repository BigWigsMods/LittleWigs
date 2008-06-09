------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mennu the Betrayer"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Mennu",
	
	totem = "Nova Totem",
	totem_desc = "Warn when a Corrupted Nova Totem is casted.",
	totem_message = "Corrupted Nova Totem!",
} end )

L:RegisterTranslations("koKR", function() return {
	totem = "토템",
	totem_desc = "타락의 회오리 토템 시전시 알립니다.",
	totem_message = "타락의 회오리 토템!",
} end )

L:RegisterTranslations("zhCN", function() return {
	totem = "堕落新星图腾",
	totem_desc = "当施放堕落新星图腾时发出警报。",
	totem_message = "堕落新星图腾！",
} end )

L:RegisterTranslations("zhTW", function() return {
	totem = "墮落新星圖騰",
	totem_desc = "當施放墮落新星圖騰時發出警報",
	totem_message = "墮落新星圖騰!",
} end )

L:RegisterTranslations("frFR", function() return {
	totem = "Totem Nova corrompu",
	totem_desc = "Prévient quand un Totem Nova corrompu est posé.",
	totem_message = "Totem Nova corrompu !",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = BZ["The Slave Pens"]
mod.enabletrigger = boss
mod.toggleoptions = {"totem", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_SUMMON", "Totem", 31991)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Totem()
	if db.totem then
		self:IfMessage(L["totem_message"], "Attention", 31991)
	end
end
