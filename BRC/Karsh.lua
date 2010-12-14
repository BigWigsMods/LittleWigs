-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Karsh Steelbender", "Blackrock Caverns")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39698)
mod.toggleOptions = {
	75842, -- Quicksilver Armor
	93567, -- Superheated Quicksilver Armor
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Armor", 75842)
	self:Log("SPELL_AURA_APPLIED", "HeatedArmor", 75846, 93567)

	self:Death("Win", 39698)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Armor(_, _, _, _, spellName)
	self:Message(75842, spellName, "Important", 75842, "Alert")
end

function mod:HeatedArmor(_, _, _, _, spellName)
	self:Message(93567, spellName, "Personal", 93567, "Info")
end