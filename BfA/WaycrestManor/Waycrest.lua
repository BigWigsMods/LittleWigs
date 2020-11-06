
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord and Lady Waycrest", 1862, 2128)
if not mod then return end
mod:RegisterEnableMob(131545, 131527) -- Lady Waycrest, Lord Waycrest
mod.engageId = 2116
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Initialization
--

local stage = 1
local vitalityTransferCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		--[[ Lady Waycrest ]]--
		268306, -- Discordant Cadenza
		268278, -- Wracking Chord
		--[[ Lord Waycrest ]]--
		{261438, "TANK_HEALER"}, -- Wasting Strike
		{261440, "SAY", "SAY_COUNTDOWN", "PROXIMITY"}, -- Virulent Pathogen
		261447, -- Putrid Vitality
	}, {
		[268306] = -17773, -- Lady Waycrest
		[261438] = -17777, -- Lord Waycrest
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "VitalityTransfer", 261446)
	self:Log("SPELL_CAST_SUCCESS", "DiscordantCadenza", 268306)
	self:Log("SPELL_CAST_START", "WrackingChord", 268278)
	self:Log("SPELL_CAST_SUCCESS", "WastingStrike", 261438)
	self:Log("SPELL_CAST_SUCCESS", "VirulentPathogen", 261440)
	self:Log("SPELL_AURA_APPLIED", "VirulentPathogenApplied", 261440)
	self:Log("SPELL_AURA_REMOVED", "VirulentPathogenRemoved", 261440)
	self:Log("SPELL_AURA_APPLIED", "PutridVitality", 261447)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PutridVitality", 261447)
end

function mod:OnEngage()
	stage = 1
	vitalityTransferCount = 0
	self:Bar(261438, 6.5) -- Wasting Strike
	self:Bar(261440, 11.5) -- Virulent Pathogen
	self:Bar(268306, 18) -- Discordant Cadenza
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function warnLadyWacrest()
		mod:Message("stages", "cyan", mod:SpellName(-17773), false)
		mod:PlaySound("stages", "long")
	end

	function mod:VitalityTransfer(args)
		vitalityTransferCount = vitalityTransferCount + 1
		if vitalityTransferCount == 3 then
			stage = 2
			self:Message("stages", "cyan", CL.soon:format(self:SpellName(-17773)), false) -- Lady Waycrest
			self:PlaySound("stages", "info")
			self:Bar("stages", 7.5, CL.incoming:format(self:SpellName(-17773)), "achievement_character_undead_female")
			self:SimpleTimer(warnLadyWacrest, 7.5)
		end
	end
end

function mod:DiscordantCadenza(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 18.1)
end

function mod:WrackingChord(args)
	if stage == 2 then
		if self:Interrupter() then
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
		self:CDBar(args.spellId, 8)
	end
end

function mod:WastingStrike(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 15.5)
end

do
	local playerList, isOnMe, proxList = mod:NewTargetList(), false, {}
	function mod:VirulentPathogen(args)
		self:Bar(args.spellId, 15.5)
	end

	function mod:VirulentPathogenApplied(args)
		if self:Me(args.destGUID) then
			isOnMe = true
			self:Say(args.spellId)
			self:SayCountdown(args.spellId, 5)
		end

		playerList[#playerList+1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 5)
		self:PlaySound(args.spellId, "warning", nil, playerList)

		proxList[#proxList+1] = args.destName
		self:OpenProximity(args.spellId, 5, not isOnMe and proxList)
	end

	function mod:VirulentPathogenRemoved(args)
		if self:Me(args.destGUID) then
			isOnMe = false
			self:CancelSayCountdown(args.spellId)
		end
		tDeleteItem(proxList, args.destName)
		if #proxList == 0 then
			self:CloseProximity(args.spellId)
		else
			self:OpenProximity(args.spellId, 5, not isOnMe and proxList)
		end
	end
end

function mod:PutridVitality(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "cyan")
	self:PlaySound(args.spellId, "info")
end
