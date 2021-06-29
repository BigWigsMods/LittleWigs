
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
		-- Zo'gron
		350922, -- Menacing Shout
		350919, -- Crowd Control
		355438, -- Suppression Spark
		{350916, "TANK"}, -- Security Slam
		-- Unruly Patron
		356482, -- Rotten Food
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_START", "MenacingShout", 350922)
	self:Log("SPELL_CAST_START", "SecuritySlam", 350916)
	self:Log("SPELL_CAST_START", "CrowdControl", 350919)
	self:Log("SPELL_CAST_START", "SuppressionSpark", 355438)
	self:Log("SPELL_CAST_START", "RottenFood", 356482)
end

function mod:OnEngage()
	addWave = 0
	self:SetStage(1)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE()
	-- There is one performance phase immediately at the start of the fight and then one after each add wave
	if addWave >= 1 then
		self:Message("stages", "cyan", L.add_wave_killed:format(addWave, 3), false)
		self:PlaySound("stages", "long")
	end
	addWave = addWave + 1
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetStage() == 1 and self:GetBossId(176563) then -- Zo'gron
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		self:Bar(350916, 8.8) -- Security Slam
		self:Bar(350922, 12.5) -- Menacing Shout
		self:Bar(350919, 18.5) -- Crowd Control
		self:Bar(355438, 27.1) -- Suppression Spark
	end
end

function mod:MenacingShout(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SecuritySlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:CrowdControl(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 21.8)
end

function mod:SuppressionSpark(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.4)
end

do
	local prev = 0
	function mod:RottenFood(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end
