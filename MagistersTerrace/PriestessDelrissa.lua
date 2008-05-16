------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Priestess Delrissa"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Delrissa",

	pri_heal = "Priestess Delrissa - Flash Heal",
	pri_heal_desc = "Warn for casting heals",
	pri_heal_message = "Priestess casting Flash Heal!",
	pri_renew = "Priestess Delrissa - Renew",
	pri_renew_desc = "Warn for who she casts renew on",
	pri_renew_message = "Renew on %s!",
	pri_shield = "Priestess Delrissa - Power Word: Shield",
	pri_shield_desc = "Warn for application of Power Word: Shield",
	pri_shield_message = "Power Word: Shield on %s!",

	Apoko = "Apoko", --need the add name translated, maybe we'll add it to BabbleBoss
	apoko_heal = "Apoko - Lesser Healing Wave",
	apoko_heal_desc = "Warn for casting heals",
	apoko_heal_message = "Apoko Healing!",
	apoko_wf = "Apoko - Windfury Totem",
	apoko_wf_desc = "Warn when a Windfury Totem is dropped",
	apoko_wf_message = "Windfury Totem dropped!",

	Ellyrs = "Ellrys Duskhallow", --need the add name translated, maybe we'll add it to BabbleBoss
	ellrys_soc = "Ellrys - Seed of Corruption",
	ellrys_soc_desc = "Warn when Ellrys casts Seed of Corruption on a player",
	ellrys_soc_message = "Seed: %s",

	Yazzai = "Yazzai", --need the add name translated, maybe we'll add it to BabbleBoss
	yazzai_bliz = "Yazzai - Blizzard",
	yazzai_bliz_desc = "Warn when Yazzai casts Blizzard",
	yazzai_bliz_message = "Blizzard!",
	yazzai_poly = "Yazzai - Polymorph",
	yazzai_poly_desc = "Warn when Yazzai polymorphs a player",
	yazzai_poly_message = "Polymorph: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	pri_heal = "여사제 델리사 - 순간 치유",
	pri_heal_desc = "치유 시전에 대해 알립니다.",
	pri_heal_message = "델리사 치유 시전!",
	pri_renew = "여사제 델리사 - 소생",
	pri_renew_desc = "소생을 누구에게 시전했는지 알립니다.",
	pri_renew_message = "%s 소생!",
	pri_shield = "여사제 델리사 - 신의 권능: 보호막",
	pri_shield_desc = "신의 권능: 보호막의 사용에 대해 알립니다.",
	pri_shield_message = "%s: 보호막!",

	Apoko = "아포코", --need the add name translated, maybe we'll add it to BabbleBoss
	apoko_heal = "아포코 - 하급 치유의 물결",
	apoko_heal_desc = "치유 시전에 대해 알립니다.",
	apoko_heal_message = "아포코 치유 시전!",
	apoko_wf = "아포코 - 질풍의 토템",
	apoko_wf_desc = "질풍의 토템에 대해 알립니다.",
	apoko_wf_message = "질풍의 토템!",

	Ellyrs = "엘리스 더스크할로우", --need the add name translated, maybe we'll add it to BabbleBoss
	ellrys_soc = "엘리스 - 부패의 씨앗",
	ellrys_soc_desc = "부패의 씨앗의 시전 대상이된 플레이어를 알립니다.",
	ellrys_soc_message = "씨앗: %s",

	Yazzai = "야자이", --need the add name translated, maybe we'll add it to BabbleBoss
	yazzai_bliz = "야자이 - 눈보라",
	yazzai_bliz_desc = "야자이의 눈보라 시전에 대해 알립니다.",
	yazzai_bliz_message = "눈보라!",
	yazzai_poly = "야자이 - 변이",
	yazzai_poly_desc = "야자이가 변이한 플레이어에 대해 알립니다.",
	yazzai_poly_message = "변이: %s",
} end )

