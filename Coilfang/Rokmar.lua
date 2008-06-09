------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Rokmar the Crackler"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil
local enrageannounced = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Rokmar",
	
	throw = "Grievous Wound",
	throw_desc = "Warn who is afflicted by Grievous Wound.",
	throw_message = "%s has Grievous Wound",

	enrage = "Enrage (Heroic)",
	enrage_desc = "Warn befor Rokmar enrages",
	enrage_warning = "Enraged Soon!",
	enrage_message = "Enraged!",
} end )

L:RegisterTranslations("frFR", function() return {
	--throw = "Grievous Wound",
	--throw_desc = "Warn who is afflicted by Grievous Wound.",
	--throw_message = "%s has Grievous Wound",

	enrage = "Enrager (Héroïque)",
	enrage_desc = "Préviens quand Rokmar est sûr le point de devenir enragé.",
	enrage_warning = "Bientôt enragé !",
	--enrage_message = "Enraged!",
} end )

L:RegisterTranslations("koKR", function() return {
	throw = "치명상",
	throw_desc = "치명상에 걸린 플레이어를 알립니다.",
	throw_message = "%s 치명상",
	
	enrage = "격노 (영웅)",
	enrage_desc = "로크마르 격노에 대해 알립니다.",
	enrage_warning = "잠시후 격노!",
	enrage_message = "격노!",
} end )

L:RegisterTranslations("zhCN", function() return {
	throw = "痛苦之伤",
	throw_desc = "当玩家受到痛苦之伤时发出警报。",
	throw_message = "痛苦之伤：>%s<！",
	
	enrage = "激怒（英雄）",
	enrage_desc = "当激怒时发出警报。",
	enrage_warning = "巨钳鲁克玛尔 激怒！",
	enrage_message = "激怒！",
} end )

L:RegisterTranslations("zhTW", function() return {
	throw = "嚴重傷害",
	throw_desc = "隊友受到嚴重傷害時發出警報",
	throw_message = ">%s< 受到嚴重傷害",
	
	enrage = "狂怒（英雄）",
	enrage_desc = "當爆裂者洛克瑪狂怒時發出警報",
	enrage_warning = "即將狂怒!",
	enrage_message = "狂怒!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = BZ["The Slave Pens"]
mod.enabletrigger = boss
mod.toggleoptions = {"wound", -1, "enrage", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Wound", 31956, 38801)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Enrage", 34970)
	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	enrageannounced = nil
	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Wound(player, spellID)
	if db.wound then
		self:IfMessage(L["throw_message"]:format(player), "Attention", spellID)
	end
end

function mod:Enrage(_, spellID)
	if db.enrage then
		self:IfMessage(L["enrage_message"], "Important", spellID)
	end
end

function mod:UNIT_HEALTH(arg1)
	if not db.enrage or GetInstanceDifficulty() ~= 2 then
		self:UnregisterEvent("UNIT_HEALTH")
		return
	end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 18 and health <= 24 and not enrageannounced then
			enrageannounced = true
			self:Message(L["enrage_warning"], "Attention")
		elseif health > 28 and enrageannounced then
			enrageannounced = nil
		end
	end
end
