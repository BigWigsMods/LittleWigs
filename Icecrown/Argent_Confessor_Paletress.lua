----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Argent Confessor Paletress"]
local mod = BigWigs:New(boss, tonumber(("$Revision: 550 $"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Icecrown"
mod.zonename = BZ["Trial of the Champion"]
mod.enabletrigger = boss
mod.guid = 34928
mod.toggleoptions = {"shield", "healing, bosskill"}

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return {
	cmd = "Argent Confessor Paletress",
	shield = "Magic Reflection!",
	shield_desc = "Warn for Magic Reflection",
	shield_lost = "Shield faded",
	heal_msg = "Paletress is healing!",
	trigger_surrender = "Exzellente Arbeit!", --to be translated
}
end )

L:RegisterTranslations("deDE", function() return {
	shield = "Magiereflexion",
	shield_desc = "Warnung, wenn Magiereflexion aktiv.",
	shield_lost = "Magiereflexion beendet",
	heal_msg ="Blondlocke heilt-> Unterbrechen!",
	trigger_surrender = "^Exzellente Arbeit!", --to be checked
}
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "ShieldGain", 66515)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShieldLoss", 66515)
	self:AddCombatListener("SPELL_CAST_START", "Renewal", 66537, 67675)
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	--self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:ShieldGain(_, spellId, _, _, spellName)
	if self.db.profile.shield then
		self:IfMessage(L["shield"], "Urgent", spellId)
	end
end

function mod:ShieldLoss(_, spellId, _, _, spellName)
	if self.db.profile.shield then
		self:IfMessage(L["shield_lost"], "Urgent", spellId)
	end
end

function mod:Renewal(_, spellId, _, _, spellName)
	if self.db.profile.healing then
		self:IfMessage(L["heal_msg"], "Urgent", spellId)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["triger_surrender"] then
		self:BossDeath(nil, self.guid)
	end
end