L:RegisterTranslations("zhCN", function() return {
	pri_heal = "女祭司德莉西亚 - 快速治疗",
	pri_heal_desc = "当施放快速治疗时发出警报。",
	pri_heal_message = "正在施放 - 快速治疗！",
	pri_renew = "女祭司德莉西亚 - 恢复",
	pri_renew_desc = "当施放恢复时发出警报。",
	pri_renew_message = "恢复：>%s<！",
	pri_shield = "女祭司德莉西亚 - 真言术：盾",
	pri_shield_desc = "当受到真言术：盾时发出警报。",
	pri_shield_message = "真言术：盾：>%s<！",

	Apoko = "埃波克",
	apoko_heal = "埃波克 - 次级治疗波",
	apoko_heal_desc = "当施放次级治疗波时发出警报。",
	apoko_heal_message = "埃波克 治疗！",
	apoko_wf = "埃波克 - 风怒图腾",
	apoko_wf_desc = "当出现风怒图腾时发出警报。",
	apoko_wf_message = "风怒图腾 出现！",

	Ellyrs = "艾尔蕾丝",
	ellrys_soc = "艾尔蕾丝 - 腐蚀之种",
	ellrys_soc_desc = "当施放腐蚀之种时发出警报。",
	ellrys_soc_message = "腐蚀之种！",

	Yazzai = "亚赛",
	yazzai_bliz = "亚赛 - 暴风雪",
	yazzai_bliz_desc = "施放暴风雪时发出警报。",
	yazzai_bliz_message = "暴风雪！",
	yazzai_poly = "亚赛 - 变形术",
	yazzai_poly_desc = "施放变形术时发出警报。",
	yazzai_poly_message = "变形术！",
} end )

L:RegisterTranslations("zhTW", function() return {
	pri_heal = "女牧師戴利莎 - 快速治療",
	pri_heal_desc = "當女牧師戴利莎施放快速治療時發出警報",
	pri_heal_message = "女牧師戴利莎正在施放 [快速治療]",
	pri_renew = "女牧師戴利莎 - 恢復",
	pri_renew_desc = "當女牧師戴利莎施放恢復時發出警報",
	pri_renew_message = "恢復: >%s<",
	pri_shield = "女牧師戴利莎 - 真言術:盾",
	pri_shield_desc = "當女牧師戴利莎施放真言術:盾時發出警報",
	pri_shield_message = "真言術:盾: >%s<",

	Apoko = "阿波考", --need the add name translated, maybe we'll add it to BabbleBoss
	apoko_heal = "阿波考 - 次級治療波",
	apoko_heal_desc = "當阿波考施放次級治療波時發出警報",
	apoko_heal_message = "阿波考正在施放 [次級治療波]",
	apoko_wf = "阿波考 - 風怒圖騰",
	apoko_wf_desc = "當阿波考施放風怒圖騰時發出警報",
	apoko_wf_message = "風怒圖騰 >出現<",

	Ellyrs = "艾爾里斯·聖暮", --need the add name translated, maybe we'll add it to BabbleBoss
	ellrys_soc = "艾爾里斯·聖暮 - 腐蝕種子",
	ellrys_soc_desc = "當艾爾里斯·聖暮施放腐蝕種子時發出警報",
	ellrys_soc_message = "腐蝕種子",

	Yazzai = "耶賽", --need the add name translated, maybe we'll add it to BabbleBoss
	yazzai_bliz = "耶賽 - 暴風雪",
	yazzai_bliz_desc = "當耶賽施放暴風雪時發出警報",
	yazzai_bliz_message = "暴風雪",
	yazzai_poly = "耶賽 - 變形術",
	yazzai_poly_desc = "當耶賽施放變形術時發出警報",
	yazzai_poly_message = "變形術",
} end )

