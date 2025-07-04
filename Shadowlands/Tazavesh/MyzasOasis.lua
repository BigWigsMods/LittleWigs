--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Myza's Oasis", 2441, 2452)
if not mod then return end
mod:RegisterEnableMob(
	176563, -- Zo'gron
	176562, -- Brawling Patron
	176565, -- Disruptive Patron
	179269  -- Oasis Security
)
mod:SetEncounterID(2440)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local addWave = 0

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
		-- Unruly Patron
		356482, -- Rotten Food
		-- Disruptive Patron
		353783, -- Teleport
		353835, -- Suppression
		-- Oasis Security
		{350916, "TANK"}, -- Security Slam
		-- All add waves
		353706, -- Rowdy
		-- Zo'gron
		350922, -- Menacing Shout
		350919, -- Crowd Control
		355438, -- Suppression Spark
		{359028, "TANK"}, -- Security Slam
	}, {
		[356482] = -23096, -- Stage One: Unruly Patrons
		[350922] = -23749, -- Stage Two: Closing Time
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
	self:Log("SPELL_CAST_SUCCESS", "RottenFood", 359222)
	self:Log("SPELL_CAST_START", "Teleport", 353783)
	self:Log("SPELL_CAST_START", "Suppression", 353835)
	self:Log("SPELL_AURA_APPLIED", "RowdyApplied", 353706)
	self:Log("SPELL_CAST_START", "MenacingShout", 350922)
	self:Log("SPELL_CAST_START", "SecuritySlam", 350916, 359028)
	self:Log("SPELL_CAST_START", "CrowdControl", 350919)
	self:Log("SPELL_CAST_START", "SuppressionSpark", 355438)
end

function mod:OnEngage()
	addWave = 0
	self:SetStage(1)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1 has no boss frames to trigger Engage
function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == self.engageId then
		self:Engage()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE()
	self:StopBar(353706) -- Rowdy
	self:StopBar(350922) -- Menacing Shout
	self:StopBar(350916) -- Security Slam

	-- There is one performance phase immediately at the start of the fight and then one after each add wave
	if addWave >= 1 then
		self:Message("stages", "cyan", L.add_wave_killed:format(addWave, 3), false)
		self:PlaySound("stages", "long")
	end
	addWave = addWave + 1
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER()
	-- Unruly patrons rush the stage!
	if addWave <= 2 then
		self:Bar(353706, 41.3) -- Rowdy
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetStage() == 1 and self:GetBossId(176563) then -- Zo'gron
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		self:CDBar(350916, 8.8) -- Security Slam
		self:CDBar(350922, 12.5) -- Menacing Shout
		self:CDBar(350919, 18.5) -- Crowd Control
		self:CDBar(355438, 27.1) -- Suppression Spark
	end
end

function mod:MenacingShout(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 21.8)
end

function mod:SecuritySlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	if args.spellId == 350916 then -- Cast by Oasis Security
		self:CDBar(args.spellId, 14.6)
	else -- Zo'gron
		self:CDBar(args.spellId, 15.8)
	end
end

function mod:CrowdControl(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 21.8)
end

function mod:SuppressionSpark(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 37.7)
end

do
	local prev = 0
	function mod:RottenFood(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(356482, "yellow")
			self:PlaySound(356482, "info")
		end
	end
end

function mod:Teleport(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:Suppression(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:RowdyApplied(args)
		self:StopBar(args.spellId)
		local t = args.time
		if t-prev > 4 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end
