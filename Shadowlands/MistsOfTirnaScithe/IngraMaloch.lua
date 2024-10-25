--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ingra Maloch", 2290, 2400)
if not mod then return end
mod:RegisterEnableMob(164567, 164804) -- Ingra Maloch, Droman Oulfarran
mod:SetEncounterID(2397)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local embraceDarknessCount = 1
local nextBewilderingPollen = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Droman Oulfarran
		323137, -- Bewildering Pollen
		323177, -- Tears of the Forest
		323250, -- Anima Puddle
		{323059, "CASTBAR"}, -- Droman's Wrath
		-- Ingra Maloch
		323057, -- Spirit Bolt
		328756, -- Repulsive Visage
		323149, -- Embrace Darkness
	},{
		[323137] = -21653, -- Droman Oulfarran
		[323057] = self.displayName, -- Ingra Maloch
	},{
		[328756] = CL.fear, -- Repulsive Visage (Fear)
	}
end

function mod:OnBossEnable()
	-- Droman Oulfarran
	self:Log("SPELL_CAST_START", "BewilderingPollen", 323137)
	self:Log("SPELL_CAST_SUCCESS", "TearsOfTheForest", 323177)
	self:Log("SPELL_PERIODIC_DAMAGE", "AnimaPuddle", 323250)
	self:Log("SPELL_PERIODIC_MISSED", "AnimaPuddle", 323250)
	self:Log("SPELL_CAST_START", "DromansWrath", 323059)
	self:Log("SPELL_AURA_APPLIED", "DromansWrathApplied", 323059)
	self:Log("SPELL_AURA_REMOVED", "DromansWrathRemoved", 323059)

	-- Ingra Maloch
	self:Log("SPELL_CAST_START", "SpiritBolt", 323057)
	self:Log("SPELL_CAST_START", "RepulsiveVisage", 328756)
	self:Log("SPELL_CAST_START", "EmbraceDarkness", 323149)
end

function mod:OnEngage()
	local t = GetTime()
	embraceDarknessCount = 1
	nextBewilderingPollen = t + 7.2
	self:SetStage(1)
	self:CDBar(323137, 7.2) -- Bewildering Pollen
	self:CDBar(323177, 19.6) -- Tears of the Forest
	if self:Mythic() then
		self:CDBar(328756, 31.2, CL.fear) -- Repulsive Visage
	end
	self:CDBar(323149, 35.3, CL.count:format(self:SpellName(323149), embraceDarknessCount)) -- Embrace Darkness
end

function mod:VerifyEnable(_, mobId)
	if mobId == 164804 then -- Droman Oulfarran is friendly after the fight
		local info = C_ScenarioInfo.GetCriteriaInfo(1)
		return info and not info.completed
	end
	return true
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Droman Oulfarran

function mod:BewilderingPollen(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	nextBewilderingPollen = GetTime() + 20.6
	self:CDBar(args.spellId, 20.6)
end

function mod:TearsOfTheForest(args)
	local t = GetTime()
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 20.7)
	-- 9.74 minimum to Bewildering Pollen
	if nextBewilderingPollen - t < 9.74 then
		nextBewilderingPollen = t + 9.74
		self:CDBar(323137, {9.74, 20.6}) -- Bewildering Pollen
	end
end

do
	local prev = 0
	function mod:AnimaPuddle(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

function mod:DromansWrath(args)
	self:Message(args.spellId, "green", CL.casting:format(args.spellName))
end

function mod:DromansWrathApplied(args)
	self:Message(args.spellId, "green", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:StopBar(CL.count:format(self:SpellName(323149), embraceDarknessCount))
	self:SetStage(2)
	self:CastBar(args.spellId, 15)
	self:CDBar(323137, 27.1) -- Bewildering Pollen
	self:CDBar(323177, 41.2) -- Tears of the Forest
	if self:Mythic() then
		self:CDBar(328756, 52.8, CL.fear) -- Repulsive Visage
	end
	-- increment Embrace Darkness count here instead in case the ability is skipped
	embraceDarknessCount = embraceDarknessCount + 1
	self:CDBar(323149, 55.1, CL.count:format(self:SpellName(323149), embraceDarknessCount)) -- Embrace Darkness
end

function mod:DromansWrathRemoved(args)
	self:SetStage(1)
	self:Message(args.spellId, "cyan", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

-- Ingra Maloch

function mod:SpiritBolt(args)
	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:RepulsiveVisage(args)
	self:Message(args.spellId, "red", CL.casting:format(CL.fear))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 34.9, CL.fear)
end

function mod:EmbraceDarkness(args)
	self:StopBar(CL.count:format(args.spellName, embraceDarknessCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, embraceDarknessCount))
	self:PlaySound(args.spellId, "info")
end
