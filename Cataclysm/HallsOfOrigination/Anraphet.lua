-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anraphet", 644, 126)
if not mod then return end
mod:RegisterEnableMob(39788)
mod.engageId = 1075
mod.respawnTime = 39 -- respawns after 30s but is unattackable for a while

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		76184, -- Alpha Beams
		75622, -- Omega Stance
		75609, -- Crumbling Ruin
		75603, -- Nemesis Strike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AlphaBeamsCast", 76184)
	self:Log("SPELL_DAMAGE", "AlphaBeamsDamage", 76956)
	self:Log("SPELL_MISSED", "AlphaBeamsDamage", 76956)

	self:Log("SPELL_CAST_START", "OmegaStance", 75622)

	self:Log("SPELL_AURA_APPLIED", "CrumblingRuin", 75609)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CrumblingRuin", 75609)

	self:Log("SPELL_AURA_APPLIED", "NemesisStrike", 75603)
	self:Log("SPELL_AURA_REMOVED", "NemesisStrikeRemoved", 75603)

end

function mod:OnEngage()
	self:CDBar(75622, 30) -- Omega Stance
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:AlphaBeamsCast(args)
	self:MessageOld(args.spellId, "yellow", nil, CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:AlphaBeamsDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(76184, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:OmegaStance(args)
	self:MessageOld(args.spellId, "red", "alarm", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 41)
end

function mod:CrumblingRuin(args)
	if self:Me(args.destGUID) then
		self:StackMessageOld(args.spellId, args.destName, args.amount, "blue")
	end
end

function mod:NemesisStrike(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "orange")
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:NemesisStrikeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
