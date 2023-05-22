-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("The Black Knight", 650, 637)
if not mod then return end
mod:RegisterEnableMob(35451)
mod.engageId = 2021
--mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{-7598, "CASTBAR"}, -- Ghoul Explode
		67781, -- Desecration
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Explode", 67729)
	self:Log("SPELL_AURA_APPLIED", "Desecration", 67781)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local prev = 0
	function mod:Explode(args)
		local t = args.time
		if t - prev > 1 then -- all remaining ghouls start casting Explode simultaneously when the boss transitions to stage 3
			prev = t
			self:MessageOld(-7598, "orange", nil, CL.casting:format(self:SpellName(args.spellId)))
			self:CastBar(-7598, self:Normal() and 5 or 4, args.spellId)
		end
	end
end

function mod:Desecration(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
	end
end
