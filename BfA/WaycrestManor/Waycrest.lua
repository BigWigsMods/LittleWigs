
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord and Lady Waycrest", 1862, 2128)
if not mod then return end
mod:RegisterEnableMob(131545, 131527) -- Lady Waycrest, Lord Waycrest
mod.engageId = 2116

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Lady Waycrest ]]--
		268306, -- Discordant Cadenza
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
	self:Log("SPELL_CAST_START", "DiscordantCadenza", 268306)
	self:Log("SPELL_CAST_SUCCESS", "WastingStrike", 261438)
	self:Log("SPELL_CAST_SUCCESS", "VirulentPathogen", 261440)
	self:Log("SPELL_AURA_APPLIED", "VirulentPathogenApplied", 261440)
	self:Log("SPELL_AURA_REMOVED", "VirulentPathogenRemoved", 261440)
	self:Log("SPELL_AURA_APPLIED", "PutridVitality", 261447)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PutridVitality", 261447)
end

function mod:OnEngage()
	self:Bar(261438, 6.5) -- Wasting Strike
	self:Bar(261440, 11.5) -- Virulent Pathogen
	self:Bar(268306, 18) -- Discordant Cadenza
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DiscordantCadenza(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 18.1)
end

function mod:WastingStrike(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 15.5)
end

do
	local playerList, isOnMe = {}, false
	function mod:VirulentPathogen(args)
		self:TargetMessage2(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
		self:Bar(args.spellId, 15.5)
	end

	function mod:VirulentPathogenApplied(args)
		if self:Me(args.destGUID) then
			isOnMe = true
			self:Say(args.spellId)
			self:SayCountdown(args.spellId, 5)
		end
		playerList[#playerList+1] = args.destName
		self:OpenProximity(args.spellId, 5, not isOnMe and playerList)
	end

	function mod:VirulentPathogenRemoved(args)
		if self:Me(args.destGUID) then
			isOnMe = false
			self:CancelSayCountdown(args.spellId)
		end
		tDeleteItem(playerList, args.destName)
		if #playerList == 0 then
			self:CloseProximity(args.spellId)
		else
			self:OpenProximity(args.spellId, 5, not isOnMe and playerList)
		end
	end
end

function mod:PutridVitality(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "cyan")
	self:PlaySound(args.spellId, "info")
end
