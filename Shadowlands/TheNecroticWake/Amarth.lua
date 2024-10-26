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
		{328667, "NAMEPLATE"}, -- Frostbolt Volley
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
	self:Log("SPELL_SUMMON", "LandOfTheDeadSummon", 333627) -- summons Reanimated Mage
	self:Log("SPELL_CAST_START", "FrostboltVolley", 328667)
	self:Log("SPELL_INTERRUPT", "FrostboltVolleyInterrupt", 328667)
	self:Log("SPELL_CAST_SUCCESS", "FrostboltVolleySuccess", 328667)
	self:Death("ReanimatedMageDeath", 164414)
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

function mod:VerifyEnable(unit)
	-- the boss flies around for some RP
	return UnitCanAttack("player", unit)
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
	self:CDBar(args.spellId, 42.1)
	self:PlaySound(args.spellId, "long")
end

function mod:FinalHarvest(args)
	self:Message(args.spellId, "red")
	self:CastBar(args.spellId, 4)
	self:CDBar(args.spellId, 44.8)
	self:PlaySound(args.spellId, "warning")
end

function mod:NecroticBreath(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 40.9)
	self:PlaySound(args.spellId, "alarm")
end

function mod:UnholyFrenzy(args)
	if self:Tank() or self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 44.5)
		self:PlaySound(args.spellId, "info")
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

function mod:LandOfTheDeadSummon(args)
	self:Nameplate(328667, 7.0, args.destGUID) -- Frostbolt Volley
end

function mod:FrostboltVolley(args)
	if self:MobId(args.sourceGUID) == 164414 then -- Reanimated Mage, boss summon
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:FrostboltVolleyInterrupt(args)
	if self:MobId(args.destGUID) == 164414 then -- Reanimated Mage, boss summon
		self:Nameplate(328667, 12.1, args.destGUID)
	end
end

function mod:FrostboltVolleySuccess(args)
	if self:MobId(args.sourceGUID) == 164414 then -- Reanimated Mage, boss summon
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	end
end

function mod:ReanimatedMageDeath(args)
	self:ClearNameplate(args.destGUID)
end
