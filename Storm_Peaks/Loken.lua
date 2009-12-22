-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Loken", "Halls of Lightning")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(28923)
mod.toggleOptions = {
	52960, -- Nova
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local casttime = 4

-------------------------------------------------------------------------------
--  Initialization

function mod:OnEnable()
	self:Log("SPELL_CAST_START", "Nova", 52960, 59835)
	self:Death("Win", 28923)

	if GetInstanceDifficulty() == 1 then
		casttime = 5
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Nova(_, spellId, _, _, spellName)
	self:Message(52960, spellName, "Urgent", spellId)
	self:Bar(52960, spellName, casttime, spellId)
end
