--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archdruid Glaidalis", 1466, 1654)
if not mod then return end
mod:RegisterEnableMob(96512)
mod:SetEncounterID(1836)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Initialization
--

local nightmareAbominationMarker = mod:AddMarkerOption(true, "npc", 8, -13302, 8) -- Nightmare Abomination
function mod:GetOptions()
	return {
		"warmup",
		198379, -- Primal Rampage
		212464, -- Nightfall
		nightmareAbominationMarker,
		{198477, "SAY", "ME_ONLY"}, -- Fixate
		196346, -- Grievous Leap
		196376, -- Grievous Tear
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PrimalRampage", 198379)
	self:Log("SPELL_CAST_SUCCESS", "Nightfall", 212464)
	self:Log("SPELL_SUMMON", "NightfallSummon", 198432)
	self:Log("SPELL_AURA_APPLIED", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_DAMAGE", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_MISSED", "NightfallDamage", 198408)
	self:Log("SPELL_AURA_APPLIED", "FixateApplied", 198477)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Grievous Leap
	self:Log("SPELL_AURA_APPLIED", "GrievousTearApplied", 196376)
end

function mod:OnEngage()
	self:CDBar(196346, 4.6) -- Grievous Leap
	self:CDBar(198379, 12.4) -- Primal Rampage
	self:CDBar(212464, 26.8) -- Nightfall
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 8.0, CL.active, "achievement_dungeon_darkheartthicket")
end

function mod:PrimalRampage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 29.2) -- pull:12.7, 30.3 / m pull:12.6, 31.6, 29.9, 27.9
end

function mod:Nightfall(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 21.9) -- pull:26.8, 21.9, 30.4, 31.6
end

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

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 196346 then -- Grievous Leap
		self:Message(spellId, "yellow")
		self:PlaySound(spellId, "alarm")
		self:CDBar(spellId, 12.1)
	end
end

function mod:GrievousTearApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:FixateApplied(args)
	if self:MobId(args.sourceGUID) == 102962 then -- Nightmare Abomination (boss version)
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
		end
	end
end
