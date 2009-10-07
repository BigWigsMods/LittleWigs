-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Amanitar", "Ahn'kahet: The Old Kingdom")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(30258)
mod.toggleOptions = {
	{57055, "FLASHSHAKE"}, -- Mini
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Mini", 57055)
	self:Death("Win", 30258)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Mini(player, spellId, _, _, spellName)
	if player ~= pName then return end
	self:TargetMessage(57055, spellName, player, "Personal", spellId, "Alarm")
	self:FlashShake(57055)
end
