--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Amarth, The Harvester", 2286, 2391)
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
		-- Amarth
		321226, -- Land of the Dead
		{321247, "CASTBAR"}, -- Final Harvest
		333488, -- Necrotic Breath
		{320012, "DISPEL"}, -- Unholy Frenzy
		{320171, "OFF"}, -- Necrotic Bolt
		-- Reanimated Mage
		328667, -- Frostbolt Volley
	}, {
		[328667] = -22042, -- Reanimated Mage
	}
end

function mod:OnBossEnable()
	-- Amarth
	self:Log("SPELL_CAST_SUCCESS", "LandOfTheDead", 321226)
	self:Log("SPELL_CAST_START", "FinalHarvest", 321247)
	self:Log("SPELL_CAST_START", "NecroticBreath", 333488)
	self:Log("SPELL_CAST_SUCCESS", "UnholyFrenzy", 320012)
	self:Log("SPELL_CAST_START", "NecroticBolt", 320171)

	-- Reanimated Mage
	self:Log("SPELL_CAST_START", "FrostboltVolley", 328667)
end

function mod:OnEngage()
	self:StopBar(CL.active)
	if self:Tank() or self:Dispeller("enrage", true, 320012) then
		self:CDBar(320012, 6.0) -- Unholy Frenzy
	end
	self:CDBar(321226, 8.3) -- Land of the Dead
	if self:Mythic() then
		self:CDBar(333488, 29.5) -- Necrotic Breath
	end
	self:CDBar(321247, 38.5) -- Final Harvest
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 24.75, CL.active, "achievement_dungeon_theneroticwake")
end

-- Amarth

function mod:LandOfTheDead(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 42.1)
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
		self:CDBar(args.spellId, 44.5)
	end
end

function mod:NecroticBolt(args)
	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Reanimated Mage

function mod:FrostboltVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