L:RegisterTranslations("frFR", function() return {
	pri_heal = "Delrissa - Soins rapides",
	pri_heal_desc = "Préviens quand Delrissa incante des Soins rapides.",
	pri_heal_message = "Delrissa incante des Soins rapides !",
	pri_renew = "Delrissa - Rénovation",
	pri_renew_desc = "Préviens quand Delrissa soigne un allié avec sa Rénovation.",
	pri_renew_message = "Rénovation sur %s !",
	pri_shield = "Delrissa - Mot de pouvoir : Bouclier",
	pri_shield_desc = "Préviens quand Delrissa protège un allié avec son Mot de pouvoir : Bouclier.",
	pri_shield_message = "Mot de pouvoir : Bouclier sur %s !",

	Apoko = "Apoko", --need the add name translated, maybe we'll add it to BabbleBoss
	apoko_heal = "Apoko - Vague de soins inférieurs",
	apoko_heal_desc = "Préviens quand Apoko incante une Vague de soins inférieurs.",
	apoko_heal_message = "Apoko incante une Vague de soins inférieurs !",
	apoko_wf = "Apoko - Totem Furie-des-vents",
	apoko_wf_desc = "Préviens quand Apoko pose un Totem Furie-des-vents.",
	apoko_wf_message = "Totem Furie-des-vents posé !",

	Ellyrs = "Ellrys Sanctebrune", --need the add name translated, maybe we'll add it to BabbleBoss
	ellrys_soc = "Ellrys - Graîne de Corruption",
	ellrys_soc_desc = "Préviens quand un joueur subit les effets de la Graîne de Corruption de Ellrys.",
	ellrys_soc_message = "Graîne : %s",

	Yazzai = "Yazzai", --need the add name translated, maybe we'll add it to BabbleBoss
	yazzai_bliz = "Yazzai - Blizzard",
	yazzai_bliz_desc = "Préviens quand Yazzai incante un Blizzard.",
	yazzai_bliz_message = "Blizzard !",
	yazzai_poly = "Yazzai - Métamorphose",
	yazzai_poly_desc = "Préviens quand un joueur subit les effets de la Métamorphose de Yazzai.",
	yazzai_poly_message = "Métamorphose : %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"pri_flashheal", "pri_renew", "pri_shield", -1, "apoko_lhw", "apoko_wf", -1, "yazzai_bliz", "yazzai_poly", -1, "ellrys_soc", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "PriShield", 46193, 44175, 44291)
	self:AddCombatListener("SPELL_CAST_START", "PriHeal", 17843)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "PriRenew", 44174, 46192)
	self:AddCombatListener("SPELL_CAST_START", "ApokoHeal", 46181, 44256)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "ApokoWF", 27621)
	self:AddCombatListener("SPELL_AURA_APPLIED", "EllrysSoC", 44141)
	self:AddCombatListener("SPELL_AURA_APPLIED", "YazzaiPoly", 13323)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "YazzaiBliz", 44178, 46195)

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:PriShield(player)
	if self.db.profile.pri_shield then
		self:IfMessage(L["pri_shield_message"]:format(player), "Attention", 44175)
	end
end

function mod:PriHeal()
	if self.db.profile.pri_heal then
		self:IfMessage(L["pri_heal_message"], "Attention", 17843)
	end
end

function mod:PriRenew(player)
	if self.db.profile.pri_renew then
		self:IfMessage(L["pri_renew_message"]:format(player), "Attention", 44174)
	end
end

function mod:ApokoHeal()
	if self.db.profile.apoko_heal then
		self:IfMessage(L["apoko_heal_message"], "Attention", 46181)
	end
end

function mod:ApokoWF()
	if self.db.profile.apoko_wf then
		self:IfMessage(L["apoko_wf_message"], "Attention", 27621)
	end
end

function mod:EllrysSoC(player, spellId)
	if self.db.profile.ellrys_soc then
		self:IfMessage(L["ellrys_soc_message"]:format(player), "Attention", spellId)
	end
end

function mod:YazzaiPoly(player, spellId)
	if self.db.profile.yazzai_poly then
		self:IfMessage(L["yazzai_poly_message"]:format(player), "Attention", spellId)
	end
end

function mod:YazzaiBliz(spellId)
	if self.db.profile.yazzai_bliz then
		self:IfMessage(L["yazzai_bliz_message"], "Attention", spellId)
	end
end
