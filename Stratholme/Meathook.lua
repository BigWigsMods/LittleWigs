------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Meathook"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Meathook",
	chains = "Constricting Chains",
	chains_desc = "Warn who is in the Constricting Chains.",

	chainsBar = "Constricting Chains Bar",
	chainsBar_desc = "Display a bar for the duration someone is in the Constricting Chains.",

	chains_message = "Chains: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	chains = "사슬 조이기",
	chains_desc = "사슬 조이기에 걸린 플레이어를 알립니다.",

	chainsBar = "사슬 조이기 바",
	chainsBar_desc = "사슬 조이기가 지속되는 바를 표시합니다.",

	chains_message = "사슬 조이기: %s",
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
	chains = "壓迫之鍊",
	chains_desc = "當玩家中了壓迫之鍊時發出警報。",

	chainsBar = "壓迫之鍊計時條",
	chainsBar_desc = "當玩家所中的壓迫之鍊持續時顯示計時條。",

	chains_message = "壓迫之鍊：>%s<！",
} end )

L:RegisterTranslations("deDE", function() return {
	chains = "Fesselnde Ketten",
	chains_desc = "Warnung wer sich in den Fesselnden Ketten befindet.",

	chainsBar = "Fesselnde Ketten-Anzeige",
	chainsBar_desc = "Eine Leiste f\195\188r die Dauer der Fesselnden Ketten anzeigen.",

	chains_message = "Ketten: %s",	
} end )

L:RegisterTranslations("zhCN", function() return {
	chains = "束缚之链",
	chains_desc = "当玩家中了束缚之链时发出警报。",

	chainsBar = "束缚之链计时条",
	chainsBar_desc = "当玩家所中的束缚之链持续时显示计时条。",

	chains_message = "束缚之链：>%s<！",
} end )

L:RegisterTranslations("ruRU", function() return {
	chains = "Удушающие оковы",
	chains_desc = "Сообщать кто затачен в оковы.",

	chainsBar = "Полоса удушающих оков",
	chainsBar_desc = "Отображать полосу продолжительности удушающих оков если в них кто либо затачен.",

	chains_message = "Оковы: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26529
mod.toggleoptions = {"chains", "chainsBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Chains", 52696, 58823)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Chains(player, spellId)
	if self.db.profile.chains then
		self:IfMessage(L["chains_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.chainsBar then
		self:Bar(L["chains_message"]:format(player), 5, spellId)
	end
end
