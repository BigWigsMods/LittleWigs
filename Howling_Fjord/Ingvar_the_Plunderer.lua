------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ingvar the Plunderer"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local deathcount = 0

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ingvar",

	smash = "Smash",
	smash_desc = "Warn for the casting of Smash or Dark Smash.",
	smash_message = "Casting %s",
	
	roar = "Roar",
	roar_desc = "Warn for the casting of Staggering Roar or Dreadful Roar.",
	roar_message = "Casting %s",
} end )

L:RegisterTranslations("koKR", function() return {
	smash = "강타",
	smash_desc = "어둠의 강타와 강타의 시전에 대해 알립니다.",
	smash_message = "%s 시전",
	
	roar = "포효",
	roar_desc = "포효의 시전에 대해 알립니다.",
	roar_message = "%s 시전",
} end )

L:RegisterTranslations("frFR", function() return {
	smash = "Choc",
	smash_desc = "Prévient quand Ingvar incante son Choc ou son Choc sombre.",
	smash_message = "%s en incantation",

	roar = "Rugissement",
	roar_desc = "Prévient quand Ingvar incante un de ses Rugissements.",
	roar_message = "%s en incantation",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Keep"]
mod.enabletrigger = boss 
mod.guid = 23954
mod.toggleoptions = {"smash", "roar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Smash", 42723, 42669) --just logic speculation on the spellID
	self:AddCombatListener("SPELL_CAST_START", "Roar", 42708, 42729)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	deathcount = 0
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Smash(_, spellID, _, _, spellName)
	if self.db.profile.smash then
		self:IfMessage(L["smash_message"]:format(spellName), "Urgent", spellID)
		self:Bar(L["smash_message"]:format(spellName), 3, spellID)
	end
end

function mod:Roar(_, spellID, _, _, spellName)
	if self.db.profile.roar then
		self:IfMessage(L["roar_message"]:format(spellName), "Urgent", spellID)
	end
end

function mod:BossDeath(_, _, source)
	if not self.db.profile.bosskill then return end
	if source == boss then
		deathcount = deathcount + 1	
	end
	if deathcount == 2 then
		self:GenericBossDeath(boss, true)
	end
end
