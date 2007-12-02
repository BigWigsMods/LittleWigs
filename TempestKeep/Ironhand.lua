------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Gatewatcher Iron-Hand"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ironhand",

	hammer = "Jackhammer",
	hammer_desc = "Warn when Jackhammer Effect is cast",
	hammer_trigger = "raises his hammer menacingly",
	hammer_warn = "Jackhammer in 3 seconds!",
	hammer_bar = "Jackhammer",

	shadow = "Shadow Power",
	shadow_desc = "Warn when Iron-Hand gains Shadow Power",
	shadow_trigger = "begins to cast Shadow Power",
	shadow_warn = "Shadow Power in 2 seconds!",
	shadow_bar = "Shadow Power",
} end )

L:RegisterTranslations("koKR", function() return {
	hammer = "착암기",
	hammer_desc = "착암기 효과 시전 시 경고",
	hammer_trigger = "자신의 망치를 위협적으로 치켜듭니다...", -- check
	hammer_warn = "3초 이내 착암기!",
	hammer_bar = "착암기",

	shadow = "어둠의 힘",
	shadow_desc = "어둠의 힘을 얻을 시 경고",
	shadow_trigger = "문지기 무쇠주먹|1이;가; 암흑 마법 강화 시전을 시작합니다.", -- check
	shadow_warn = "2초 이내 어둠의 힘!",
	shadow_bar = "어둠의 힘",
} end )

L:RegisterTranslations("zhTW", function() return {
	hammer = "千斤錘特效",
	hammer_desc = "看守者發動千斤錘特效時發出警報",
	hammer_trigger = "威嚇地舉起他的錘子……",
	hammer_warn = "3 秒後發動千斤錘! 近戰退後!",
	hammer_bar = "千斤錘特效",

	shadow = "暗影強化",
	shadow_desc = "看守者施放暗影強化時發出警報",
	shadow_trigger = "開始施放暗影強化。",
	shadow_warn = "2 秒後施放暗影強化!",
	shadow_bar = "暗影強化",
} end )

L:RegisterTranslations("frFR", function() return {
	hammer = "Marteau-piqueur",
	hammer_desc = "Préviens quand le Marteau-piqueur est incanté.",
	hammer_trigger = "lève son marteau d'un air menaçant...",
	hammer_warn = "Marteau-piqueur dans 3 sec. !",
	hammer_bar = "Marteau-piqueur",

	shadow = "Puissance de l'ombre",
	shadow_desc = "Préviens quand Main-en-fer gagne la Puissance de l'ombre.",
	shadow_trigger = "commence à lancer Puissance de l'ombre",
	shadow_warn = "Puissance de l'ombre dans 2 sec. !",
	shadow_bar = "Puissance de l'ombre",
} end )

L:RegisterTranslations("esES", function() return {
	hammer = "Martillo",
	hammer_desc = "Avisa cuando Manoyerro alza su martillo",
	hammer_trigger = "alza su martillo amenazadoramente",
	hammer_warn = "Martillo en 3 segundos!",
	hammer_bar = "Martillo",

	shadow = "Shadow Power",
	shadow_desc = "Avisa cuando Manoyerro lanza Poder de las Sombras",
	shadow_trigger = "comienza a lanzar Poder de las Sombras",
	shadow_warn = "Poder de las Sombras en 2 segundos!",
	shadow_bar = "Poder de las Sombras",
} end )

--看守者埃隆汉
L:RegisterTranslations("zhCN", function() return {
	hammer = "风钻",
	hammer_desc = "风钻特效施放时发出警告",--Jackhammer Effect
	hammer_trigger = "%s阴险地举起战锤……",
	hammer_warn = "3秒后风钻!",
	hammer_bar = "风钻",

	shadow = "暗影能量",
	shadow_desc = "施放暗影能量时发出警报",
	shadow_trigger = "开始施放暗影能量。",
	shadow_warn = "2秒后 暗影能量!",
	shadow_bar = "暗影能量",
} end )

L:RegisterTranslations("deDE", function() return {
	hammer = "Hammer",
	hammer_desc = "Vor Hammer Warnen",
	hammer_trigger = "erhebt seinen Hammer bedrohlich",
	hammer_warn = "Hammer in 3 Sekunden!",
	hammer_bar = "Hammer",

	shadow = "Schattenmacht",
	shadow_desc = "Warnen, wenn Eisenhand Schattenmacht bekommt",
	shadow_trigger = "beginnt Schattenmacht zu wirken",
	shadow_warn = "Schattenmacht in 2 Sekunden!",
	shadow_bar = "Schattenmacht",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Mechanar"]
mod.enabletrigger = boss 
mod.toggleoptions = {"hammer", "shadow", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if self.db.profile.hammer and msg:find(L["hammer_trigger"]) then
		self:Message(L["hammer_warn"], "Important")
		self:Bar(L["hammer"], 3, "INV_Hammer_07")
	end
end

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF(msg)
	if self.db.profile.shadow and msg:find(L["shadow_trigger"]) then
		self:Message(L["shadow_warn"], "Important")
		self:Bar(L["shadow"], 2, "Spell_Shadow_Metamorphosis")
	end
end

