--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord and Lady Waycrest", 1862, 2128)
if not mod then return end
mod:RegisterEnableMob(
	131545, -- Lady Waycrest
	131527  -- Lord Waycrest
)
mod:SetEncounterID(2116)
mod:SetRespawnTime(20)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

local vitalityTransferCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Lady Waycrest
		268306, -- Discordant Cadenza
		268278, -- Wracking Chord
		-- Lord Waycrest
		{261438, "TANK_HEALER"}, -- Wasting Strike
		{261440, "SAY", "SAY_COUNTDOWN"}, -- Virulent Pathogen
		261447, -- Putrid Vitality
	}, {
		[268306] = -17773, -- Lady Waycrest
		[261438] = -17777, -- Lord Waycrest
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_SUCCESS", "VitalityTransfer", 261446)

	-- Lady Waycrest
	self:Log("SPELL_CAST_SUCCESS", "DiscordantCadenza", 268306)
	self:Log("SPELL_CAST_START", "WrackingChord", 268278)
	self:Death("LadyWaycrestDeath", 131545)

	-- Lord Waycrest
	self:Log("SPELL_CAST_START", "WastingStrike", 261438)
	self:Log("SPELL_CAST_SUCCESS", "VirulentPathogen", 261440)
	self:Log("SPELL_AURA_APPLIED", "VirulentPathogenApplied", 261440)
	self:Log("SPELL_AURA_REMOVED", "VirulentPathogenRemoved", 261440)
	self:Log("SPELL_AURA_APPLIED", "PutridVitality", 261447)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PutridVitality", 261447)
	self:Death("LordWaycrestDeath", 131527)
end

function mod:OnEngage()
	vitalityTransferCount = 0
	self:SetStage(1)
	self:CDBar(261438, 6.1) -- Wasting Strike
	self:CDBar(261440, 12.5) -- Virulent Pathogen
	self:CDBar(268306, 17.9) -- Discordant Cadenza
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

do
	local function warnLadyWacrest(self)
		self:Message("stages", "cyan", CL.other:format(self:SpellName(-17773), CL.teleport), "achievement_character_undead_female") -- Lady Waycrest: Teleport
		self:PlaySound("stages", "long")
	end

	function mod:VitalityTransfer(args)
		vitalityTransferCount = vitalityTransferCount + 1
		if vitalityTransferCount == 3 then
			self:SetStage(2)
			self:Message("stages", "cyan", CL.incoming:format(args.sourceName), "achievement_character_undead_female")
			self:PlaySound("stages", "info")
			self:Bar("stages", 7.5, CL.other:format(args.sourceName, CL.teleport), "achievement_character_undead_female")
			self:ScheduleTimer(warnLadyWacrest, 7.5, self, CL.other:format(args.sourceName, CL.teleport))
			self:StopBar(268306) -- Discordant Cadenza
		end
	end
end

-- Lady Waycrest

function mod:DiscordantCadenza(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 24.3)
end

function mod:WrackingChord(args)
	if self:GetStage() == 2 then
		if self:Interrupter() then
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:CDBar(args.spellId, 8.5)
	end
end

function mod:LadyWaycrestDeath()
	self:StopBar(268278) -- Wracking Chord
end

-- Lord Waycrest

function mod:WastingStrike(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17.0)
end

do
	local playerList = {}

	function mod:VirulentPathogen(args)
		self:CDBar(args.spellId, 15.8)
	end

	function mod:VirulentPathogenApplied(args)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Virulent Pathogen")
			self:SayCountdown(args.spellId, 5)
		end
		playerList[#playerList + 1] = args.destName
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		self:TargetsMessage(args.spellId, "red", playerList, 5)
	end

	function mod:VirulentPathogenRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:PutridVitality(args)
	self:Message(args.spellId, "cyan", CL.count_amount:format(args.spellName, args.amount or 1, 3))
	self:PlaySound(args.spellId, "info")
end

function mod:LordWaycrestDeath()
	self:StopBar(261438) -- Wasting Strike
	self:StopBar(261440) -- Virulent Pathogen
end
