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
		320630, -- Blood Gorge
		320637, -- Fetid Gas
		{320655, "TANK"}, -- Crunch
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HeavingRetch", 320596)
	self:Log("SPELL_AURA_APPLIED", "BloodGorgeApplied", 320630)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BloodGorgeApplied", 320630)
	self:Log("SPELL_CAST_START", "FetidGas", 320637)
	self:Log("SPELL_CAST_START", "Crunch", 320655)
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

do
	local prev = 0
	function mod:BloodGorgeApplied(args)
		local amount = args.amount or 1
		self:StackMessage(args.spellId, "cyan", args.destName, amount, 2)
		local t = args.time
		if amount > 2 and t - prev > 1.5 then
			prev = t
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:FetidGas(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 25.5)
end

function mod:Crunch(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 12.1)
end
