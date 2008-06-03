------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Hydromancer Thespia"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Thespia",

	storm = "Lightning Cloud",
	storm_desc = "Warn for Lightning Cloud",
	storm_message = "Lightning Cloud!",
	
	burst = "Lung Burst",
	burst_desc = "Warn for Lung Burst",
	burst_message = "%s is Lung Burst!",
	burst_bar = "%s - Lung Burst",
} end )

L:RegisterTranslations("koKR", function() return {
	storm = "먹구름",
	storm_desc = "먹구름에 대한 경고",
	storm_message = "먹구름!",
	
	burst = "허파 파열",
	burst_desc = "허파 파열에 대해 알립니다.",
	burst_message = "%s 허파 파열!",
	burst_bar = "%s - 허파 파열",
} end )

L:RegisterTranslations("zhTW", function() return {
	storm = "落雷之雲",
	storm_desc = "施放落雷之雲時發出警報",
	storm_message = "落雷之雲! 注意閃躲!",
	
	burst = "肺部爆炸",
	burst_desc = "肺部爆炸警報",
	burst_message = "%s 受到肺部爆炸!",
	burst_bar = "%s - 肺部爆炸",
} end )

L:RegisterTranslations("frFR", function() return {
	storm = "Nuage d'éclairs",
	storm_desc = "Préviens quand Thespia lance un Nuage d'éclairs.",
	storm_message = "Nuage d'éclairs !",
	
	--burst = "Lung Burst",
	--burst_desc = "Warn for Lung Burst",
	--burst_message = "%s is Lung Burst!",
	--burst_bar = "%s - Lung Burst",
} end )

L:RegisterTranslations("deDE", function() return {
	storm = "Gewitterwolke",
	storm_desc = "Warnt vor Gewitterwolke",
	storm_message = "Gewitterwolke!",
	
	--burst = "Lung Burst",
	--burst_desc = "Warn for Lung Burst",
	--burst_message = "%s is Lung Burst!",
	--burst_bar = "%s - Lung Burst",
} end )

L:RegisterTranslations("zhCN", function() return {
	storm = "落雷之云",
	storm_desc = "当施放落雷之云时发出警报。",
	storm_message = "落雷之云！躲避！",
	
	burst = "内爆",
	burst_desc = "当玩家受到内爆时发出警报。",
	burst_message = "内爆：>%s<！",
	burst_bar = "<内爆：%s>",
} end )

L:RegisterTranslations("esES", function() return {
	storm = "Nube de rel\195\161mpagos",
	storm_desc = "Aviso por Nube de rel\195\161mpagos",
	storm_message = "Nube de rel\195\161mpagos!",
	
	--burst = "Lung Burst",
	--burst_desc = "Warn for Lung Burst",
	--burst_message = "%s is Lung Burst!",
	--burst_bar = "%s - Lung Burst",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = BZ["The Steamvault"]
mod.enabletrigger = boss 
mod.toggleoptions = {"storm", "burst", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Storm", 25033)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Burst", 31481)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Storm()
	if self.db.profile.storm then
		self:Message(L["storm_message"], "Attention")
	end
end

function mod:Burst(player, spellId)
	if self.db.profile.burst then
		self:IfMessage(L["burst_message"]:format(player), "Important", spellId)
		self:Bar(L["burst_bar"]:format(player), 10, spellId) 
	end
end
