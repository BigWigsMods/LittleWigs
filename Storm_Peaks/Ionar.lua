-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ionar", "Halls of Lightning")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(28546)
mod.toggleOptions = {
	{52658, "WHISPER", "FLASHSHAKE"}, -- Overload
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnEnable()
	self:Log("SPELL_AURA_APPLIED", "Overload", 52658, 59795)
	self:Death("Win", 28546)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Overload(player, spellId, _, _, spellName)
	self:TargetMessage(52658, spellname, player, "Personal", spellId, "Alarm")
	self:Whisper(52658, player, spellName)
	self:Bar(52658, player..": "..spellName, 10, spellId)
	if player == pName then self:FlashShake(52658) end
end
