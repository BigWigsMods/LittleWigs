if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("E.D.N.A.", 2652, 2572)
if not mod then return end
mod:RegisterEnableMob(210108) -- E.D.N.A.
mod:SetEncounterID(2854)
mod:SetRespawnTime(30)

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
		{424795, "SAY", "ME_ONLY_EMPHASIZE"}, -- Refracting Beam
		{424888, "TANK_HEALER"}, -- Seismic Smash
		{424889, "DISPEL"}, -- Seismic Reverberation
		424903, -- Volatile Spike
		424879, -- Earth Shatterer
	}, {
		[424879] = CL.mythic,
	}, {
		[424795] = CL.beams,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") -- XXX no boss frames
	self:Log("SPELL_AURA_APPLIED", "RefractingBeamApplied", 424795)
	self:Log("SPELL_AURA_REMOVED", "RefractingBeamRemoved", 424795)
	self:Log("SPELL_CAST_START", "SeismicSmash", 424888)
	self:Log("SPELL_AURA_APPLIED", "SeismicReverberation", 424889)
	self:Log("SPELL_CAST_START", "VolatileSpike", 424903)
	self:Log("SPELL_CAST_START", "EarthShatterer", 424879)
end

function mod:OnEngage()
	self:StopBar(CL.active)
	self:CDBar(424903, 6.0) -- Volatile Spike
	self:CDBar(424795, 9.7, CL.beams) -- Refracting Beam
	self:CDBar(424888, 15.4) -- Seismic Smash
	if self:Mythic() then
		self:CDBar(424879, 25.1) -- Earth Shatterer
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- XXX no boss frames
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

function mod:Warmup() -- called from trash module
	-- 170.41 [CHAT_MSG_MONSTER_SAY] What's this? Is that golem fused with something else?#Dagran Thaurissan II
	-- 183.10 [NAME_PLATE_UNIT_ADDED] E.D.N.A
	self:Bar("warmup", 12.7, CL.active, L.warmup_icon)
end

do
	local playerList = {}

	function mod:RefractingBeamApplied(args)
		if not self:Player(args.destFlags) then
			-- the boss RP fights some Skardyn Invaders before becoming active
			return
		end
		playerList[#playerList + 1] = args.destName
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		if self:Mythic() then
			self:TargetsMessage(args.spellId, "red", playerList, 3, CL.beam, nil, 1.1) -- debuff staggers applications in .5s intervals
		else
			self:TargetsMessage(args.spellId, "red", playerList, 2, CL.beam, nil, 0.6) -- debuff staggers applications in .5s intervals
		end
		if self:Me(args.destGUID) then
			self:Say(args.spellId, CL.beam, nil, "Beam")
		end
		if #playerList == 1 then
			self:CDBar(args.spellId, 10.9, CL.beams)
		end
	end

	function mod:RefractingBeamRemoved(args)
		-- TODO there is no SPELL_CAST_SUCCESS
		playerList = {}
	end
end

function mod:SeismicSmash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 22.2)
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
		self:CDBar(args.spellId, 27.5)
	else
		self:CDBar(args.spellId, 14.5) -- TODO recheck?
	end
end

function mod:EarthShatterer(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 54.5)
end
