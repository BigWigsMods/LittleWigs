--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archdruid Glaidalis", 1466, 1654)
if not mod then return end
mod:RegisterEnableMob(96512)
mod:SetEncounterID(1836)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Locals
--

local nextPrimalRampage = 0
local primalRampageCD = 0
local nightfallCount = 1
local nextNightfall = 0
local nextGrievousLeap = 0

--------------------------------------------------------------------------------
-- Initialization
--

local nightmareAbominationMarker = mod:AddMarkerOption(true, "npc", 8, -13302, 8, 7) -- Nightmare Abomination
function mod:GetOptions()
	return {
		"warmup",
		-- Archdruid Glaidalis
		198379, -- Primal Rampage
		212464, -- Nightfall
		196354, -- Grievous Leap
		196376, -- Grievous Tear
		-- Nighmare Abomination
		nightmareAbominationMarker,
		{198477, "SAY", "ME_ONLY"}, -- Fixate
	}, {
		[198379] = self.displayName, -- Archdruid Glaidalis
		[nightmareAbominationMarker] = -13302, -- Nightmare Abomination
	}
end

function mod:OnBossEnable()
	-- Archdruid Glaidalis
	self:Log("SPELL_CAST_START", "PrimalRampage", 198379)
	self:Log("SPELL_CAST_SUCCESS", "Nightfall", 212464, 198401) -- Mythic, Normal/Heroic
	self:Log("SPELL_SUMMON", "NightfallSummon", 198432)
	self:Log("SPELL_AURA_APPLIED", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_DAMAGE", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_MISSED", "NightfallDamage", 198408)
	self:Log("SPELL_CAST_SUCCESS", "GrievousLeap", 196354)
	self:Log("SPELL_AURA_APPLIED", "GrievousTearApplied", 196376)

	-- Nightmare Abomination
	self:Log("SPELL_AURA_APPLIED", "FixateApplied", 198477)
end

function mod:OnEngage()
	local t = GetTime()
	primalRampageCD = 12.4
	nextPrimalRampage = t + primalRampageCD
	nightfallCount = 1
	nextNightfall = t + 25.8
	nextGrievousLeap = t + 4.6
	self:CDBar(196354, 4.6) -- Grievous Leap
	self:CDBar(198379, primalRampageCD) -- Primal Rampage
	self:CDBar(212464, 25.8, CL.count:format(self:SpellName(212464), nightfallCount)) -- Nightfall
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 8.0, CL.active, "achievement_dungeon_darkheartthicket")
end

-- Archdruid Glaidalis

function mod:PrimalRampage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	local t = GetTime()
	primalRampageCD = 27.9
	nextPrimalRampage = t + primalRampageCD
	self:CDBar(args.spellId, primalRampageCD)
	if nextNightfall - t < 5.8 then
		nextNightfall = t + 5.8
		self:CDBar(212464, {5.8, 21.9}, CL.count:format(self:SpellName(212464), nightfallCount)) -- Nightfall
	end
	if nextGrievousLeap - t < 5.8 then
		nextGrievousLeap = t + 5.8
		self:CDBar(196354, {5.8, 12.0}) -- Grievous Leap
	end
end

do
	local prev = 0
	local nightmareAbominationCollector = {}
	local nightmareAbominationMark = 8

	function mod:Nightfall(args)
		-- this is cast twice if not solo, throttle
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:StopBar(CL.count:format(args.spellName, nightfallCount))
			self:Message(212464, "cyan", CL.count:format(args.spellName, nightfallCount))
			self:PlaySound(212464, "info")
			nightfallCount = nightfallCount + 1
			t = GetTime()
			nextNightfall = t + 21.9
			self:CDBar(212464, 21.9, CL.count:format(args.spellName, nightfallCount)) -- pull:26.8, 21.9, 30.4, 31.6
			if nextPrimalRampage - t < 2.43 then
				nextPrimalRampage = t + 2.43
				self:CDBar(198379, {2.43, primalRampageCD}) -- Primal Rampage
			end
			if nextGrievousLeap - t < 2.43 then
				nextGrievousLeap = t + 2.43
				self:CDBar(196354, {2.43, 12.0}) -- Grievous Leap
			end
			if self:Mythic() and self:GetOption(nightmareAbominationMarker) then
				-- register events to auto-mark the adds
				nightmareAbominationCollector = {}
				nightmareAbominationMark = 8
				self:RegisterTargetEvents("MarkNightmareAbomination")
			end
		end
	end

	function mod:NightfallSummon(args)
		if self:GetOption(nightmareAbominationMarker) then
			if not nightmareAbominationCollector[args.destGUID] then
				nightmareAbominationCollector[args.destGUID] = nightmareAbominationMark
				nightmareAbominationMark = nightmareAbominationMark - 1
			end
		end
	end

	function mod:MarkNightmareAbomination(_, unit, guid)
		if nightmareAbominationCollector[guid] then
			self:CustomIcon(nightmareAbominationMarker, unit, nightmareAbominationCollector[guid])
			nightmareAbominationCollector[guid] = nil
			if not next(nightmareAbominationCollector) then
				self:UnregisterTargetEvents()
			end
		end
	end
end

do
	local prev = 0
	function mod:NightfallDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(212464, "underyou")
				self:PlaySound(212464, "underyou", nil, args.destName)
			end
		end
	end
end

function mod:GrievousLeap(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	local t = GetTime()
	nextGrievousLeap = t + 12.0
	self:CDBar(args.spellId, 12.0)
	if nextPrimalRampage - t < 5.38 then
		nextPrimalRampage = t + 5.38
		self:CDBar(198379, {5.38, primalRampageCD}) -- Primal Rampage
	end
	if nextNightfall - t < 5.38 then
		nextNightfall = t + 5.38
		self:CDBar(212464, {5.38, 21.9}, CL.count:format(self:SpellName(212464), nightfallCount)) -- Nightfall
	end
end

function mod:GrievousTearApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Nightmare Abomination

do
	local prev = 0
	function mod:FixateApplied(args)
		local t = args.time
		if t - prev > 1.5 and self:MobId(args.sourceGUID) == 102962 then -- Nightmare Abomination (boss version)
			prev = t
			self:TargetMessage(args.spellId, "red", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
			if self:Me(args.destGUID) then
				self:Say(args.spellId, nil, nil, "Fixate")
			end
		end
	end
end
