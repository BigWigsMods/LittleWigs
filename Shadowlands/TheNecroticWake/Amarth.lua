
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Amarth, The Reanimator", 2286, 2391)
if not mod then return end
mod:RegisterEnableMob(163157) -- Amarth
mod.engageId = 2388
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		321226, -- Land of the Dead
		321247, -- Final Harvest
		333488, -- Necrotic Breath
		{320012, "TANK_HEALER"}, -- Unholy Frenzy
		320171, -- Necrotic Bolt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LandoftheDead", 321226)
	self:Log("SPELL_CAST_START", "FinalHarvest", 321247)
	self:Log("SPELL_CAST_START", "NecroticBreath", 333488)
	self:Log("SPELL_CAST_SUCCESS", "UnholyFrenzy", 320012)
	self:Log("SPELL_CAST_START", "NecroticBolt", 320171)
end

function mod:OnEngage()
	self:Bar(320012, 7) -- Unholy Frenzy
	self:Bar(321226, 12) -- Land of the Dead
	self:Bar(333488, 29.5) -- Necrotic Breath
	self:Bar(321247, 41.5) -- Final Harvest
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LandoftheDead(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 42.5)
end

function mod:FinalHarvest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 4)
	self:Bar(args.spellId, 47.5)
end

function mod:NecroticBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 46)
end

function mod:UnholyFrenzy(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 45)
end

function mod:NecroticBolt(args)
	if self:Interrupter() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end
