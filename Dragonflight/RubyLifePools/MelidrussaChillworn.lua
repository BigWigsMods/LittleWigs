--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Melidrussa Chillworn", 2521, 2488)
if not mod then return end
mod:RegisterEnableMob(188252) -- Melidrussa Chillworn
mod:SetEncounterID(2609)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local awakenWhelpsCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373046, -- Awaken Whelps
		{372682, "DISPEL"}, -- Primal Chill
		{372851, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Chillstorm
		396044, -- Hailbombs
		372988, -- Ice Bulwark
		373680, -- Frost Overload
	}, {
		[372988] = CL.mythic,
	}, {
		[372851] = CL.knockback,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AwakenWhelps", 373046)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PrimalChillApplied", 372682)
	self:Log("SPELL_AURA_APPLIED", "Chillstorm", 385518)
	self:Log("SPELL_AURA_REMOVED", "ChillstormRemoved", 385518)
	self:Log("SPELL_CAST_SUCCESS", "Hailbombs", 396044)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "IceBulwarkApplied", 372988)
	self:Log("SPELL_AURA_REMOVED", "IceBulwarkRemoved", 372988)
	self:Log("SPELL_AURA_APPLIED", "FrostOverload", 373680)
	self:Log("SPELL_AURA_REMOVED", "FrostOverloadOver", 373680)
end

function mod:OnEngage()
	awakenWhelpsCount = 0
	self:CDBar(396044, 6.8) -- Hailbombs
	self:CDBar(372851, 12.1) -- Chillstorm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AwakenWhelps(args)
	awakenWhelpsCount = awakenWhelpsCount + 1
	local percent = awakenWhelpsCount == 1 and 75 or 45
	self:Message(args.spellId, "yellow", CL.percent:format(percent, args.spellName))
	self:PlaySound(args.spellId, "long")
	if self:Mythic() then
		self:CDBar(373680, 8.5) -- Frost Overload
		self:StopBar(396044) -- Hailbombs
		self:StopBar(372851) -- Chillstorm
	end
end

do
	local prev = 0
	function mod:PrimalChillApplied(args)
		-- stuns at 8 stacks on mythic, 10 stacks in normal/heroic
		local primalChillMax = self:Mythic() and 8 or 10
		local emphasizeAmount = self:Mythic() and 6 or 8
		local amount = args.amount
		-- start warning at half the required stacks to stun
		local aboveThreshold = amount >= primalChillMax / 2 and amount < primalChillMax
		local shouldWarn = self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) or self:Me(args.destGUID)
		if aboveThreshold and shouldWarn then
			-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:StackMessage(args.spellId, "red", args.destName, amount, emphasizeAmount)
				if amount >= emphasizeAmount then
					self:PlaySound(args.spellId, "warning", nil, args.destName)
				else
					self:PlaySound(args.spellId, "alert", nil, args.destName)
				end
			end
		end
	end
end

function mod:Chillstorm(args)
	self:TargetMessage(372851, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(372851, "alarm", nil, args.destName)
		self:Say(372851, nil, nil, "Chillstorm")
		self:SayCountdown(372851, 3.5, nil, 2)
	else
		self:PlaySound(372851, "alert", nil, args.destName)
	end
	self:CDBar(372851, 23.1)
end

function mod:ChillstormRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(372851)
	end
	self:Bar(372851, 6, CL.knockback)
end

function mod:Hailbombs(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.1)
end

-- Mythic

do
	local iceBulwarkStart = 0

	function mod:IceBulwarkApplied(args)
		iceBulwarkStart = args.time
	end

	function mod:IceBulwarkRemoved(args)
		local iceBulwarkDuration = args.time - iceBulwarkStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, iceBulwarkDuration))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:FrostOverload(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:FrostOverloadOver(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:CDBar(396044, 6) -- Hailbombs
	self:CDBar(372851, 12.1) -- Chillstorm
end
