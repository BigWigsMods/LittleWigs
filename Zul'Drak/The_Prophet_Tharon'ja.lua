----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["The Prophet Tharon'ja"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Drak'Tharon Keep"]
mod.enabletrigger = boss 
mod.guid = 26632
mod.toggleoptions = {"bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return {
	cmd = "Tharon'ja",
	
	[" Health: "] = true,
	
	log = "|cffff0000"..boss.."|r: This boss needs data, please consider turning on your /combatlog or transcriptor and submit the logs.",
} end )

L:RegisterTranslations("koKR", function() return {
	[" Health: "] = " 체력: ",

	log = "|cffff0000"..boss.."|r: 해당 보스의 데이터가 필요합니다. 채팅창에 /전투기록 , /대화기록 을 입력하여 기록된 데이터를 보내주시기 바랍니다.",
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
	[" Health: "] = "生命：",
	
	log = "|cffff0000"..boss.."|r：缺乏數據，請考慮開啟戰斗記錄（/combatlog）或 Transcriptor 記錄并提交戰斗記錄，謝謝！",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	[" Health: "] = "生命：",
	
	log = "|cffff0000"..boss.."|r：缺乏数据，请考虑开启战斗记录（/combatlog）或 Transcriptor 记录并提交战斗记录，谢谢！",
} end )

L:RegisterTranslations("ruRU", function() return {
	log = "|cffff0000"..boss.."|r: Для этого босса необходимы правильные данные. Пожалуйста, включите запись логов (команда /combatlog) или установите аддон transcriptor, и пришлите получившийся файл (или оставьте ссылку на файл в комментариях на curse.com).",
} end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Flesh", 49356)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	BigWigs:Print(L["log"])
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Flesh()
	if Transcriptor then
		local currentHealth = UnitHealth(boss)
		local maxHealth = UnitHealthMax(boss)
		local percentHealth = (currentHealth/maxHealth)*100
		Transcriptor:InsNote(boss..L[" Health: "]..percentHealth.."%")
	end
end
