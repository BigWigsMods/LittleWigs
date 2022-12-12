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
		373680, -- Frost Overload
		{372851, "SAY", "SAY_COUNTDOWN"}, -- Chillstorm
		396044, -- Hailbombs
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AwakenWhelps", 373046)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PrimalChillApplied", 372682)
	self:Log("SPELL_AURA_APPLIED", "FrostOverload", 373680)
	self:Log("SPELL_AURA_REMOVED", "FrostOverloadOver", 373680)
	self:Log("SPELL_AURA_APPLIED", "Chillstorm", 385518)
	self:Log("SPELL_CAST_SUCCESS", "Hailbombs", 396044)
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

do
	local frostOverloadStart = 0

	function mod:FrostOverload(args)
		frostOverloadStart = args.time
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "long")
	end

	function mod:FrostOverloadOver(args)
		local frostOverloadDuration = args.time - frostOverloadStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, frostOverloadDuration))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:Chillstorm(args)
	self:TargetMessage(372851, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(372851, "alarm")
		self:Say(372851)
		self:SayCountdown(372851, 3.5)
	else
		self:PlaySound(372851, "alert", nil, args.destName)
	end
	self:CDBar(372851, 22.6)
end

function mod:Hailbombs(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23)
end
