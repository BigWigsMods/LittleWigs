-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ammunae", 759)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39731)
mod.toggleOptions = {76043, 75790, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Wither", 76043)
	self:Log("SPELL_CAST_START", "Growth", 75790, 89888)

	self:Death("Win", 39731)
end

-------------------------------------------------------------------------------
--  Event Handlers


function mod:Wither(_, spellId, _, _, spellName)
	self:Message(76043, LW_CL["casting"]:format(spellName), "Important", spellId)
end

function mod:Growth(_, spellId, _, _, spellName)
	self:Message(75790, LW_CL["casting"]:format(spellName), "Attention", spellId, "Alarm")
end

