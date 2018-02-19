-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("The Black Knight", 650, 637)
if not mod then return end
mod:RegisterEnableMob(35451)
mod.engageId = 2021

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		-7598, -- Ghoul Explode
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
		local t = GetTime()
		if t - prev > 1 then
			self:Message(-7598, "Urgent", nil, CL.casting:format(self:SpellName(67729)))
			self:CastBar(-7598, self:Normal() and 5 or 4, 67729)
		end
	end
end

function mod:Desecration(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Alarm")
	end
end
