------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Erekem"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Erekem",
	
	earthshield = "Earth Shield",
	earthshield_desc = "Warns for Earth Shield.",
	earthshield_message = "Earth Shield!",
	
	chainheal = "Chain Heal",
	chainheal_desc = "Warn for the casting of Chain Heal.",
	chainheal_message = "Casting Chain Heal!",
} end )

L:RegisterTranslations("koKR", function() return {
	earthshield = "대지의 보호막",
	earthshield_desc = "대지의 보호막에 대해 알립니다.",
	earthshield_message = "대지의 보호막!",
	
	chainheal = "연쇄 치유",
	chainheal_desc = "연쇄 치유에 시전에 대해 알립니다.",
	chainheal_message = "치유 시전!",
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 29315
mod.toggleoptions = {"earthshield", "chainheal", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "EarthShield", 54479, 59471)
	self:AddCombatListener("SPELL_CAST_START", "ChainHeal", 54481, 59473)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:EarthShield(_, spellId)
	if self.db.profile.earthshield then
		self:IfMessage(L["earthshield_message"], "Important", spellId)
	end
end

function mod:ChainHeal(_, spellId, _, _, spellName)
	if self.db.profile.chainheal then
		self:IfMessage(L["chainheal_message"], "Urgent", spellId)
	end
end

