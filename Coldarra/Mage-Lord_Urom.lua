------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mage-Lord Urom"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Urom",

	timeBomb = "Time Bomb",
	timeBomb_desc = "Warning for who has the Time Bomb.",
	timeBomb_message = "%s: Time Bomb",

	timeBombWhisper = "Time Bomb Whisper",
	timeBombWhisper_desc = "Send a whisper to the person with the Time Bomb.",
	timeBombWhisper_message = "You have the Time Bomb!",

	timeBombBar = "Time Bomb Bar",
	timeBombBar_desc = "Show a bar until the Time Bomb explodes.",

	arcaneExplosion = "Empowered Arcane Explosion",
	arcaneExplosion_desc = "Warn when Mage-Lord Urom begins to cast Empowered Arcane Explosion.",

	arcaneExplosionBar = "Empowered Arcane Explosion Bar",
	arcaneExplosionBar_desc = "Show a bar for the cast time of Empowered Arcane Explosion.",
} end )

L:RegisterTranslations("koKR", function() return {
	timeBomb = "냉기 폭탄",
	timeBomb_desc = "냉기 폭탄에 걸린 플레이어를 알립니다..",
	timeBomb_message = "냉기 폭탄: %s",

	timeBombWhisper = "냉기 폭탄 귓속말",
	timeBombWhisper_desc = "냉기 폭탄에 걸린 플레이어에게 귓속말을 보냅니다.",
	timeBombWhisper_message = "당신은 냉기 폭탄!",

	timeBombBar = "냉기 폭탄 바",
	timeBombBar_desc = "냉기 폭탄이 지속되는 바를 표시합니다.",

	arcaneExplosion = "신비한 폭발 강화",
	arcaneExplosion_desc = "마법사 군주 우롬의 신비한 폭발 강화 시전을 알립니다.",

	arcaneExplosionBar = "신비한 폭발 강화 바",
	arcaneExplosionBar_desc = "신비한 폭발 강화 시전 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	timeBomb = "Bombe à retardement",
	timeBomb_desc = "Prévient quand un joueur subit les effets de la Bombe à retardement.",
	timeBomb_message = "%s : Bombe à retardement",

	timeBombWhisper = "Bombe à retardement - Chuchotement",
	timeBombWhisper_desc = "Prévient par chuchotement la personne affectée par la Bombe à retardement.",
	timeBombWhisper_message = "Vous avez la Bombe à retardement !",

	timeBombBar = "Bombe à retardement - Barre",
	timeBombBar_desc = "Affiche une barre indiquant le temps restant avant l'explosion de la Bombe à retardement.",

	arcaneExplosion = "Explosion des arcanes surpuissante",
	arcaneExplosion_desc = "Prévient quand le Seigneur-mage Urom commence à incanter son Explosion des arcanes surpuissante.",

	arcaneExplosionBar = "Explosion des arcanes surpuissante - Barre",
	arcaneExplosionBar_desc = "Affiche une barre indiquant la durée de l'incantation de l'Explosion des arcanes surpuissante.",
} end )

