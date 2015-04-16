-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Tavarok", 732, 535)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18343)
mod.toggleOptions = {
	{32361, "ICON"},
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Prison", 32361)
	self:Death("Win", 18343)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Prison(player, spellId, _, _, spellName)
	self:Message(32361, spellName..": "..player, "Important", spellId)
	self:PrimaryIcon(32361, player, "icon")
end
