
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Drakkari Colossus", 604, 593)
if not mod then return end
mod:RegisterEnableMob(29307)
mod.engageId = 1983

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		59451, -- Mojo Puddle
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Emerge", 54850) -- To Elemental
	self:Log("SPELL_CAST_START", "Merge", 54878) -- To Colossus


	self:Log("SPELL_AURA_APPLIED", "MojoPuddle", 59451)
	self:Log("SPELL_PERIODIC_DAMAGE", "MojoPuddle", 59451)
	self:Log("SPELL_PERIODIC_MISSED", "MojoPuddle", 59451)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Emerge()
	self:MessageOld("stages", "yellow", nil, -6421) -- Phase 2: The Elemental
end

function mod:Merge()
	self:MessageOld("stages", "red", nil, -6418) -- Phase 1: The Colossus
end

do
	local prev = 0
	function mod:MojoPuddle(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
