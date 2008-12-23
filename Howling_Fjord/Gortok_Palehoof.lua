------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Gortok Palehoof"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Gortok",
	
	roar = "Withering Roar",
	roar_desc = "Show the Withering Roar timer bar.",
	roarcooldown_bar = "Roar cooldown",
	
	impale = "Impale",
	impale_desc = "Warn who has Impale.",
	impale_message = "%s: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	roar = "부패의 포효",
	roar_desc = "부패의 포효 타이머 바를 표시합니다.",
	roarcooldown_bar = "포효 대기시간",
	
	impale = "꿰뚫기",
	impale_desc = "꿰뚫기에 걸린 플레이어를 알립니다.",
	impale_message = "%s: %s",
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26687
mod.toggleoptions = {"impale", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Roar", 48256, 59267)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Impale", 48261, 59268)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Roar(_, spellId, _, _, spellName)
	if self.db.profile.roar then
		self:IfMessage(spellName, "Urgent", spellId)
		self:Bar(L["roarcooldown_bar"], 10, spellId)
	end
end

function mod:Impale(player, spellId, _, _, spellName)
	if self.db.profile.impale then
		self:IfMessage(L["impale_message"]:format(spellName, player), "Attention", spellId)
	end
end
