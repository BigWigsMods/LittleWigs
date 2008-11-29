------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ionar"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ionar",

	overload = "Static Overload",
	overload_desc = "Warn for who has the Static Overload.",
	overload_message = "%s: Static Overload",

	overloadWhisper = "Static Overload Whisper",
	overloadWhisper_desc = "Send a whisper to the person with the Static Overload.",
	overloadWhisper_message = "You have the Static Overload!",

	overloadBar = "Static Overload Bar",
	overloadBar_desc = "Show a bar for who has the Static Overload.",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	overload = "Surcharge statique",
	overload_desc = "Prévient quand un joueur subit les effets de la Surcharge statique.",
	overload_message = "%s : Surcharge statique",

	overloadWhisper = "Surcharge statique - Chuchotement",
	overloadWhisper_desc = "Prévient par chuchotement la personne affectée par la Surcharge statique.",
	overloadWhisper_message = "Vous avez la Surchage statique !",

	overloadBar = "Surcharge statique - Barre",
	overloadBar_desc = "Affiche une barre indiquant la durée de la Surcharge statique de la personne affectée.",
} end)

L:RegisterTranslations("koKR", function() return {
	overload = "전하 과부하",
	overload_desc = "전하 과부하가 걸린 플레이어를 알립니다.",
	overload_message = "전하 과부하: %s",

	overloadWhisper = "전하 과부하 귓속말",
	overloadWhisper_desc = "전하 과부하에 걸린 플레이어에게 귓속말을 보냅니다.",
	overloadWhisper_message = "당신은 전하 과부하!",

	overloadBar = "전하 과부하 바",
	overloadBar_desc = "전하 과부하에 걸린 플레이어에게 지속되는 바를 표시합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	overload = "静电过载",
	overload_desc = "当玩家中了静电过载时发出警报。",
	overload_message = ">%s<：静电过载！",

	overloadWhisper = "静电过载密语",
	overloadWhisper_desc = "当玩家中了静电过载时发送密语。",
	overloadWhisper_message = ">你< 静电过载！",

	overloadBar = "静电过载计时条",
	overloadBar_desc = "当玩家中了静电过载时显示计时条。",
} end)

L:RegisterTranslations("zhTW", function() return {
	overload = "靜電超載",
	overload_desc = "當玩家中了靜電超載時發出警報。",
	overload_message = ">%s<：靜電超載！",

	overloadWhisper = "靜電超載密語",
	overloadWhisper_desc = "當玩家中了靜電超載時發送密語。",
	overloadWhisper_message = ">你< 靜電超載！",

	overloadBar = "靜電超載計時條",
	overloadBar_desc = "當玩家中了靜電超載時顯示計時條。",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	overload = "Статический заряд",
	overload_desc = "Предупреждать, когда кто-нибудь статически заряжен.",
	overload_message = "%s: Статически заряжен",

	overloadWhisper = "Шёпот о статическом заряде",
	overloadWhisper_desc = "Шептать, статически заряженному, участнику.",
	overloadWhisper_message = "Вы статически заряжены!",

	overloadBar = "Полоса статического заряда",
	overloadBar_desc = "Отображать полосу, для статически заряженных.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28546
mod.toggleoptions = {"overload","overloadWhisper","overloadBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Overload", 52658, 59795)
	self:AddCombatListener("SPELL_AURA_REMOVED", "OverloadRemoved", 52658, 59795)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Overload(player, spellId)
	if self.db.profile.overload then
		self:IfMessage(L["overload_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.overloadWhisper and (pName ~= player) then
		self:Whisper(player, L["overloadWhisper_message"])
	end	
	if self.db.profile.overloadBar then
		self:Bar(L["overload_message"]:format(player), 10, spellId)
	end
end

-- I don't have any logs for this instance yet. I suspect this is not dispellable, if it is not,
-- then we don't need the remove, please verify
function mod:OverloadRemoved(player)
	if self.db.profile.overloadBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["overload_message"]:format(player))
	end
end
