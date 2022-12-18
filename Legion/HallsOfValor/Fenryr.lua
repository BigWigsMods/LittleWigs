--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fenryr", 1477, 1487)
if not mod then return end
mod:RegisterEnableMob(95674, 99868) -- Phase 1 Fenryr, Phase 2 Fenryr
mod:SetEncounterID(1807)

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
	self:Log("SPELL_CAST_START", "RavenousLeap", 197558)
	self:Log("SPELL_AURA_APPLIED", "RavenousLeapApplied", 197556)
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
	self:Message("stages", "cyan", CL.stage:format(2), false)
	-- Prevent the module wiping when moving to phase 2 and ENCOUNTER_END fires.
	self:ScheduleTimer("Reboot", 0.5) -- Delay a little
end

function mod:UnnervingHowl(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 28)
end

do
	local playerList = {}

	function mod:RavenousLeap(args)
		playerList = {}
		self:CDBar(197556, 31.7)
	end

	function mod:RavenousLeapApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "yellow", playerList, 4)
		self:PlaySound(args.spellId, "alert", nil, playerList)
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
	self:Message(args.spellId, "red")
end

do
	local function printTarget(self, name, guid)
		self:PrimaryIcon(196838, name)
		self:TargetMessage(196838, "orange", name)
		if self:Me(guid) then
			self:Say(196838)
			self:PlaySound(196838, "warning")
		end
	end
	function mod:ScentOfBlood(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 34)
	end
	function mod:ScentOfBloodRemoved(args)
		self:PrimaryIcon(args.spellId)
	end
end
