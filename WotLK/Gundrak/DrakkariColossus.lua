--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Drakkari Colossus", 604, 593)
if not mod then return end
mod:RegisterEnableMob(29307)
mod:SetEncounterID(1983)

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
	self:Message("stages", "yellow", -6421, 54850) -- Phase 2: The Elemental
	self:PlaySound("stages", "long")
end

function mod:Merge()
	self:Message("stages", "red", -6418, 54878) -- Phase 1: The Colossus
	self:PlaySound("stages", "long")
end

do
	local prev = 0
	function mod:MojoPuddle(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end
