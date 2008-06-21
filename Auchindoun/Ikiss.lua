------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Talon King Ikiss"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ikiss",

	ae = "Arcane Explosion",
	ae_desc = "Warn for Arcane Explosion",
	ae_message = "Casting Arcane Explosion!",

	poly = "Polymorph",
	poly_desc = "Warn who gets Polymorphed.",
	poly_message = "%s is polymorphed",

	icon = "Raid Icon",
	icon_desc = "Place a Raid Icon on the polymorphed player(requires leader).",
} end )

L:RegisterTranslations("koKR", function() return {
	ae = "신비한 폭발",
	ae_desc = "신비한 폭발에 대한 경고입니다.",
	ae_message = "신비한 폭발 시전!",
	
	poly = "변이",
	poly_desc = "변이에 걸린 플레이어를 알립니다.",
	poly_message = "%s 변이",
	
	icon = "공격대 아이콘",
	icon_desc = "변이에 걸린 플레이어에게 전술 표시를 지정합니다. (승급자 이상 권한 요구)",
} end )

L:RegisterTranslations("zhTW", function() return {
	ae = "魔爆術",
	ae_desc = "魔爆術警報",
	ae_message = "即將施放魔爆術! 快找掩蔽!",

	poly = "變形術",
	poly_desc = "當隊友受到變形術時發出警報",
	poly_message = "變形術: >%s<",
} end )

L:RegisterTranslations("frFR", function() return {
	ae = "Explosion des arcanes",
	ae_desc = "Prévient quand Ikiss lance son Explosion des arcanes.",
	ae_message = "Explosion des arcanes en incantation !",

	poly = "Métamorphose",
	poly_desc = "Prévient quand un joueur subit les effets de la Métamorphose.",
	poly_message = "Métamorphose sur %s !",
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
	ae_desc = "当施放魔爆术时发出警报。",
	ae_message = "施放魔爆术！快躲！",

	poly = "变形术",
	poly_desc = "当队友受到变形术时发出警报。",
	poly_message = "变形术：>%s<！",

	icon = "团队标记",
	icon_desc = "为中了变形术的队友打上团队标记。（需要权限）",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Sethekk Halls"]
mod.enabletrigger = boss 
mod.guid = 18473
mod.toggleoptions = {"ae", "poly", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "AE", 38194)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Poly", 38245, 43309)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:AE()
	if self.db.profile.ae then
		self:Message(L["ae_message"], "Attention")
	end
end

function mod:Poly(player)
	if self.db.profile.poly then
		self:IfMessage(L["poly_message"]:format(player), "Attention", 38245)
		self:Bar(L["poly_message"]:format(player), 6, 38245)
	end
	self:Icon(player, "icon")
end

