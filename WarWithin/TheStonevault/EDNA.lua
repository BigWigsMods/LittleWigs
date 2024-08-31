--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("E.D.N.A.", 2652, 2572)
if not mod then return end
mod:RegisterEnableMob(210108) -- E.D.N.A.
mod:SetEncounterID(2854)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local refractingBeamCount = 1
local seismicSmashCount = 1
local volatileSpikeCount = 1
local earthShattererCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_achievement_dungeon_stonevault"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		{424795, "SAY"}, -- Refracting Beam
		{424888, "TANK_HEALER"}, -- Seismic Smash
		{424889, "DISPEL"}, -- Seismic Reverberation
		424903, -- Volatile Spike
		-- Mythic
		424879, -- Earth Shatterer
	}, {
		[424879] = CL.mythic,
	}, {
		[424795] = CL.beams,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "RefractingBeam", 424795)
	self:Log("SPELL_CAST_START", "SeismicSmash", 424888)
	self:Log("SPELL_AURA_APPLIED", "SeismicReverberation", 424889)
	self:Log("SPELL_CAST_START", "VolatileSpike", 424903)

	-- Mythic
	self:Log("SPELL_CAST_START", "EarthShatterer", 424879)
end

function mod:OnEngage()
	refractingBeamCount = 1
	seismicSmashCount = 1
	volatileSpikeCount = 1
	self:StopBar(CL.active)
	if self:Mythic() then
		earthShattererCount = 1
		self:CDBar(424903, 6.0) -- Volatile Spike
		self:CDBar(424795, 14.0, CL.beams) -- Refracting Beam
		self:CDBar(424888, 18.0) -- Seismic Smash
		self:CDBar(424879, 43.0, CL.count:format(self:SpellName(424879), earthShattererCount)) -- Earth Shatterer
	else
		self:CDBar(424903, 8.1) -- Volatile Spike
		self:CDBar(424795, 11.8, CL.beams) -- Refracting Beam
		self:CDBar(424888, 15.4) -- Seismic Smash
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	-- 170.41 [CHAT_MSG_MONSTER_SAY] What's this? Is that golem fused with something else?#Dagran Thaurissan II
	-- 183.10 [NAME_PLATE_UNIT_ADDED] E.D.N.A
	self:Bar("warmup", 12.7, CL.active, L.warmup_icon)
end

do
	local playerList = {}
	local prev = 0

	function mod:RefractingBeam(args)
		local t = args.time
		if self:Mythic() then
			if t - prev > 5 then
				-- applies to all 5 players over 2 seconds, 0.5s apart. just alert on the first debuff.
				prev = t
				self:Message(args.spellId, "red", CL.beams)
				refractingBeamCount = refractingBeamCount + 1
				if refractingBeamCount % 2 == 0 then
					self:CDBar(args.spellId, 20.0, CL.beams)
				else
					self:CDBar(args.spellId, 28.0, CL.beams)
				end
				self:PlaySound(args.spellId, "alarm")
			end
		else -- Heroic, Normal
			if t - prev > 5 then
				prev = t
				playerList = {}
				self:CDBar(args.spellId, 10.9, CL.beams)
			end
			playerList[#playerList + 1] = args.destName
			if self:Heroic() then
				self:TargetsMessage(args.spellId, "red", playerList, 3, CL.beam, nil, 1.1) -- debuff applications in .5s intervals
			else -- Normal
				self:TargetsMessage(args.spellId, "red", playerList, 2, CL.beam, nil, 0.6) -- debuff applications in .5s intervals
			end
			self:PlaySound(args.spellId, "alarm", nil, playerList)
			if self:Me(args.destGUID) then
				self:Say(args.spellId, CL.beam, nil, "Beam")
			end
		end
	end
end

function mod:SeismicSmash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	if self:Mythic() then
		seismicSmashCount = seismicSmashCount + 1
		if seismicSmashCount % 2 == 0 then
			self:CDBar(args.spellId, 20.0)
		else
			self:CDBar(args.spellId, 28.0)
		end
	else -- Normal, Heroic
		self:CDBar(args.spellId, 23.1)
	end
end

function mod:SeismicReverberation(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

function mod:VolatileSpike(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	if self:Mythic() then
		volatileSpikeCount = volatileSpikeCount + 1
		if volatileSpikeCount % 2 == 0 then
			self:CDBar(args.spellId, 20.0)
		else
			self:CDBar(args.spellId, 28.0)
		end
	else -- Normal, Heroic
		self:CDBar(args.spellId, 14.6)
	end
end

-- Mythic

function mod:EarthShatterer(args)
	self:StopBar(CL.count:format(args.spellName, earthShattererCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, earthShattererCount))
	self:PlaySound(args.spellId, "long")
	earthShattererCount = earthShattererCount + 1
	self:CDBar(args.spellId, 48.0, CL.count:format(args.spellName, earthShattererCount))
end
