------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Tavarok"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Tavarok",

	prison = "Crystal Prison",
	prison_desc = "Warn when someone is put in a Crystal Prison",
	prison_message = "Crystal Prison: %s",

	icon = "Raid Icon",
	icon_desc = "Place a Raid Icon on the player in a Crystal Prison(requires leader).",
} end )

L:RegisterTranslations("zhCN", function() return {
	prison = "Ë®¾§¼àÀÎ",
	prison_desc = "µ±¶ÓÓÑÖÐÁËË®¾§¼àÀÎÊ±·¢³ö¾¯±¨¡£",
	prison_message = "Ë®¾§¼àÀÎ£º>%s<£¡",

	icon = "ÍÅ¶Ó±ê¼Ç",
	icon_desc = "ÎªÖÐÁËË®¾§¼àÀÎµÄ¶ÓÓÑ´òÉÏÍÅ¶Ó±ê¼Ç¡££¨ÐèÒªÈ¨ÏÞ£©",
} end )

L:RegisterTranslations("koKR", function() return {
	prison = "¼öÁ¤ °¨¿Á",
	prison_desc = "¼öÁ¤ °¨¿Á¿¡ °É¸° ÇÃ·¹ÀÌ¾î¸¦ ¾Ë¸³´Ï´Ù.",
	prison_message = "Crystal Prison: %s",

	icon = "°ø°Ý´ë ¾ÆÀÌÄÜ",
	icon_desc = "¼öÁ¤ °¨¿Á¿¡ °É¸° ÇÃ·¹ÀÌ¾î¿¡°Ô Àü¼ú Ç¥½Ã¸¦ ÁöÁ¤ÇÕ´Ï´Ù. (½Â±ÞÀÚ ÀÌ»ó ±ÇÇÑ ¿ä±¸)",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Mana-Tombs"]
mod.enabletrigger = boss 
mod.guid = 18343
mod.toggleoptions = {"prison", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Prison", 32361)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Prison(player, spellId)
	if self.db.profile.prison then
		self:IfMessage(L["prison_message"]:format(player), "Important", 32361)
	end
	self:Icon(player, "icon")
end
