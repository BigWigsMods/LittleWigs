------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Exarch Maladaar"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Maladaar",

	soul = "Stolen Soul",
	soul_desc = "Warn for Stolen Souls",
	soul_trigger = "begins to perform Stolen Soul",
	soul_message = "A soul has been stolen!",

	avatar = "Avatar of the Martyred",
	avatar_desc = "Warn for the summoning of the Avatar of the Martyred",
	avatar_trigger = "begins to perform Summon Avatar of the Martyred",
	avatar_message = "Avatar of the Martyred spawning!",
} end )

L:RegisterTranslations("koKR", function() return {
	soul = "잃어버린 영혼 ",
	soul_desc = "잃어버린 영혼에 대한 경고",
	soul_trigger = "총독 말라다르|1이;가; 영혼 훔치기 사용을 시작합니다.", -- check
	soul_message = "잠시후 영혼을 훔칩니다!",

	avatar = "순교자의 화신",
	avatar_desc = "순교자의 화신 소환 경고",
	avatar_trigger = "총독 말라다르|1이;가; 순교자의 화신 소환 사용을 시작합니다.",
	avatar_message = "순교자의 화신 소환!",
} end )

L:RegisterTranslations("zhTW", function() return {
	cmd = "主教瑪拉達爾",

	soul = "偷取的靈魂",
	soul_desc = "主教瑪拉達爾施放靈魂偷取時發出警報",
	soul_trigger = "開始施展偷取的靈魂。",
	soul_message = "隊友靈魂被偷取，速度擊殺！",

	avatar = "馬丁瑞德的化身",
	avatar_desc = "召喚馬丁瑞德的化身時發出警報",
	avatar_trigger = "開始施展召喚馬丁瑞德的化身。",
	avatar_message = "馬丁瑞德的化身出現，MT 坦住！",
} end )

L:RegisterTranslations("frFR", function() return {
	soul = "Âme volée",
	soul_desc = "Préviens quand une âme est volée.",
	soul_trigger = "commence à exécuter Âme volée",
	soul_message = "Une âme a été volée !",

	avatar = "Avatar du martyr",
	avatar_desc = "Préviens quand l'Avatar du martyr est invoqué.",
	avatar_trigger = "commence à exécuter Invocation du roi-esprits", -- à vérifier
	avatar_message = "Avatar du martyr invoqué !",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = AceLibrary("Babble-Zone-2.2")["Auchenai Crypts"]
mod.enabletrigger = boss 
mod.toggleoptions = {"soul", "avatar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if self.db.profile.soul and msg:find(L["soul_trigger"]) then
		self:Message(L["soul_message"], "Attention")
	end
end

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF(msg)
	if self.db.profile.avatar and msg:find(L["avatar_trigger"]) then
		self:Message(L["avatar_message"], "Attention")
	end
end
