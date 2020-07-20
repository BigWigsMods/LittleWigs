
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Amarth, The Reanimator", 2286, 2391)
if not mod then return end
mod:RegisterEnableMob(163157) -- Amarth
mod.engageId = 2388
--mod.respawnTime = 30

local frenzyCount = 1
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		321226, -- Land of the Dead
		321247, -- Final Harvest
		--322519, -- Bone Spikes
		--320015, -- Unholy Frenzy
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LandoftheDeadStart", 321226)
	self:Log("SPELL_CAST_START", "FinalHarvestStart", 321247)
	self:Log("SPELL_CAST_START", "BoneSpikesStart", 321247)
	self:Log("SPELL_CAST_START", "UnholyFrenzyStart", 320015)
end

function mod:OnEngage()
	frenzyCount = 1

	--self:CDBar(322519, 8.6) -- Bone Spikes
	--self:CDBar(320015, 11.9) -- Unholy Frenzy
	self:CDBar(321226, 17.1) -- Land of the Dead
	self:CDBar(321247, 42.2) -- Final Harvest
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LandoftheDeadStart(args)
	self:Message2(args.spellId, "yellow")
	--self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 37.7)
end

function mod:FinalHarvestStart(args)
	self:Message2(args.spellId, "red")
	--self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 4)
	self:Bar(args.spellId, 37.7)
end

function mod:BoneSpikesStart(args)
	self:Message2(args.spellId, "orange")
	--self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 20)
end

function mod:UnholyFrenzyStart(args)
	self:Message2(args.spellId, "purple")
	--self:PlaySound(args.spellId, "alarm")
	frenzyCount = frenzyCount + 1
	self:CDBar(args.spellId, frenzyCount == 4 and 35 or 25.5)
end
