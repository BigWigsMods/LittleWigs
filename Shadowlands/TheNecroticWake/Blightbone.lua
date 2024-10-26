--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Blightbone", 2286, 2395)
if not mod then return end
mod:RegisterEnableMob(162691) -- Blightbone
mod:SetEncounterID(2387)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{320596, "SAY"}, -- Heaving Retch
		320637, -- Fetid Gas
		{320655, "TANK"}, -- Crunch
		-- Carrion Worm
		{320717, "NAMEPLATE"}, -- Blood Hunger
		320630, -- Blood Gorge
		320631, -- Carrion Eruption
	}, {
		[320717] = -21604, -- Carrion Worm
	}, {
		[320717] = CL.fixate, -- Blood Hunger (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HeavingRetch", 320596)
	self:Log("SPELL_CAST_START", "FetidGas", 320637)
	self:Log("SPELL_CAST_START", "Crunch", 320655)

	-- Carrion Worm
	self:Log("SPELL_AURA_APPLIED", "BloodHungerApplied", 320717)
	self:Log("SPELL_AURA_REMOVED", "BloodHungerRemoved", 320717)
	self:Log("SPELL_AURA_APPLIED", "BloodGorgeApplied", 320630)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BloodGorgeApplied", 320630)
	self:Log("SPELL_CAST_START", "CarrionEruption", 320631)
end

function mod:OnEngage()
	self:CDBar(320655, 5.2) -- Crunch
	self:CDBar(320596, 10.5) -- Heaving Retch
	self:CDBar(320637, 22.5) -- Fetid Gas
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage(320596, "red", name)
		if self:Me(guid) then
			self:PlaySound(320596, "warning")
			self:Say(320596, nil, nil, "Heaving Retch")
		else
			self:PlaySound(320596, "alarm", nil, name)
		end
	end

	function mod:HeavingRetch(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 32.7)
	end
end

function mod:FetidGas(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 25.5)
	self:PlaySound(args.spellId, "long")
end

function mod:Crunch(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alert")
end

-- Carrion Worm

function mod:BloodHungerApplied(args)
	if self:Me(args.destGUID) then
		self:Nameplate(args.spellId, 60, args.sourceGUID, CL.fixate)
	end
end

function mod:BloodHungerRemoved(args)
	if self:Me(args.destGUID) then
		self:StopNameplate(args.spellId, args.sourceGUID, CL.fixate)
	end
end

do
	local prev = 0
	function mod:BloodGorgeApplied(args)
		local amount = args.amount or 1
		self:StackMessage(args.spellId, "cyan", args.destName, amount, 3)
		if amount > 2 and args.time - prev > 2 then
			prev = args.time
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local prev = 0
	function mod:CarrionEruption(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end
