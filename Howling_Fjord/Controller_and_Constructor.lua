------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Constructor & Controller"]

local constructor = BB["Skarvald the Constructor"]
local controller = BB["Dalronn the Controller"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local controllerDead = nil
local constructorDead = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "ConstructorController",

	enfeeble = "Enfeeble",
	enfeeble_desc = "Warn for who is in the Enfeeble.",
	enfeeble_message = "Enfeeble: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	enfeeble = "쇠약",
	enfeeble_desc = "쇠약의 대상자를 알립니다.",
	enfeeble_message = "쇠약: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	enfeeble = "Débiliter",
	enfeeble_desc = "Prévient quand un joueur subit les effets de Débiliter.",
	enfeeble_message = "Débiliter : %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	enfeeble = "衰弱",
	enfeeble_desc = "當玩家中了衰弱時發出警報。",
	enfeeble_message = "衰弱：>%s<！",
} end )

L:RegisterTranslations("deDE", function() return {
	enfeeble = "Entkräften",
	enfeeble_desc = "Warnt, wer Entkräften hat.",
	enfeeble_message = "Entkräften: %s",
} end )

L:RegisterTranslations("zhCN", function() return {
	enfeeble = "衰弱",
	enfeeble_desc = "当玩家中了衰弱时发出警报。",
	enfeeble_message = "衰弱：>%s<！",
} end )

L:RegisterTranslations("ruRU", function() return {
	enfeeble = "Ослабление",
	enfeeble_desc = "Предупреждать, когда на кого-нибудь накладывается ослабление.",
	enfeeble_message = "Ослаблен: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Keep"]
mod.enabletrigger = {constructor, controller} 
mod.toggleoptions = {"enfeeble", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Enfeeble", 43650)

	controller = nil
	constructor = nil
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:BossDeath(source)
	if not self.db.profile.bosskill then return end
	if source == constructor then
		constructorDead = true
	end
	if source == controller then
		controllerDead = true
	end
	if controllerDead and constructorDead then
		self:GenericBossDeath(boss, true)
	end
end

function mod:Enfeeble(player, spellId)
	if self.db.profile.enfeeble then
		self:IfMessage(L["enfeeble_message"]:format(player), "Attention", spellId)
		self:Bar(L["enfeeble_message"]:format(player, spellName), 6, spellID)
	end
end
