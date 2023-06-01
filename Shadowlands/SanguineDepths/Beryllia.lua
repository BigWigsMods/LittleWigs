--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grand Proctor Beryllia", 2284, 2421)
if not mod then return end
mod:RegisterEnableMob(162102) -- Grand Proctor Beryllia
mod:SetEncounterID(2362)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local ironSpikesCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{325254, "TANK_HEALER"}, -- Iron Spikes
		325360, -- Rite of Supremacy
		328737, -- Fragment of Radiance
		326039, -- Endless Torment
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "IronSpikes", 325254)
	self:Log("SPELL_CAST_START", "RiteOfSupremacy", 325360)
	self:Log("SPELL_AURA_APPLIED", "FragmentOfRadianceApplied", 328737)
	self:Log("SPELL_CAST_SUCCESS", "EndlessTorment", 326039)
end

function mod:OnEngage()
	ironSpikesCount = 0
	self:Bar(325254, 3.5) -- Iron Spikes
	self:Bar(325360, 11) -- Rite of Supremacy
	self:Bar(326039, 24.1) -- Endless Torment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:IronSpikes(args)
	ironSpikesCount = ironSpikesCount + 1
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	-- Iron Spikes syncs up with the 38.8 second ability cadence after the first cast
	self:Bar(args.spellId, ironSpikesCount == 1 and 31 or 38.8)
end

function mod:RiteOfSupremacy(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 38.8)
end

function mod:FragmentOfRadianceApplied(args)
	if self:Me(args.destGUID) then
		self:StackMessageOld(args.spellId, args.destName, args.amount, "blue")
		self:PlaySound(args.spellId, "info", nil, self.destName)
	end
end

function mod:EndlessTorment(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 38.8)
end
