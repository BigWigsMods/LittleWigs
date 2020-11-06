
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Raal the Gluttonous", 1862, 2127)
if not mod then return end
mod:RegisterEnableMob(131863)
mod.engageId = 2115
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Locals
--

local rottenExpulsionCount = 1
local tenderizeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		264734, -- Consume All
		264931, -- Call Servant
		265005, -- Consumed Servant
		264923, -- Tenderize
		264694, -- Rotten Expulsion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ConsumeAll", 264734)
	self:Log("SPELL_CAST_START", "CallServant", 264931)
	self:Log("SPELL_AURA_APPLIED", "ConsumedServant", 265005)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ConsumedServant", 265005)
	self:Log("SPELL_CAST_START", "Tenderize", 264923)
	self:Log("SPELL_CAST_START", "RottenExpulsion", 264694)
	self:Log("SPELL_AURA_APPLIED", "RottenExpulsionDamage", 264712)
	self:Log("SPELL_PERIODIC_DAMAGE", "RottenExpulsionDamage", 264712)
	self:Log("SPELL_PERIODIC_MISSED", "RottenExpulsionDamage", 264712)

end

function mod:OnEngage()
	rottenExpulsionCount = 1
	tenderizeCount = 0
	self:Bar(264694, 5.5) -- Rotten Expulsion
	self:Bar(264923, 20.5) -- Tenderize
	self:Bar(264931, 43.5) -- Call Servant
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ConsumeAll(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

function mod:CallServant(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 29)
end

function mod:ConsumedServant(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:Tenderize(args)
	tenderizeCount = tenderizeCount + 1
	self:Message(args.spellId, "red", CL.count:format(args.spellName, tenderizeCount))
	if tenderizeCount == 3 then
		tenderizeCount = 0
		self:Bar(args.spellId, 36.4)
	end
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
			local t = args.time
			if t-prev > 1.5 then
				prev = t
				self:PersonalMessage(264694, "underyou")
				self:PlaySound(264694, "alarm", "gtfo")
			end
		end
	end
end
