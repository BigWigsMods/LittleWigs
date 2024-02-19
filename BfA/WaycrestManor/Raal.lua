--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Raal the Gluttonous", 1862, 2127)
if not mod then return end
mod:RegisterEnableMob(131863) -- Raal the Gluttonous
mod:SetEncounterID(2115)
mod:SetRespawnTime(20)

--------------------------------------------------------------------------------
-- Locals
--

local rottenExpulsionCount = 1
local tenderizeCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		264734, -- Consume All
		264931, -- Call Servant
		265005, -- Well-Fed
		264923, -- Tenderize
		{264694, "SAY"}, -- Rotten Expulsion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ConsumeAll", 264734)
	self:Log("SPELL_CAST_START", "CallServant", 264931)
	self:Log("SPELL_AURA_APPLIED", "WellFedApplied", 265005)
	self:Log("SPELL_AURA_APPLIED_DOSE", "WellFedApplied", 265005)
	self:Log("SPELL_CAST_START", "Tenderize", 264923)
	self:Log("SPELL_CAST_SUCCESS", "TenderizeSuccess", 264923)
	self:Log("SPELL_CAST_START", "RottenExpulsion", 264694)
	self:Log("SPELL_PERIODIC_DAMAGE", "RottenExpulsionDamage", 264712) -- no alert on APPLIED, doesn't damage right away
	self:Log("SPELL_PERIODIC_MISSED", "RottenExpulsionDamage", 264712)
end

function mod:OnEngage()
	rottenExpulsionCount = 1
	tenderizeCount = 1
	self:CDBar(264694, 5.5) -- Rotten Expulsion
	self:CDBar(264923, 20.4) -- Tenderize
	self:CDBar(264931, 32.6) -- Call Servant
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ConsumeAll(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "warning")
end

function mod:CallServant(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 43.7)
end

function mod:WellFedApplied(args)
	self:Message(args.spellId, "red", CL.stack:format(args.amount or 1, args.spellName, CL.boss))
	self:PlaySound(args.spellId, "info")
end

function mod:Tenderize(args)
	self:Message(args.spellId, "orange", CL.count_amount:format(args.spellName, tenderizeCount, 3))
	self:PlaySound(args.spellId, "alarm")
	if tenderizeCount == 1 then
		self:CDBar(args.spellId, 43.7)
	end
end

function mod:TenderizeSuccess(args)
	-- if one of the 3 Tenderize casts is interrupted (feign, vanish, etc) the boss will just recast it,
	-- so only increment the count on a successful cast.
	tenderizeCount = tenderizeCount % 3 + 1
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(264694, "yellow", name)
		self:PlaySound(264694, "alert", nil, name)
		if self:Me(guid) then
			self:Say(264694, nil, nil, "Rotten Expulsion")
		end
	end

	function mod:RottenExpulsion(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		rottenExpulsionCount = rottenExpulsionCount + 1
		if rottenExpulsionCount == 2 then
			self:CDBar(args.spellId, 29.2)
		else
			self:CDBar(args.spellId, 20.6)
		end
	end
end

do
	local prev = 0
	function mod:RottenExpulsionDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(264694, "underyou")
				self:PlaySound(264694, "underyou", nil, args.destName)
			end
		end
	end
end
