--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Myza's Oasis", 2441, 2452)
if not mod then return end
mod:RegisterEnableMob(
	179792, -- Horn
	177607, -- Saxophone
	179783, -- Guitar
	177608, -- Trumpet
	175600, -- Drumset
	176563, -- Zo'gron
	176562, -- Brawling Patron
	176565, -- Disruptive Patron
	179269, -- Oasis Security
	180486, -- Dirtwhistle (Hard Mode)
	180399, -- Evaile (Hard Mode)
	180485, -- Hips (Hard Mode)
	180470, -- Verethian (Hard Mode)
	180484 -- Vilt (Hard Mode)
)
--mod:SetEncounterID(2440) no boss frames in Stage 1
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local addWave = 0
local finalWarningCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.add_wave_killed = "Add wave killed (%d/%d)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		359019, -- Up Tempo
		-- Unruly Patron
		356482, -- Rotten Food
		-- Disruptive Patron
		{353783, "NAMEPLATE"}, -- Teleport
		-- Oasis Security
		{350916, "TANK", "NAMEPLATE"}, -- Security Slam
		{350922, "NAMEPLATE"}, -- Menacing Shout
		-- All Stage One adds
		353706, -- Rowdy
		-- Zo'gron
		350919, -- Crowd Control
		355438, -- Suppression Spark
		{359028, "TANK"}, -- Security Slam
		{1241032, "CASTBAR"}, -- Final Warning
		-- Hard Mode
		{357404, "NAMEPLATE"}, -- Dischordant Song
		{357436, "NAMEPLATE"}, -- Infectious Solo
		{357542, "NAMEPLATE"}, -- Rip Chord
	}, {
		[359019] = -23096, -- Stage One: Unruly Patrons
		[350919] = -23749, -- Stage Two: Closing Time
		[357404] = CL.hard,
	}
end

function mod:OnBossEnable()
	-- Staging
	-- manually handle ENCOUNTER_START and ENCOUNTER_END because there are no boss frames until Stage 2
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("ENCOUNTER_END")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")

	-- General
	self:Log("SPELL_AURA_APPLIED", "UpTempoApplied", 359019)

	-- Unruly Patron
	self:Log("SPELL_CAST_SUCCESS", "RottenFood", 359222)

	-- Disruptive Patron
	self:RegisterEngageMob("DisruptivePatronEngaged", 176565)
	self:Log("SPELL_CAST_START", "Teleport", 353783)

	-- Oasis Security
	self:RegisterEngageMob("OasisSecurityEngaged", 179269)
	self:Log("SPELL_CAST_START", "SecuritySlamAdd", 350916)
	self:Log("SPELL_CAST_START", "MenacingShout", 350922)

	-- All adds
	self:Log("SPELL_AURA_APPLIED", "RowdyApplied", 353706)

	-- Zo'gron
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Zo'gron engaged
	self:Log("SPELL_CAST_START", "SecuritySlamBoss", 359028)
	self:Log("SPELL_CAST_START", "CrowdControl", 350919)
	self:Log("SPELL_CAST_START", "SuppressionSpark", 355438)
	self:Log("SPELL_CAST_START", "FinalWarning", 1241032)
	self:Log("SPELL_AURA_REMOVED", "FinalWarningRemoved", 1241023)

	-- Hard Mode
	self:RegisterEngageMob("EvaileEngaged", 180399)
	self:Log("SPELL_CAST_START", "DischordantSong", 357404)
	self:RegisterEngageMob("VerethianEngaged", 180470)
	self:Log("SPELL_CAST_START", "InfectiousSolo", 357436)
	self:RegisterEngageMob("ViltEngaged", 180484)
	self:Log("SPELL_CAST_START", "RipChord", 357542)
end

