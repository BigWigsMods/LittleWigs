------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Amanitar"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Amanitar",

	mini = "Mini",
	mini_desc = "Warn when you have the Mini debuff.",
	mini_message = "You are Mini",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
} end)

L:RegisterTranslations("koKR", function() return {
	mini = "축소",
	mini_desc = "당신의 축소 디버프를 알립니다.",
	mini_message = "당신은 축소",
} end)

L:RegisterTranslations("zhCN", function() return {
	mini = "迷你",
	mini_desc = "当你中了迷你减益时发出警报。",
	mini_message = ">你< 迷你！",
} end)

L:RegisterTranslations("zhTW", function() return {
	mini = "迷你化",
	mini_desc = "當你中了迷你化減益時發出警報。",
	mini_message = ">你< 迷你化！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	mini = "Мини",
	mini_desc = "Сообщает если вы получаете дебафф Мини.",
	mini_message = "На вас Мини",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 30258
mod.toggleoptions = {"mini", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Mini", 57055)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Mini(_, spellId)
	if self.db.profile.mini then
		self:LocalMessage(L["mini_message"], "Personal", spellId)
	end
end
