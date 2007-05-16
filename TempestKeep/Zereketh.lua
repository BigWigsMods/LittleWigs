------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Zereketh the Unbound"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Zereketh",

	nova = "Shadow Nova",
	nova_desc = "Warn for Shadow Nova",
	nova_trigger = "begins to cast Shadow Nova.$",
	nova_warning = "Shadow Nova in 2 seconds!",

	void = "Void Zone",
	void_desc = "Warns for new Void Zones",
	void_trigger = "casts Void Zone.$",
	void_warning = "Void Zone incomimg!",

	seed = "Seed of Corruption",
	seed_desc = "Warn for who get's Seed of Corruption",
	seed_trigger = "^([^%s]+) ([^%s]+) afflicted by Gift of the Doomsayer.",
	seed_warning = "Seed of Corruption is on %s!",
	seed_bar = "~Detonation",

	icon = "Seed of Corruption Raid Icon",
	icon_desc = "Put a Raid Icon on the person who has Seed of Corruption. (Requires promoted or higher)",		
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"nova", "void", "seed", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if not self.db.profile.nova and msg:find(L["nova_trigger"]) then
		self:Message(L["nova_warning"], "Important")
	end
	if not self.db.profile.void and msg:find(L["void_trigger"]) then
		self:Message(L["void_warning"], "Important")
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE(msg)
	if not self.db.profile.seed then return end
	local player, type = select(3, msg:find(L["seed_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["seed_warning"]:format(player), "Urgent")
		self:Bar(L["seed_bar"]:format(player), 18, "Spell_Shadow_SeedOfDestruction")
		if self.db.profile.icon then
			self:Icon(player)
		end
	end
end
