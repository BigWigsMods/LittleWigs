
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fenryr", 1477, 1487)
if not mod then return end
mod:RegisterEnableMob(95674, 99868) -- Phase 1 Fenryr, Phase 2 Fenryr
mod.engageId = 1807

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		196543, -- Unnerving Howl
		{197556, "SAY", "PROXIMITY"}, -- Ravenous Leap
		196512, -- Claw Frenzy
		{196838, "SAY", "ICON"}, -- Scent of Blood
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Stealth", 196567)
	self:Log("SPELL_CAST_START", "UnnervingHowl", 196543)
	self:Log("SPELL_AURA_APPLIED", "RavenousLeap", 197556)
	self:Log("SPELL_AURA_REMOVED", "RavenousLeapRemoved", 197556)
	self:Log("SPELL_CAST_SUCCESS", "ClawFrenzy", 196512)
	self:Log("SPELL_CAST_START", "ScentOfBlood", 196838)
	self:Log("SPELL_AURA_REMOVED", "ScentOfBloodRemoved", 196838)
end

function mod:OnEngage()
	--self:CDBar(196543, 4.5) -- Unnerving Howl
	--self:CDBar(197556, 9.5) -- Ravenous Leap
	--self:CDBar(196838, 20) -- Scent of Blood
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Stealth()
	self:MessageOld("stages", "cyan", nil, CL.stage:format(2), false)
	-- Prevent the module wiping when moving to phase 2 and ENCOUNTER_END fires.
	self:ScheduleTimer("Reboot", 0.5) -- Delay a little
end

function mod:UnnervingHowl(args)
	self:MessageOld(args.spellId, "orange", "alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 30)
end

do
	local list = mod:NewTargetList()
	function mod:RavenousLeap(args)
		--"pull:10.1, 36.0" p2
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, list, "yellow", "info", nil, nil, true)
			self:CDBar(args.spellId, 31)
		end
		if self:Me(args.destGUID) then
			self:OpenProximity(args.spellId, 10)
			self:Say(args.spellId)
		end
	end

	function mod:RavenousLeapRemoved(args)
		if self:Me(args.destGUID) then
			self:CloseProximity(args.spellId)
		end
	end
end

function mod:ClawFrenzy(args)
	self:MessageOld(args.spellId, "red")
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(196838)
		end
		self:PrimaryIcon(196838, player)
		self:TargetMessageOld(196838, player, "orange", "warning")
	end
	function mod:ScentOfBlood(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 34)
	end
	function mod:ScentOfBloodRemoved(args)
		self:PrimaryIcon(args.spellId)
	end
end
