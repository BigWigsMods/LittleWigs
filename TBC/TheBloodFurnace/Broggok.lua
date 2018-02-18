-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Broggok", 725, 556)
if not mod then return end
--mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17380)

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
				self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
