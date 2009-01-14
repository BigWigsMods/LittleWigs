------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Constructor & Controller"]

local constructor = BB["Skarvald the Constructor"]
local controller = BB["Dalronn the Controller"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local deaths = 0

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "ConstructorController",

	debilitate = "Debilitate",
	debilitate_desc = "Warn for who is Debilitated.",
	debilitate_message = "Debilitate: %s",

	debilitateBar = "Debilitate Bar",
	debilitateBar_desc = "Show a bar for the duration of the Debilitate.",
} end )

L:RegisterTranslations("koKR", function() return {
	debilitate = "쇠약",
	debilitate_desc = "쇠약의 대상자를 알립니다.",
	debilitate_message = "쇠약: %s",
	
	debilitateBar = "쇠약 바",
	debilitateBar_desc = "쇠약이 지속되는 바를 표시합니다..",
} end )

L:RegisterTranslations("frFR", function() return {
	debilitate = "Débiliter",
	debilitate_desc = "Prévient quand un joueur subit les effets de Débiliter.",
	debilitate_message = "Débiliter : %s",

	debilitateBar = "Débiliter - Barre",
	debilitateBar_desc = "Affiche une barre indiquant la durée du Débiliter.",
} end )

L:RegisterTranslations("zhTW", function() return {
	debilitate = "衰弱",
	debilitate_desc = "當玩家中了衰弱時發出警報。",
	debilitate_message = "衰弱：>%s<！",

	debilitateBar = "衰弱計時條",
	debilitateBar_desc = "當衰弱持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
	debilitate = "Entkräften",
	debilitate_desc = "Warnt, wer Entkräften hat.",
	debilitate_message = "Entkräften: %s",
} end )

L:RegisterTranslations("zhCN", function() return {
	debilitate = "衰弱",
	debilitate_desc = "当玩家中了衰弱时发出警报。",
	debilitate_message = "衰弱：>%s<！",

	debilitateBar = "衰弱计时条",
	debilitateBar_desc = "当衰弱持续时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	debilitate = "Ослабление",
	debilitate_desc = "Предупреждать, когда на кого-нибудь накладывается ослабление.",
	debilitate_message = "%s: ослаблен!",
	
	debilitateBar = "Полоса ослабления",
	debilitateBar_desc = "Отображение полосы продолжительности ослабления.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Keep"]
mod.enabletrigger = {constructor, controller} 
mod.guid = 24200
mod.toggleoptions = {"debilitate", "debilitateBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "Deaths")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Enfeeble", 43650)

	deaths = 0	
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Deaths(_, guid)
	if not self.db.profile.bosskill then return end
	guid = tonumber((guid):sub(-12,-7),16)
	if guid == self.guid or guid == 24201 then
		deaths = deaths + 1
	end
	if deaths == 2 then
		self:GenericBossDeath(boss, true)
	end
end

function mod:Enfeeble(player, spellId)
	if self.db.profile.debilitate then
		self:IfMessage(L["debilitate_message"]:format(player), "Attention", spellId)
	end
	if self.db.profile.debilitateBar then
		self:Bar(L["debilitate_message"]:format(player), 8, spellId)
	end
end
