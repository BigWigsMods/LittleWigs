--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Amarth, The Reanimator", 2286, 2391)
if not mod then return end
mod:RegisterEnableMob(163157) -- Amarth
mod:SetEncounterID(2388)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		321226, -- Land of the Dead
		{321247, "CASTBAR"}, -- Final Harvest
		333488, -- Necrotic Breath
		{320012, "DISPEL"}, -- Unholy Frenzy
		320171, -- Necrotic Bolt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "LandoftheDead", 321226)
	self:Log("SPELL_CAST_START", "FinalHarvest", 321247)
	self:Log("SPELL_CAST_START", "NecroticBreath", 333488)
	self:Log("SPELL_CAST_SUCCESS", "UnholyFrenzy", 320012)
	self:Log("SPELL_CAST_START", "NecroticBolt", 320171)
end

function mod:OnEngage()
	self:StopBar(CL.active)
	if self:Tank() or self:Dispeller("enrage", true, 320012) then
		self:CDBar(320012, 6.0) -- Unholy Frenzy
	end
	self:CDBar(321226, 10.9) -- Land of the Dead
	self:CDBar(333488, 29.5) -- Necrotic Breath
	self:CDBar(321247, 41.5) -- Final Harvest
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 24.75, CL.active, "achievement_dungeon_theneroticwake")
end

function mod:LandoftheDead(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 42.5)
end

function mod:FinalHarvest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 4)
	self:CDBar(args.spellId, 44.8)
end

function mod:NecroticBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 40.9)
end

function mod:UnholyFrenzy(args)
	if self:Tank() or self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 44.9)
	end
end

function mod:NecroticBolt(args)
	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end
