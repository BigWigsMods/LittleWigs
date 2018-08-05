-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Zuramat the Obliterator", 536)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(29314, 32230)
mod.toggleOptions = {
	{54361, "FLASHSHAKE"}, -- Void Shift
}

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "VoidShift", 54361, 59743)
	self:Death("Win", 29314, 3223)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:VoidShift(player, spellId, _, _, spellName)
	self:TargetMessage(54361, spellName, player, "blue", spellId, "Alert")
	if player == pName then self:FlashShake(54361) end
end
