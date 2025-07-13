local isElevenDotTwo = BigWigsLoader.isNext -- XXX remove in 11.2
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
	179269 -- Oasis Security
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

if isElevenDotTwo then -- XXX remove check in 11.2
	function mod:GetOptions()
		return {
			"stages",
			-- Unruly Patron
			356482, -- Rotten Food
			-- Disruptive Patron
			{353783, "NAMEPLATE"}, -- Teleport
			353835, -- Suppression
			-- Oasis Security
			{350916, "TANK", "NAMEPLATE"}, -- Security Slam
			{350922, "NAMEPLATE"}, -- Menacing Shout
			-- All Stage One adds
			353706, -- Rowdy
			-- Zo'gron
			350919, -- Crowd Control
			355438, -- Suppression Spark
			{359028, "TANK"}, -- Security Slam
			1241032, -- Final Warning
		}, {
			[356482] = -23096, -- Stage One: Unruly Patrons
			[350922] = -23749, -- Stage Two: Closing Time
		}
	end
else -- XXX remove block in 11.2
	function mod:GetOptions()
		return {
			"stages",
			-- Unruly Patron
			356482, -- Rotten Food
			-- Disruptive Patron
			{353783, "NAMEPLATE"}, -- Teleport
			353835, -- Suppression
			-- Oasis Security
			{350916, "TANK", "NAMEPLATE"}, -- Security Slam
			{350922, "NAMEPLATE"}, -- Menacing Shout
			-- All Stage One adds
			353706, -- Rowdy
			-- Zo'gron
			350919, -- Crowd Control
			355438, -- Suppression Spark
			{359028, "TANK"}, -- Security Slam
		}, {
			[356482] = -23096, -- Stage One: Unruly Patrons
			[350922] = -23749, -- Stage Two: Closing Time
		}
	end
end

function mod:OnBossEnable()
	-- Staging
	self:RegisterEvent("ENCOUNTER_START") -- no boss frames until Stage 2
	self:RegisterEvent("ENCOUNTER_END") -- no boss frames until Stage 2
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")

	-- Unruly Patron
	self:Log("SPELL_CAST_SUCCESS", "RottenFood", 359222)

	-- Disruptive Patron
	self:RegisterEngageMob("DisruptivePatronEngaged", 176565)
	self:Log("SPELL_CAST_START", "Teleport", 353783)
	self:Log("SPELL_CAST_START", "Suppression", 353835) -- XXX not cast? still in journal

	-- Oasis Security
	self:RegisterEngageMob("OasisSecurityEngaged", 179269)
	self:Log("SPELL_CAST_START", "SecuritySlamAdd", 350916)
	self:Log("SPELL_CAST_START", "MenacingShout", 350922)

	-- All adds
	self:Log("SPELL_AURA_APPLIED", "RowdyApplied", 353706)

	-- Zo'gron
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Zo'gron engaged
	end
	self:Log("SPELL_CAST_START", "SecuritySlamBoss", 359028)
	self:Log("SPELL_CAST_START", "CrowdControl", 350919)
	self:Log("SPELL_CAST_START", "SuppressionSpark", 355438)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_CAST_START", "FinalWarning", 1241032)
	end
end

function mod:OnEngage()
	addWave = 0
	finalWarningCount = 1
	self:SetStage(1)
	if not isElevenDotTwo then -- XXX remove in 11.2
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	end
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
			self:Wipe()
		else
			self:Win()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE()
	self:StopBar(353706) -- Rowdy
	-- There is one performance phase immediately at the start of the fight and then one after each add wave
	if addWave >= 1 then
		self:Message("stages", "cyan", L.add_wave_killed:format(addWave, 2), "achievement_dungeon_brokerdungeon")
		self:PlaySound("stages", "long")
	end
	addWave = addWave + 1
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER()
	-- Unruly patrons rush the stage!
	if addWave <= 2 then
		self:CDBar(353706, 41.3) -- Rowdy
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT() -- XXX remove in 11.2
	if self:GetStage() == 1 and self:GetBossId(176563) then -- Zo'gron
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), "achievement_dungeon_brokerdungeon")
		self:CDBar(359028, 8.8) -- Security Slam
		self:CDBar(350922, 12.5) -- Menacing Shout
		self:CDBar(350919, 18.5) -- Crowd Control
		self:CDBar(355438, 27.1) -- Suppression Spark
		self:PlaySound("stages", "long")
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

function mod:Suppression(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
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

function mod:FinalWarning(args)
	if finalWarningCount == 1 then
		self:Message(args.spellId, "yellow", CL.percent:format(66, args.spellName))
	else -- 2nd cast
		self:Message(args.spellId, "yellow", CL.percent:format(35, args.spellName))
	end
	finalWarningCount = finalWarningCount + 1
	self:PlaySound(args.spellId, "long")
end
