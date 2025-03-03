--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kul'tharok", 2293, 2389)
if not mod then return end
mod:RegisterEnableMob(162309) -- Kul'tharok
mod:SetEncounterID(2364)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local necroticEruptionCount = 1
local wellOfDarknessCount = 1
local drawSoulCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		474087, -- Necrotic Eruption
		{1223803, "SAY"}, -- Well of Darkness
		474298, -- Draw Soul
		-- Normal / Heroic
		473513, -- Feast of the Damned
		-- Mythic
		1215787, -- Death Spiral
	}, {
		[473513] = CL.normal.." / "..CL.heroic,
		[1215787] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NecroticEruption", 474087)
	self:Log("SPELL_CAST_START", "WellOfDarkness", 1223803)
	self:Log("SPELL_AURA_APPLIED", "WellOfDarknessApplied", 1223804)
	self:Log("SPELL_CAST_START", "DrawSoul", 474298)

	-- Normal / Heroic
	self:Log("SPELL_CAST_START", "FeastOfTheDamned", 473513)

	-- Mythic
	self:Log("SPELL_CAST_START", "DeathSpiral", 1215787)
	self:Log("SPELL_PERIODIC_DAMAGE", "DeathSpiralDamage", 1223240)
	self:Log("SPELL_PERIODIC_MISSED", "DeathSpiralDamage", 1223240)
end

function mod:OnEngage()
	necroticEruptionCount = 1
	wellOfDarknessCount = 1
	drawSoulCount = 1
	if self:Mythic() then
		self:CDBar(1215787, 6.1) -- Death Spiral
		self:CDBar(1223803, 10.8) -- Well of Darkness
		self:CDBar(474087, 16.7) -- Necrotic Eruption
		-- cast at 100 energy: starts at 50 energy, 25s energy gain + delay
		self:CDBar(474298, 25.1, CL.count:format(self:SpellName(474298), drawSoulCount)) -- Draw Soul
	else -- Normal, Heroic
		self:CDBar(1223803, 7.0) -- Well of Darkness
		self:CDBar(474087, 12.5) -- Necrotic Eruption
		self:CDBar(474298, 21.0, CL.count:format(self:SpellName(474298), drawSoulCount)) -- Draw Soul
		self:CDBar(473513, 48.6) -- Feast of the Damned
	end
end

function mod:VerifyEnable(unit)
	-- boss is targetable at the beginning of the wing, and casts some spells on the walkway below
	return UnitCanAttack("player", unit)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NecroticEruption(args)
	self:Message(args.spellId, "purple")
	necroticEruptionCount = necroticEruptionCount + 1
	if self:Mythic() then
		if necroticEruptionCount % 2 == 0 then
			self:CDBar(args.spellId, 20.6)
		else
			self:CDBar(args.spellId, 30.4)
		end
	else -- Normal, Heroic
		-- TODO should be less but only every other Necrotic Eruption logs
		self:CDBar(args.spellId, 59.5)
	end
	self:PlaySound(args.spellId, "alarm")
end

do
	local playerList = {}

	function mod:WellOfDarkness(args)
		playerList = {}
		wellOfDarknessCount = wellOfDarknessCount + 1
		if self:Mythic() then
			if wellOfDarknessCount % 2 == 0 then
				self:CDBar(args.spellId, 22.3)
			else
				self:CDBar(args.spellId, 27.0)
			end
		else -- Normal, Heroic
			self:CDBar(args.spellId, 58.3)
		end
	end

	function mod:WellOfDarknessApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(1223803, "red", playerList, 2)
		if self:Me(args.destGUID) then
			self:Say(1223803, nil, nil, "Well of Darkness")
		end
		self:PlaySound(1223803, "alert", nil, playerList)
	end
end

function mod:DrawSoul(args)
	self:StopBar(CL.count:format(args.spellName, drawSoulCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, drawSoulCount))
	drawSoulCount = drawSoulCount + 1
	if self:Mythic() then
		self:CDBar(1215787, {10.0, 52.2}) -- Death Spiral
		self:CDBar(1223803, {14.5, 27.0}) -- Well of Darkness
		self:CDBar(474087, {20.5, 30.4}) -- Necrotic Eruption
		-- cast at 100 energy: 4s cast time + 50s energy gain + delay
		self:CDBar(args.spellId, 54.5, CL.count:format(args.spellName, drawSoulCount))
	else -- Normal, Heroic
		self:CDBar(args.spellId, 59.5, CL.count:format(args.spellName, drawSoulCount))
	end
	self:PlaySound(args.spellId, "warning")
end

-- Normal / Heroic

function mod:FeastOfTheDamned(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 60.8)
	self:PlaySound(args.spellId, "long")
end

-- Mythic

function mod:DeathSpiral(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 52.2)
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:DeathSpiralDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(1215787, "underyou")
			self:PlaySound(1215787, "underyou")
		end
	end
end
