--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Melidrussa Chillworn", 2521, 2488)
if not mod then return end
mod:RegisterEnableMob(188252) -- Melidrussa Chillworn
mod:SetEncounterID(2609)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373046, -- Awaken Whelps
		{372682, "DISPEL"}, -- Primal Chill
		373680, -- Frost Overload
		{372851, "SAY"}, -- Chillstorm
		396044, -- Hailbombs
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AwakenWhelps", 373046)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PrimalChillApplied", 372682)
	self:Log("SPELL_AURA_APPLIED", "FrostOverload", 373680)
	self:Log("SPELL_AURA_REMOVED", "FrostOverloadOver", 373680)
	self:Log("SPELL_CAST_START", "Chillstorm", 372851)
	self:Log("SPELL_CAST_SUCCESS", "Hailbombs", 396044)
end

function mod:OnEngage()
	self:CDBar(396044, 6.8) -- Hailbombs
	self:CDBar(372851, 12.1) -- Chillstorm
	self:CDBar(373046, 15.6) -- Awaken Whelps
	if self:Mythic() then
		self:CDBar(373680, 31.6) -- Frost Overload
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AwakenWhelps(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 13.4)
end

do
	local prev = 0
	function mod:PrimalChillApplied(args)
		local amount = args.amount
		if amount >= 5 and amount < 10 and (self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) or self:Me(args.destGUID)) then
			-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
			local t = args.time
			if t - prev > 1 then
				prev = t
				-- Stuns at 10 stacks
				self:StackMessage(args.spellId, "red", args.destName, amount, 8)
				if amount >= 8 then
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
		self:CDBar(args.spellId, 18.4)
	end

	function mod:FrostOverloadOver(args)
		local frostOverloadDuration = args.time - frostOverloadStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, frostOverloadDuration))
		self:PlaySound(args.spellId, "info")
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(372851, "yellow", name)
		self:PlaySound(372851, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(372851)
		end
	end

	function mod:Chillstorm(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CastBar(args.spellId, 3.5)
		self:CDBar(args.spellId, 32.8)
	end
end

function mod:Hailbombs(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 57.3)
end
