if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Raal the Gluttonous", 1862, 2127)
if not mod then return end
mod:RegisterEnableMob(131863)
mod.engageId = 2115

--------------------------------------------------------------------------------
-- Locals
--

local rottenExpulsionCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		264734, -- Consume All
		264931, -- Call Servant
		265002, -- Consume Servants
		264923, -- Tenderize
		264694, -- Rotten Expulsion
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "ConsumeAll", 264734)
	self:Log("SPELL_CAST_START", "CallServant", 264931)
	self:Log("SPELL_CAST_START", "ConsumeServants", 265002)
	self:Log("SPELL_CAST_START", "Tenderize", 264923)
	self:Log("SPELL_CAST_START", "RottenExpulsion", 264694)
	self:Log("SPELL_AURA_APPLIED", "RottenExpulsionDamage", 264712)
	self:Log("SPELL_PERIODIC_DAMAGE", "RottenExpulsionDamage", 264712)
	self:Log("SPELL_PERIODIC_MISSED", "RottenExpulsionDamage", 264712)

end

function mod:OnEngage()
	rottenExpulsionCount = 1
	self:Bar(264694, 5.5) -- Rotten Expulsion
	self:Bar(264923, 28.5) -- Tenderize
	self:Bar(264931, 43.5) -- Call Servant
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 264921 then -- Tenderize
		self:Bar(264923, 29) -- Tenderize
	end
end

function mod:ConsumeAll(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

function mod:CallServant(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 29)
end

function mod:ConsumeServants(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:Tenderize(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:RottenExpulsion(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	rottenExpulsionCount = rottenExpulsionCount + 1
	self:Bar(args.spellId, rottenExpulsionCount == 2 and 14 or rottenExpulsionCount == 3 and 25 or 29) -- 5.7, 14.6, 25.5, 29.1
end

do
	local prev = 0
	function mod:RottenExpulsionDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(264694, "blue", nil, CL.underyou:format(args.spellName))
				self:PlaySound(264694, "alarm", "gtfo")
			end
		end
	end
end
