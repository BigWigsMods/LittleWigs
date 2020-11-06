
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Blightbone", 2286, 2395)
if not mod then return end
mod:RegisterEnableMob(162691) -- Blightbone
mod.engageId = 2387
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{320596, "SAY", "FLASH"}, -- Heaving Retch
		320630, -- Blood Gorge
		320637, -- Fetid Gas
		{320655, "TANK"}, -- Crunch
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HeavingRetchStart", 320596)
	self:Log("SPELL_AURA_APPLIED", "BloodGorgeApplied", 320630)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BloodGorgeApplied", 320630)
	self:Log("SPELL_CAST_START", "FetidGas", 320637)
	self:Log("SPELL_CAST_START", "Crunch", 320655)
end

function mod:OnEngage()
	self:Bar(320655, 5.5) -- Crunch
	self:CDBar(320596, 10.5) -- Heaving Retch
	self:Bar(320637, 22.5) -- Fetid Gas
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage(320596, "red", name)
		if self:Me(guid) then
			self:PlaySound(320596, "warning")
			self:Flash(320596)
			self:Say(320596)
		end
	end

	function mod:HeavingRetchStart(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 24.5)
	end
end

function mod:BloodGorgeApplied(args)
	local amount = args.amount or 0
	self:StackMessage(args.spellId, args.destName, args.amount, "cyan")
	if amount > 2 then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:FetidGas(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 25)
end

function mod:Crunch(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 12.5)
end
