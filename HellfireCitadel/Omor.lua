------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Omor the Unscarred"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Omor",

	aura = "Treacherous Aura",
	aura_desc = "Announce who has the Trecherous Aura",
	aura_trigger = "^([^%s]+) ([^%s]+) afflicted by Treacherous Aura.",
	aura_warning = "%s has Treacherous Aura!",
	aura_bar = "%s: Treacherous Aura",

	icon = "Raid Icon",
	icon_desc = "Put a Raid Icon on the person who has the Treacherous Aura. (Requires promoted or higher)",
} end)

L:RegisterTranslations("frFR", function() return {
	aura = "Aura traîtresse",
	aura_desc = "Préviens quand un joueur subit les effets de l'Aura traîtresse.",
	aura_trigger = "^([^%s]+) ([^%s]+) les effets .* Aura traîtresse.",
	aura_warning = "%s a l'Aura traîtresse !",
	aura_bar = "%s : Aura traîtresse",

	icon = "Icône",
	icon_desc = "Place une icône de raid sur le dernier joueur affecté par l'Aura traîtresse (nécessite d'être promu ou mieux).",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = AceLibrary("Babble-Zone-2.2")["Hellfire Ramparts"]
mod.enabletrigger = boss
mod.toggleoptions = {"aura", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Event(msg)
	local player, type = select(3, msg:find(L["aura_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["aura_warning"]:format(player), "Attention")
		self:Bar(L["aura_bar"]:format(player), 15, "Spell_Shadow_DeadofNight", "Red")
	end
end
