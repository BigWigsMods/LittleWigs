--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Benk Buzzbee", 2661, 2588)
if not mod then return end
mod:RegisterEnableMob(218002) -- Benk Buzzbee
mod:SetEncounterID(2931)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		438025, -- Snack Time
		439524, -- Fluttering Wing
		{440134, "SAY_COUNTDOWN"}, -- Honey Marinade
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SnackTime", 438025)
	self:Log("SPELL_CAST_START", "FlutteringWing", 439524)
	self:Log("SPELL_CAST_START", "HoneyMarinade", 440134)
	self:Log("SPELL_AURA_APPLIED", "HoneyMarinadeApplied", 440134)
	self:Log("SPELL_AURA_REMOVED", "HoneyMarinadeRemoved", 440134)
end

function mod:OnEngage()
	self:CDBar(438025, 3.0) -- Snack Time
	self:CDBar(440134, 10.0) -- Honey Marinade
	self:CDBar(439524, 22.0) -- Fluttering Wing
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SnackTime(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 33.0)
end

function mod:FlutteringWing(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23.0)
end

function mod:HoneyMarinade(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 14.0)
end

function mod:HoneyMarinadeApplied(args)
	if self:Me(args.destGUID) then
		self:SayCountdown(args.spellId, 5)
	end
end

function mod:HoneyMarinadeRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end
