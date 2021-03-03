
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grand Proctor Beryllia", 2284, 2421)
if not mod then return end
mod:RegisterEnableMob(162102)
mod.engageId = 2362
mod.respawnTime = 30

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
	self:Bar(325254, 3.5) -- Iron Spikes
	self:Bar(325360, 11) -- Rite of Supremacy
	self:Bar(326039, 24.1) -- Endless Torment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:IronSpikes(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 31)
end

function mod:RiteOfSupremacy(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 38.8)
end

function mod:FragmentOfRadianceApplied(args)
	if self:Me(args.destName) then
		self:StackMessage(args.spellId, args.destName, args.amount, "blue")
		self:PlaySound(args.spellId, "info", nil, self.destName)
	end
end

function mod:EndlessTorment(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 38.8)
end
