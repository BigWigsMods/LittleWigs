
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

--------------------------------------------------------------------------------
-- Locals
--

local killedAddCount = 0

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
		-- Oasis Security
		{350916, "TANK"}, -- Security Slam
		-- Unruly Patron
		356482, -- Rotten Food
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MenacingShout", 350922)
	self:Log("SPELL_CAST_START", "SecuritySlam", 350916)
	self:Log("SPELL_CAST_START", "CrowdControl", 350919)
	self:Log("SPELL_CAST_START", "SuppressionSpark", 355438)
	self:Log("SPELL_CAST_START", "RottenFood", 356482)
	self:Death("AddDeath", 176562, 176565, 179269) -- Brawling Patron, Disruptive Patron, Oasis Security
end

function mod:OnEngage()
	killedAddCount = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

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
end

function mod:SuppressionSpark(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
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

function mod:AddDeath(args)
	killedAddCount = killedAddCount + 1
	if killedAddCount % 4 == 0 then
		self:Message("stages", "cyan", L.add_wave_killed:format(killedAddCount/4, 3), false)
		self:PlaySound("stages", "long")
	end
end
