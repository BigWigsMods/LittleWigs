-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Scourgelord Tyrannus", "Pit of Saron")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36658, 36661)
mod.toggleOptions = {
	{69172, "ICON"}, -- Overlords Brand
	{69275, "ICON", "FLASHSHAKE"}, -- Mark of Rimefang
	69629, -- Unholy Power
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Brand", 69172)
	self:Log("SPELL_AURA_APPLIED", "Mark", 69275)
	self:Log("SPELL_AURA_REMOVED", "MarkRemoved", 69275)
	self:Log("SPELL_AURA_REMOVED", "BrandRemoved", 69172)
	self:Log("SPELL_AURA_APPLIED", "Power", 69629, 69167)
	self:Death("Win", 36658)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Brand(player, spellId, _, _, spellName)
	self:TargetMessage(69172, spellName, player, "Personal", spellId, "Alert")
	self:Bar(69172, player..": "..spellName, 8, spellId)
	self:SecondaryIcon(69172, player)
end

function mod:Mark(player, spellId, _, _, spellName)
	self:TargetMessage(69275, spellName, player, "Personal", spellId, "Alert")
	self:Bar(69275, player..": "..spellName, 7, spellId)
	if player == pName then self:FlashShake(69275) end
	self:PrimaryIcon(69275, player)
end

function mod:MarkRemoved()
	self:PrimaryIcon(69275, false)
end

function mod:BrandRemoved()
	self:SecondaryIcon(69172, false)
end

function mod:Power(_, spellId, _, _, spellName)
	self:Message(69629, spellName, "Important", spellId)
	self:Bar(69629, spellName, 10, spellId)
end
