-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("King Dred", "Drak'Tharon Keep")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(27483)
mod.toggleOptions = {
	59416, -- Summon Raptor
	"bosskill",
}
mod.optionHeaders = {
	[59416] = "heroic",
	bosskill = "general",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RaptorCall", 59416)
	self:Death("Win", 27483)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:RaptorCall(_, spellId, _, _, spellName)
	self:Message(59416, spellName, "Attention", spellId)
end
