
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Blood Guard Porung", 540, 728)
if not mod then return end
mod:RegisterEnableMob(20923)
mod.engageId = 1935
mod.respawnTime = 7

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		15496, -- Cleave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_DAMAGE", "Cleave", 15496)
	self:Log("SPELL_MISSED", "Cleave", 15496)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:Cleave(args)
		if self:Me(args.destGUID) and not self:Tank() then
			local t = args.time
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end
