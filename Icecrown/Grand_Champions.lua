----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Grand Champions"]
local mod = BigWigs:New(boss, tonumber(("$Revision: 550 $"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.zonename = BZ["Trial of the Champion"]
mod.otherMenu = "Icecrown"
mod.guid = 34657
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

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Icecrown/Grand_Champions", format="lua_table", handle-unlocalized="ignore")@
end )

mod.enabletrigger = {L["jaeren"], L["arelas"]}

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

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
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

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.bosskill and msg:find(L["defeat_trigger"]) then
		self:BossDeath(nil, self.guid, true)
	end
end
