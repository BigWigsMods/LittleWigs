local isTenDotTwo = select(4, GetBuildInfo()) >= 100200 --- XXX delete when 10.2 is live everywhere
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

local nextNightfall = 0

--------------------------------------------------------------------------------
-- Initialization
--

local nightmareAbominationMarker = mod:AddMarkerOption(true, "npc", 8, -13302, 8) -- Nightmare Abomination
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
	self:Log("SPELL_AURA_APPLIED", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_DAMAGE", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_MISSED", "NightfallDamage", 198408)
	if isTenDotTwo then
		self:Log("SPELL_CAST_SUCCESS", "GrievousLeap", 196354)
	else
		-- XXX delete when 10.2 is live everywhere
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Grievous Leap
	end
	self:Log("SPELL_AURA_APPLIED", "GrievousTearApplied", 196376)

	-- Nightmare Abomination
	self:Log("SPELL_SUMMON", "NightfallSummon", 198432)
	self:Log("SPELL_AURA_APPLIED", "FixateApplied", 198477)
end

function mod:OnEngage()
	nextNightfall = GetTime() + 21.9
	self:CDBar(196354, 4.6) -- Grievous Leap
	self:CDBar(198379, 12.4) -- Primal Rampage
	self:CDBar(212464, 25.8) -- Nightfall
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
	self:CDBar(args.spellId, 29.2) -- pull:12.7, 30.3 / m pull:12.6, 31.6, 29.9, 27.9
	if nextNightfall - GetTime() < 5.8 then
		self:CDBar(212464, {5.8, 21.9}) -- Nightfall
	end
end

function mod:Nightfall(args)
	nextNightfall = GetTime() + 21.9
	self:Message(212464, "cyan")
	self:PlaySound(212464, "info")
	self:CDBar(212464, 21.9) -- pull:26.8, 21.9, 30.4, 31.6
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

-- XXX pre-10.2 Grievous Leap compat
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 196354 then -- Grievous Leap
		self:GrievousLeap({
			spellId = spellId,
		})
	end
end

function mod:GrievousLeap(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12.1)
end

function mod:GrievousTearApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Nightmare Abomination

do
	local nightmareAbominationGUID = nil

	function mod:NightfallSummon(args)
		-- register events to auto-mark the add
		if self:GetOption(nightmareAbominationMarker) then
			nightmareAbominationGUID = args.destGUID
			self:RegisterTargetEvents("MarkNightmareAbomination")
		end
	end

	function mod:MarkNightmareAbomination(_, unit, guid)
		if nightmareAbominationGUID == guid then
			nightmareAbominationGUID = nil
			self:CustomIcon(nightmareAbominationMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

do
	local prev = 0
	function mod:FixateApplied(args)
		local t = args.time
		if t - prev > 1.5 and self:MobId(args.sourceGUID) == 102962 then -- Nightmare Abomination (boss version)
			prev = t
			self:TargetMessage(args.spellId, "red", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
			if self:Me(args.destGUID) then
				self:Say(args.spellId)
			end
		end
	end
end
