------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Slad'ran"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Slad'ran",

	poison = "Poison Nova",
	poison_desc = "Warn when a player has the Poison Nova debuff.",
	poison_message = "Poison Nova: %s",

	poisonBar = "Poison Nova Bar",
	poisonBar_desc = "Display a bar for the duration of Poison Nova debuff.",
} end )

L:RegisterTranslations("koKR", function() return {
	poison = "독 회오리",
	poison_desc = "독 회오리 디버프에 걸린 플레이어를 알립니다.",
	poison_message = "독 회오리: %s",

	poisonBar = "독 회오리 바",
	poisonBar_desc = "독 회오리 디버프가 지속되는 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	poison = "Nova de poison",
	poison_desc = "Prévient quand un joueur subit les effets de la Nova de poison.",
	poison_message = "Nova de poison : %s",

	poisonBar = "Nova de poison - Barre",
	poisonBar_desc = "Affiche une barre indiquant la durée de la Nova de poison.",
} end )

L:RegisterTranslations("zhTW", function() return {
	poison = "劇毒新星",
	poison_desc = "當玩家中了劇毒新星減益時發出警報。",
	poison_message = ">%s<：劇毒新星！",

	poisonBar = "劇毒新星計時條",
	poisonBar_desc = "當劇毒新星減益持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	poison = "毒性新星",
	poison_desc = "当玩家中了毒性新星减益时发出警报。",
	poison_message = ">%s<：毒性新星！",

	poisonBar = "毒性新星计时条",
	poisonBar_desc = "当毒性新星减益持续时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	poison = "Ядовитая звезда",
	poison_desc = "Предупреждать когда игрок получает дебафф Ядовитой звезды.",
	poison_message = "Ядовитая звезда: %s",

	poisonBar = "Полоса Ядовитой звезды",
	poisonBar_desc = "Отображать полосу продолжительности дебаффа Ядовитой звезды.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Gundrak"]
mod.enabletrigger = boss 
mod.guid = 29304
mod.toggleoptions = {"poison", "poisonBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Poison", 55081, 59842)
	self:AddCombatListener("SPELL_AURA_REMOVED", "PoisonRemoved", 55081, 59842)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Poison(player, spellId, _, _, spellName)
	if self.db.profile.poison then
		self:IfMessage(L["poison_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.poisonBar then
		self:Bar(L["poison_message"]:format(player), 6, spellId)
	end
end

function mod:PoisonRemoved(player)
	if self.db.profile.poisonBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["poison_message"]:format(player))
	end
end
