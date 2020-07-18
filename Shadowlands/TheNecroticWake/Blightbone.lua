
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
	self:Log("SPELL_AURA_APPLIED", "BloodGorgeApplied", 257829)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BloodGorgeApplied", 257829)
	self:Log("SPELL_CAST_START", "FetidGasStart", 320637)
	self:Log("SPELL_CAST_START", "CrunchStart", 320655)
end

function mod:OnEngage()
	self:CDBar(320655, 10.5) -- Crunch
	self:CDBar(320596, 10.5) -- Heaving Retch
	self:CDBar(320637, 10.5) -- Fetid Gas
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(320596, "red", name)
		if self:Me(guid) then
			--self:PlaySound(320596, "warning")
			self:Flash(320596)
			self:Say(320596)
		else
			--self:PlaySound(320596, "alarm")
		end
	end

	function mod:HeavingRetchStart(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 22.5)
	end
end

function mod:BloodGorgeApplied(args)
	local amount = args.amount or 0
	self:StackMessage(args.spellId, args.destName, args.amount, "cyan")
	if amount > 2 then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:FetidGasStart(args)
	self:Message2(args.spellId, "yellow", CL.casting:format(args.spellName))
	--self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 25)
end

function mod:CrunchStart(args)
	self:Message2(args.spellId, "purple", CL.casting:format(args.spellName))
	--self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12)
end
