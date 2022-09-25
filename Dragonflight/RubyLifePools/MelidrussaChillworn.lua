if not IsTestBuild() then return end
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
		{372851, "SAY"}, -- Chillstorm
		{372682, "DISPEL"}, -- Primal Chill
		373528, -- Ice Blast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AwakenWhelps", 373046)
	self:Log("SPELL_CAST_START", "Chillstorm", 372851)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PrimalChillApplied", 372682)
	self:Log("SPELL_CAST_START", "IceBlast", 373528)
	-- TODO frost overload (mythic only)
end

function mod:OnEngage()
	self:CDBar(372851, 5.1) -- Chillstorm
	self:CDBar(373046, 15.6) -- Awaken Whelps
	self:CDBar(373528, 23.3) -- Ice Blast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AwakenWhelps(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 13.4)
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

do
	local prev = 0
	function mod:PrimalChillApplied(args)
		local amount = args.amount
		-- TODO build 45632 this ability is presumably bugged and cannot be dispelled by movement-dispelling effects
		if amount >= 3 and amount < 5 and (self:Dispeller("magic", nil, args.spellId) --[[or self:Dispeller("movement", nil, args.spellId)]] or self:Me(args.destGUID)) then
			-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
			local t = args.time
			if t - prev > 1 then
				prev = t
				-- Stuns at 5 stacks
				self:StackMessage(args.spellId, "red", args.destName, amount, 4)
				if amount == 4 then
					self:PlaySound(args.spellId, "warning", nil, args.destName)
				else
					self:PlaySound(args.spellId, "alert", nil, args.destName)
				end
			end
		end
	end
end

function mod:IceBlast(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	-- TODO bar
end
