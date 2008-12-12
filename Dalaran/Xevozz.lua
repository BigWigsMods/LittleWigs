------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Xevozz"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Xevozz",

	sphere = "Summon Ethereal Sphere",
	sphere_desc = "Warn when Xevozz begins to summon an Ethereal Sphere",
	sphere_message = "Summoning Ethereal Sphere",
} end )

L:RegisterTranslations("koKR", function() return {
	sphere = "마력의 구슬 소환",
	sphere_desc = "제보즈의 마력의 구슬 소환을 알립니다.",
	sphere_message = "마력의 구슬 소환",
} end )

L:RegisterTranslations("frFR", function() return {
	sphere = "Invocation d'une sphère éthérée",
	sphere_desc = "Prévient quand Xevozz commence à invoquer une sphère éthérée.",
	sphere_message = "Invoque une sphère éthérée",
} end )

L:RegisterTranslations("zhTW", function() return {
	sphere = "召喚伊斯利之球",
	sphere_desc = "當基沃滋召喚伊斯利之球時發出警報。",
	sphere_message = "召喚伊斯利之球！",
} end )

L:RegisterTranslations("deDE", function() return {
	sphere = "Kraftkugel beschw\195\182ren",
	sphere_desc = "Warnung wenn Xevozz beginnt eine Kraftkugel zu beschw\195\182ren.",
	sphere_message = "Beschw\195\182rt Kraftkugel",
} end )

L:RegisterTranslations("zhCN", function() return {
	sphere = "召唤灵体之球",
	sphere_desc = "当谢沃兹召唤灵体之球时发出警报。",
	sphere_message = "召唤灵体之球！",
} end )

L:RegisterTranslations("ruRU", function() return {
	sphere = "Призыв бесплотной сферы",
	sphere_desc = "Предупреждает когда Ксевозз начинает призывать бесплотную сферу",
	sphere_message = "Призывает бесплотную сферу",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 29266
mod.toggleoptions = {"sphere", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Sphere", 54102, 54137, 54138, 61337, 61338)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Sphere(_, spellId)
	if self.db.profile.sphere then
		self:IfMessage(L["sphere_message"], "Important", spellId)
	end
end
