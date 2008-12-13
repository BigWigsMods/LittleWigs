------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Drakkari Colossus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Drakkari",

	emerge = "Emerge",
	emerge_desc = "Warn when the Elemental is emerging from the Colossus.",
	emerge_message = "Elemental Emerging",

	merge = "Merge",
	merge_desc = "Warn when the Elemental is merging back into the Colossus.",
	merge_message = "Merging with Colossus",
} end )

L:RegisterTranslations("koKR", function() return {
	emerge = "정령 등장",
	emerge_desc = "드라카리 거대골렘에서 드라카리 정령의 등장 알립니다.",
	emerge_message = "정령 등장!",

	merge = "정령 합류",
	merge_desc = "드라카리 정령이 드라카리 거대골렘과 합류하는 것을 알립니다.",
	merge_message = "골렘으로 돌아옴!",
} end )

L:RegisterTranslations("frFR", function() return {
	emerge = "Émergence",
	emerge_desc = "Prévient quand l'élémentaire émerge du colosse.",
	emerge_message = "Elémentaire émergé",

	merge = "Fusion",
	merge_desc = "Prévient quand l'élémentaire refusionne avec le colosse.",
	merge_message = "Fusion avec le colosse",
} end )

L:RegisterTranslations("zhTW", function() return {
	emerge = "浮現",
	emerge_desc = "當德拉克瑞元素從石縫中浮現時發出警報。",
	emerge_message = "元素浮現！",

	merge = "融合",
	merge_desc = "當德拉克瑞元素融回到巨像時發出警報。",
	merge_message = "融合巨像！",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	emerge = "突现",
	emerge_desc = "当达卡莱元素从石缝中突现时发出警报。",
	emerge_message = "元素突现！",

	merge = "融合",
	merge_desc = "当达卡莱元素融回到巨像时发出警报。",
	merge_message = "融合巨像！",
} end )

L:RegisterTranslations("ruRU", function() return {
	emerge = "Появление",
	emerge_desc = "Предупреждать о выходе элементаля из Колосса.",
	emerge_message = "Появление Элементаля!",

	merge = "Размытие",
	merge_desc = "Предупреждать о воссоединении элементаля с Колоссом.",
	merge_message = "Слияние с Колоссом",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Gundrak"]
mod.enabletrigger = boss 
mod.guid = 29307
mod.toggleoptions = {"emerge", "merge", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Emerge", 54850) -- To Elemental
	self:AddCombatListener("SPELL_CAST_START", "Merge", 54878) -- To Colossus
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Emerge(_, spellId)
	if self.db.profile.emerge then
		self:IfMessage(L["emerge_message"], "Urgent", spellId)
	end
end

function mod:Merge(_, spellId)
	if self.db.profile.merge then
		self:IfMessage(L["merge_message"], "Urgent", spellId)
	end
end
