-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Broggok", 542, 556)
if not mod then return end
mod:RegisterEnableMob(17380)
-- mod.engageId = 1924 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialize

function mod:GetOptions()
	return {
		30916, -- Poison Cloud
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_DAMAGE", "PoisonCloud", 30916)
	self:Log("SPELL_MISSED", "PoisonCloud", 30916)
	self:Death("Win", 17380)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local prev = 0
	function mod:PoisonCloud(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