L:RegisterTranslations("zhTW", function() return {
	timeBomb = "時間爆彈",
	timeBomb_desc = "當玩家中了時間爆彈時發出警報。",
	timeBomb_message = ">%s<：時間爆彈！",

	timeBombWhisper = "時間爆彈密語",
	timeBombWhisper_desc = "當玩家中了時間爆彈時發送密語。",
	timeBombWhisper_message = ">你< 時間爆彈！",

	timeBombBar = "時間爆彈計時條",
	timeBombBar_desc = "顯示時間爆彈爆炸計時條。",

	arcaneExplosion = "強力魔爆術",
	arcaneExplosion_desc = "當法師領主厄隆開始施放強力魔爆術時發出警報。",

	arcaneExplosionBar = "強力魔爆術計時條",
	arcaneExplosionBar_desc = "顯示強力魔爆術計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
	timeBomb = "Zeitbombe",
	timeBomb_desc = "Warnung wer die Zeitbombe hat.",
	timeBomb_message = "%s: Zeitbombe",

	timeBombWhisper = "Zeitbombe anfl\195\188stern",
	timeBombWhisper_desc = "Einen Whisper an die Person mit der Zeitbombe senden.",
	timeBombWhisper_message = "Du hast die Zeitbombe!",

	timeBombBar = "Zeitbombe-Anzeige",
	timeBombBar_desc = "Eine Leiste anzeigen bis die Zeitbombe explodiert.",

	arcaneExplosion = "M\195\164chtige arkane Explosion",
	arcaneExplosion_desc = "Warnen wenn Magierlord Urom mit dem Wirken de m\195\164chtigen arkanen Explosion beginnt.",

	arcaneExplosionBar = "M\195\164chtige arkane Explosion-Anzeige",
	arcaneExplosionBar_desc = "Eine Leiste f\195\188r die Zauberzeit der m\195\164chtigen arkanen Explosion anzeigen.",
} end )

L:RegisterTranslations("zhCN", function() return {
	timeBomb = "时间炸弹",
	timeBomb_desc = "当我玩家中了时间炸弹时发出警报。",
	timeBomb_message = ">%s<：时间炸弹！",

	timeBombWhisper = "时间炸弹密语",
	timeBombWhisper_desc = "当玩家中了时间炸弹时发送密语。",
	timeBombWhisper_message = ">你< 时间炸弹！",

	timeBombBar = "时间炸弹计时条",
	timeBombBar_desc = "显示时间炸弹爆炸计时条。",

	arcaneExplosion = "魔爆术增效",
	arcaneExplosion_desc = "当法师领主伊洛姆开始施放魔爆术增效时发出警报。",

	arcaneExplosionBar = "魔爆术增效计时条",
	arcaneExplosionBar_desc = "显示魔爆术增效计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	timeBomb = "Бомба",
	timeBomb_desc = "Сообщать о том, что кто-то стал бомбой.",
	timeBomb_message = "%s: Бомба",

	timeBombWhisper = "Шепнуть о бомбе",
	timeBombWhisper_desc = "Отсылать сообщение в шепот, участнику, у которого бомба.",
	timeBombWhisper_message = "Вы бомба!",

	timeBombBar = "Полоса бомбы",
	timeBombBar_desc = "Отображать полосу с остатком времени до взрыва.",

	arcaneExplosion = "Мощный чародейский взрыв",
	arcaneExplosion_desc = "Предупреждать о начале применения Уромом мощного чародейского взрыва.",

	arcaneExplosionBar = "Полоса мощного чародейского взрыва",
	arcaneExplosionBar_desc = "Отображать полосу применения мощного чародейского взрыва.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27655
mod.toggleoptions = {"timeBomb","timeBombWhisper","timeBombBar",-1,"arcaneExplosion","arcaneExplosionBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "TimeBomb", 51121, 59376)
	self:AddCombatListener("SPELL_CAST_START", "ArcaneExplosion", 51110, 59377)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:TimeBomb(player, spellId, _, _, spellName)
	if self.db.profile.timeBomb then
		self:IfMessage(L["timeBomb_message"]:format(player), "Attention", spellId)
	end
	if self.db.profile.timeBombWhisper and (pName ~= player) then
		self:Whisper(player, L["timeBombWhisper_message"])
	end
	if self.db.profile.timeBombBar then
		self:Bar(L["timeBomb_message"]:format(player), 6, spellId)
	end
end

function mod:ArcaneExplosion(_, spellId, _, _, spellName)
	if self.db.profile.arcaneExplosion then
		self:IfMessage(L["arcaneExplosion"], "Attention", spellId)
	end
	if self.db.profile.arcaneExplosionBar then
		self:Bar(spellName, 8, spellId)
	end
end