function mod:OnEngage()
	addWave = 0
	finalWarningCount = 1
	self:SetStage(1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == 2440 then
		self:Engage()
	end
end

function mod:ENCOUNTER_END(_, encounterId, _, _, _, status)
	if encounterId == 2440 then
		if status == 0 then
			-- delay slightly to avoid reregistering ENCOUNTER_END as part of Reboot during this ENCOUNTER_END dispatch
			self:SimpleTimer(function() self:Wipe() end, 1)
		else
			self:Win()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE()
	if self:IsEngaged() then
		-- [CHAT_MSG_RAID_BOSS_EMOTE] Get to your spotlight and hit notes when they light up!#[DNT] Encounter Controller
		self:StopBar(353706) -- Rowdy
		-- There is one performance phase immediately at the start of the fight and then one after each add wave
		if addWave >= 1 then
			self:Message("stages", "cyan", L.add_wave_killed:format(addWave, 2), "achievement_dungeon_brokerdungeon")
			self:PlaySound("stages", "long")
		end
		addWave = addWave + 1
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg)
	-- [CHAT_MSG_RAID_BOSS_WHISPER] |TInterface\\Icons\\Spell_Shadow_DeathPact.blp:20|t Unruly patrons rush the stage!#Oasis Security
	if msg:find("Spell_Shadow_DeathPact", nil, true) and addWave <= 2 then
		self:CDBar(353706, 41.3) -- Rowdy
	end
end

function mod:EncounterEvent(args) -- Zo'gron engaged
	if self:MobId(args.sourceGUID) == 176563 then -- Zo'gron
		finalWarningCount = 1
		self:SetStage(2)
		self:Message("stages", "cyan", CL.other:format(CL.stage:format(2), args.sourceName), "achievement_dungeon_brokerdungeon")
		self:CDBar(359028, 8.8) -- Security Slam
		self:CDBar(350922, 12.5) -- Menacing Shout
		self:CDBar(350919, 18.5) -- Crowd Control
		self:CDBar(355438, 27.1) -- Suppression Spark
		self:PlaySound("stages", "long")
	end
end

-- General

function mod:UpTempoApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.you:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Unruly Patron

do
	local prev = 0
	function mod:RottenFood(args)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(356482, "orange")
			self:PlaySound(356482, "alarm")
		end
	end
end

-- Disruptive Patron

function mod:DisruptivePatronEngaged(guid)
	self:Nameplate(353783, 11.1, guid) -- Teleport
end

function mod:Teleport(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 16.9, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

-- Oasis Security

function mod:OasisSecurityEngaged(guid)
	self:Nameplate(350916, 3.8, guid) -- Security Slam
	self:Nameplate(350922, 9.9, guid) -- Menacing Shout
end

do
	local prev = 0
	function mod:SecuritySlamAdd(args)
		self:Nameplate(args.spellId, 14.6, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:MenacingShout(args)
		if self:MobId(args.sourceGUID) == 179269 then -- Oasis Security
			self:Nameplate(args.spellId, 21.8, args.sourceGUID)
		else -- 176563, Zo'gron
			self:CDBar(args.spellId, 23.1)
		end
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- All adds

do
	local prev = 0
	function mod:RowdyApplied(args)
		if args.time - prev > 4 then
			prev = args.time
			self:StopBar(args.spellId)
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "long")
		end
	end
end

-- Zo'gron

function mod:CrowdControl(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 21.8)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SuppressionSpark(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 37.7)
	self:PlaySound(args.spellId, "info")
end

function mod:SecuritySlamBoss(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

do
	local finalWarningStart = 0

	function mod:FinalWarning(args)
		finalWarningStart = args.time
		if finalWarningCount == 1 then
			self:Message(args.spellId, "yellow", CL.percent:format(65, args.spellName))
		else -- 2nd cast
			self:Message(args.spellId, "yellow", CL.percent:format(35, args.spellName))
		end
		finalWarningCount = finalWarningCount + 1
		self:CastBar(args.spellId, 20)
		self:PlaySound(args.spellId, "long")
	end

	function mod:FinalWarningRemoved(args)
		-- the cast now automatically ends when the shield is removed
		self:StopCastBar(1241032)
		if args.amount == 0 then -- shield was broken
			local finalWarningDuration = args.time - finalWarningStart
			self:Message(1241032, "green", CL.removed_after:format(args.spellName, finalWarningDuration))
			self:PlaySound(1241032, "info")
		end
	end
end

-- Hard Mode

function mod:EvaileEngaged(guid)
	self:Nameplate(357404, 13.9, guid) -- Dischordant Song
end

function mod:DischordantSong(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 20.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:VerethianEngaged(guid)
	self:Nameplate(357436, 9.9, guid) -- Infectious Solo
end

function mod:InfectiousSolo(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 20.2, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:ViltEngaged(guid)
	self:Nameplate(357542, 16.1, guid) -- Rip Chord
end

function mod:RipChord(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 16.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end
