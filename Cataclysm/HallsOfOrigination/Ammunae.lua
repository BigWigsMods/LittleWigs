-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Ammunae", 759, 128)
if not mod then return end
mod:RegisterEnableMob(39731)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		76043, -- Wither
		75790, -- Rampant Growth
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Wither", 76043)
	self:Log("SPELL_CAST_START", "RampantGrowth", 75790)

	self:Death("Win", 39731)
end

-------------------------------------------------------------------------------
--  Event Handlers


function mod:Wither(args)
	self:Message(args.spellId, "Important", nil, CL.casting:format(args.spellName))
end

function mod:RampantGrowth(args)
	self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
end
