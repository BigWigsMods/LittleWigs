----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Grand Champions"]
local mod = BigWigs:New(boss, tonumber(("$Revision: 550 $"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.zonename = BZ["Trial of the Champion"]
mod.otherMenu = "Icecrown"
mod.enabletrigger = {L["jaeren"], L["arelas"]}
mod.toggleOptions = {"shaman_hex", "shaman_healingwave", -1, "mage_poly", -1, "rogue_poison" , "bosskill"}

------------------------------
--      Are you local?      --
------------------------------

-- the guids of all possible grand champions.
local guids = {34657, 34701, 34702, 34703, 34705, 35569, 35570, 35571, 35572, 35617}
local deaths = 0
local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return {
	shaman_hex = "Shaman - Hex of Mending",
	shaman_hex_desc = "Announces who has the Hex of Mending curse.",
	shaman_hex_message = "Hex of Mending on: %s!",
	shaman_healingwave = "Shaman - Healing Wave",
	shaman_healingwave_desc = "Announces when the shaman is casting Healing Wave.",

	mage_poly = "Mage - Polymorph",
	mage_poly_desc = "Announces who is Polymorphed.",
	mage_poly_message = "%s Polymorphed!",

	rogue_poison = "Rogue - Poison",
	rogue_poison_desc = "Warns when you are standing in poison.",
	rogue_poison_message = "Poison On You!",

	jaeren = "Jaeren Sunsworn",
	arelas = "Arelas Brightstar",
} end )

L:RegisterTranslations("deDE", function() return {
	shaman_hex = "Schamane - Verhexung der Heilung",
	shaman_hex_desc = "Verkündet Verhexung der Heilung",
	shaman_hex_message = "Verhexung der Heilung: %s!",
	shaman_healingwave = "Schamane - Welle der Heilung",
	shaman_healingwave_desc = "Verkündet Welle der Heilunge",

	mage_poly = "Magier - Verwandlung",
	mage_poly_desc = "Verkündet Verwandlung",
	mage_poly_message = "Wirkt Verwandlung auf: %s!",

	rogue_poison = "Gift!",
	rogue_poison_desc = "Warnt, wenn du im Gift stehst",

	jaeren = "Jaeren Sonnenschwur",
	arelas = "Arelas Hellstern",
} end )

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "ShamanHexApplied", 67534)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShamanHexRemoved", 67534)
	self:AddCombatListener("SPELL_CAST_START", "ShamanHeal", 68318, 67528)
	self:AddCombatListener("SPELL_AURA_APPLIED", "MagePolyApplied", 66043, 68311)
	self:AddCombatListener("SPELL_AURA_REMOVED", "MagePolyRemoved", 66043, 68311)
	self:AddCombatListener("SPELL_AURA_APPLIED", "RoguePoisonApplied", 67701, 67594, 68316)
    self:AddCombatListener("UNIT_DIED", "Deaths")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	deaths = 0
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:ShamanHexApplied(player, spellId)
	if self.db.profile.shaman_hex then
		self:IfMessage(L["shaman_hex_message"]:format(player), "Attention", spellId)
		self:Bar(L["shaman_hex_message"]:format(player), 10, 67534)
	end
end

function mod:ShamanHexRemoved(player)
	if self.db.profile.shaman_hex then
		self:TriggerEvent("BigWigs_StopBar", self, L["shaman_hex_message"]:format(player))
	end
end

function mod:ShamanHeal(boss, spellId, _, _, spellName)
	if self.db.profile.shaman_healingwave then
		self:IfMessage(spellName, "Urgent", spellId)
		self:Bar(spellName, 3, 67528)
	end
end

function mod:MagePolyApplied(player, spellId)
	if self.db.profile.mage_poly then
		self:IfMessage(L["mage_poly_message"]:format(player), "Attention", spellId)
	end
end

function mod:MagePolyRemoved(player, spellId)
	if self.db.profile.mage_poly then
		self:TriggerEvent("BigWigs_StopBar", self, L["mage_poly_message"]:format(player))
	end
end

function mod:RoguePoisonApplied(player, spellId)
	if player == pName and self.db.profile.poison then
		self:LocalMessage(L["rogue_poison_message"], "Personal", spellId, "Alarm")
	end
end	

function mod:Deaths(_, guid)
	if not self.db.profile.bosskill then return end
	guid = tonumber((guid):sub(-12,-7),16)
	for _,v in ipairs(guids) do
		if v == guid then
			deaths = deaths + 1
		end
	end
	if deaths == 3 then
		self:BossDeath(nil, self.guid, true)
	end
end
