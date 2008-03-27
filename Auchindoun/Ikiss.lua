------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Talon King Ikiss"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ikiss",

	ae = "Arcane Explosion",
	ae_desc = "Warn for Arcane Explosion",
	ae_message = "Casting Arcane Explosion!",
} end )

L:RegisterTranslations("koKR", function() return {
	ae = "신비한 폭발",
	ae_desc = "신비한 폭발에 대한 경고입니다.",
	ae_message = "신비한 폭발 시전!",
} end )

L:RegisterTranslations("zhTW", function() return {
	ae = "魔爆術",
	ae_desc = "魔爆術警報",
	ae_message = "即將施放魔爆術! 快找掩蔽!",
} end )

L:RegisterTranslations("frFR", function() return {
	ae = "Explosion des arcanes",
	ae_desc = "Préviens quand Ikiss lance son Explosion des arcanes.",
	ae_message = "Explosion des arcanes en incantation !",
} end )

L:RegisterTranslations("deDE", function() return {
	ae = "Arkane Explosion",
	ae_desc = "Warnt vor Arkaner Explosion",
	ae_message = "Wirkt Arkane Explosion!",
} end )

L:RegisterTranslations("esES", function() return {
	ae = "Deflagraci\195\179n Arcana",
	ae_desc = "Avisa cuando el Rey Garra Ikiss va a lanzar deflagraci\195\179n arcana",
	ae_message = "Deflagraci\195\179n Arcana!",
} end )

L:RegisterTranslations("zhCN", function() return {
	ae = "魔爆术",
	ae_desc = "魔爆术警报",
	ae_message = "施放 魔爆术! 快躲！",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Sethekk Halls"]
mod.enabletrigger = boss 
mod.toggleoptions = {"ae", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	-- Way to many possible Blink spellIds, need to find the right one
	--self:AddCombatListener("SPELL_CAST_START","AE", #####)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:AE()
	if db.ae then
		self:Message(L["ae_message"], "Attention")
	end
end
