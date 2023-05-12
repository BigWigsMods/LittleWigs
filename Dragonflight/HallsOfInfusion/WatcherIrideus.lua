--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Watcher Irideus", 2527, 2504)
if not mod then return end
mod:RegisterEnableMob(189719) -- Watcher Irideus
mod:SetEncounterID(2615)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.stacks_left = "%s (%d/%d)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Stage 1
		{389179, "SAY", "SAY_COUNTDOWN"}, -- Power Overload
		384351, -- Spark Volley
		384014, -- Static Surge
		384524, -- Titanic Fist
		-- Stage 2
		383840, -- Ablative Barrier
		389446, -- Nullifying Pulse
	}, {
		[389179] = -25745, -- Stage One: A Chance at Redemption
		[389446] = -25744, -- Stage Two: Watcher's Last Stand
	}
end

function mod:OnBossEnable()
	-- Stage 1
	self:Log("SPELL_CAST_SUCCESS", "PowerOverload", 389179)
	self:Log("SPELL_AURA_APPLIED", "PowerOverloadApplied", 389179)
	self:Log("SPELL_AURA_REMOVED", "PowerOverloadRemoved", 389179)
	self:Log("SPELL_CAST_START", "SparkVolley", 384351)
	self:Log("SPELL_CAST_START", "StaticSurge", 384014)
	self:Log("SPELL_CAST_START", "TitanicFist", 384524)

	-- Stage 2
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "AblativeBarrierApplied", 383840)
	self:Log("SPELL_AURA_REMOVED_DOSE", "AblativeBarrierRemovedDose", 383840)
	self:Log("SPELL_AURA_REMOVED", "AblativeBarrierRemoved", 383840)
	self:Log("SPELL_CAST_START", "NullifyingPulse", 389446)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(384524, 6.1) -- Titanic Fist
	self:CDBar(384014, 10.6) -- Static Surge
	self:CDBar(389179, 25.5) -- Power Overload
	self:CDBar(384351, 29.2) -- Spark Volley
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1

do
	local playerList = {}

	function mod:PowerOverload(args)
		playerList = {}
		self:Bar(args.spellId, 27.7)
	end

	function mod:PowerOverloadApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 3)
		self:PlaySound(args.spellId, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
			self:SayCountdown(args.spellId, 6)
		end
	end

	function mod:PowerOverloadRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:SparkVolley(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 31.5)
end

function mod:StaticSurge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 27.9)
end

function mod:TitanicFist(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.0)
end

-- Stage 2

function mod:UNIT_HEALTH(event, unit)
	-- stage 2 trigger is the boss hitting 15%, but it takes some time for the boss to get in position
	if self:GetHealth(unit) <= 15 then
		self:UnregisterUnitEvent(event, unit)
		self:Message(383840, "cyan", CL.soon:format(self:SpellName(383840))) -- Ablative Barrier Soon
		self:PlaySound(383840, "info")
		self:StopBar(384524) -- Titanic Fist
		self:StopBar(384014) -- Static Surge
		self:StopBar(389179) -- Power Overload
		self:StopBar(384351) -- Spark Volley
	end
end

do
	local ablativeBarrierStart = 0

	function mod:AblativeBarrierApplied(args)
		ablativeBarrierStart = args.time
		self:SetStage(2)
		self:Message(args.spellId, "yellow", CL.percent:format(15, args.spellName))
		self:PlaySound(args.spellId, "long")
		self:StopBar(384524) -- Titanic Fist
		self:StopBar(384014) -- Static Surge
		self:StopBar(389179) -- Power Overload
		self:StopBar(384351) -- Spark Volley
	end

	function mod:AblativeBarrierRemovedDose(args)
		self:Message(args.spellId, "yellow", L.stacks_left:format(args.spellName, args.amount, 3))
		-- no sound, gets spammy combined with AblativeBarrierRemoved
	end

	function mod:AblativeBarrierRemoved(args)
		local ablativeBarrierDuration = args.time - ablativeBarrierStart
		self:SetStage(1)
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, ablativeBarrierDuration))
		self:PlaySound(args.spellId, "info")
		self:CDBar(384524, 6.1) -- Titanic Fist
		self:CDBar(384014, 11.0) -- Static Surge
		self:CDBar(389179, 28.1) -- Power Overload
		self:CDBar(384351, 28.9) -- Spark Volley
	end
end

do
	local prev = 0
	function mod:NullifyingPulse(args)
		self:Message(args.spellId, "red")
		local t = args.time
		if t - prev > 1 then
			prev = t
			-- throttle sound to avoid spam
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
