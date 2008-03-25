------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Selin Fireheart"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Selin",

	channel = "Channel Mana",
	channel_desc = "Warn when Selin Fireheart is channeling mana from a Fel Crystal",
	channel_message = "Channeling Mana!",
	channel_trigger = "channel from the nearby Fel Crystal",
} end )

--[[
	Magister's Terrace modules are PTR beta, as so localization is not
	supported in any way. This gives the authors the freedom to change the
	modules in way that	can potentially break localization.  Feel free to
	localize, just be aware that you may need to change it frequently.
]]--

L:RegisterTranslations("koKR", function() return {
	channel = "ºÐ³ëÀÇ ¸¶³ª",
	channel_desc = "¼¿¸° ÆÄÀÌ¾îÇÏÆ®°¡ Áö¿Á ¼öÁ¤¿¡¼­ ¸¶·Â Èí¼ö¿¡ ´ëÇØ ¾Ë¸³´Ï´Ù.",
	channel_message = "ºÐ³ëÀÇ ¸¶³ª!",
	channel_trigger = "±ÙÃ³ÀÇ Áö¿Á ¼öÁ¤¿¡¼­ ÈûÀ» ²ø¾î³À´Ï´Ù...",
} end )

L:RegisterTranslations("frFR", function() return {
	channel = "Canalise du mana",
	channel_desc = "Préviens quand Selin Coeur-de-feu canalise du mana à partir d'un gangrecristal.",
	channel_message = "Canalise du mana !",
	channel_trigger = "commence à canaliser l'énergie du gangrecristal tout proche",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"channel","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE","Channel")

	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Channel(msg)
	if db.channel and msg:find(L["channel_trigger"]) then
		self:Message(channel_message, "Important")
	end
end
