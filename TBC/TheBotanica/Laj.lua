------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Laj"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Laj",

	allergic = "Allergic Reaction",
	allergic_desc = "Warn for Allergic Reaction",
	allergic_message = "%s is Allergic!",
} end )

L:RegisterTranslations("koKR", function() return {
	allergic = "알레르기 반응",
	allergic_desc = "알레르기 반응에 대해 알립니다.",
	allergic_message = "%s 알레르기!",
} end )

L:RegisterTranslations("zhTW", function() return {
	allergic = "過敏反應",
	allergic_desc = "過敏反應警報",
	allergic_message = "過敏反應: [%s]",
} end )

L:RegisterTranslations("zhCN", function() return {
	allergic = "过敏反应",
	allergic_desc = "当受到过敏反应时发出警告。",
	allergic_message = "过敏反应：>%s<！",
} end )

L:RegisterTranslations("frFR", function() return {
	allergic = "Réaction allergique",
	allergic_desc = "Prévient quand un joueur subit les effets de la Réaction allergique.",
	allergic_message = "Réaction allergique sur %s !",
} end )

L:RegisterTranslations("deDE", function() return {
	allergic = "Allergische Reaktion",
	allergic_desc = "Warnt vor Allergischer Reaktion",
	allergic_message = "%s ist allergisch!",
} end )

L:RegisterTranslations("ruRU", function() return {
	allergic = "Аллергическая реакция",
	allergic_desc = "Предупреждать о Аллергической реакции.",
	allergic_message = "%s Аллергичен!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Botanica"]
mod.enabletrigger = boss 
mod.guid = 17980
mod.toggleOptions = {"allergic"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Allergies", 34697)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Allergies(player)
	if self.db.profile.allergic then
		self:IfMessage(L["allergic_message"]:format(player), "Important", 34697)
	end
end

