--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zo'phex the Sentinel", 2441, 2437)
if not mod then return end
mod:RegisterEnableMob(175616) -- Zo'phex the Sentinel
mod:SetEncounterID(2425)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local interrogateCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local containmentCellMarker = mod:AddMarkerOption(true, "npc", 8, 345764, 8) -- Containment Cell
function mod:GetOptions()
	return {
		"warmup",
		348350, -- Interrogation
		345990, -- Containment Cell
		containmentCellMarker,
		345770, -- Impound Contraband
		346204, -- Armed Security
		{348128, "TANK"}, -- Fully Armed
		1236348, -- Charged Slash
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Interrogation", 348350)
	self:Log("SPELL_AURA_APPLIED", "InterrogationApplied", 347949)
	self:Log("SPELL_AURA_REMOVED", "InterrogationRemovedBoss", 345989)
	self:Log("SPELL_SUMMON", "ContainmentCellSummon", 345764)
	self:Log("SPELL_AURA_APPLIED", "ContainmentCellApplied", 345990)
	self:Log("SPELL_AURA_REMOVED", "ContainmentCellRemoved", 345990)
	self:Log("SPELL_MISSED", "ContainmentCellMissed", 345990)
	self:Log("SPELL_CAST_SUCCESS", "ArmedSecurity", 346204)
	self:Log("SPELL_PERIODIC_DAMAGE", "ArmedSecurityDamage", 348366)
	self:Log("SPELL_PERIODIC_MISSED", "ArmedSecurityDamage", 348366)
	self:Log("SPELL_CAST_START", "FullyArmed", 348128)
	self:Log("SPELL_CAST_SUCCESS", "ImpoundContraband", 346006)
	self:Log("SPELL_AURA_APPLIED", "ImpoundContrabandApplied", 345770)
	self:Log("SPELL_AURA_REMOVED", "ImpoundContrabandRemoved", 345770)
	self:Log("SPELL_CAST_START", "ChargedSlash", 1236348)
end

function mod:OnEngage()
	interrogateCount = 1
	self:StopBar(CL.active)
	self:CDBar(346204, 8.7) -- Armed Security
	self:CDBar(1236348, 12.1) -- Charged Slash
	self:CDBar(345770, 20.4) -- Impound Contraband
	self:CDBar(348128, 29.0) -- Fully Armed
	-- 2s delay + 35s energy gain + delay
	self:CDBar(348350, 39.9) -- Interrogation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	if not self:IsEngaged() then -- prevent this bar in Hard Mode
		self:Bar("warmup", 9.2, CL.active, "achievement_dungeon_brokerdungeon")
	end
end

function mod:Interrogation(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	interrogateCount = interrogateCount + 1
	-- energy is reset to 0 after this 1.5s cast, with a 35s or 30s energy gain afterwards
	if interrogateCount == 2 then
		self:CDBar(args.spellId, 36.5)
	else -- 3+
		self:CDBar(args.spellId, 31.5)
	end
end

function mod:InterrogationApplied(args)
	self:TargetMessage(348350, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(348350, "warning")
	else
		self:PlaySound(348350, "alert", nil, args.destName)
	end
end

function mod:InterrogationRemovedBoss(args)
	-- when the Interrogation channel ends the boss's energy gain resumes, with a 30s energy gain + delay
	self:CDBar(348350, 32.6) -- Interrogation
end

do
	local containmentCellGUID = nil

	function mod:ContainmentCellSummon(args)
		-- register events to auto-mark the Containment Cell
		if self:GetOption(containmentCellMarker) then
			containmentCellGUID = args.destGUID
			self:RegisterTargetEvents("MarkContainmentCell")
		end
	end

	function mod:MarkContainmentCell(_, unit, guid)
		if containmentCellGUID == guid then
			containmentCellGUID = nil
			self:CustomIcon(containmentCellMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:ContainmentCellApplied(args)
	self:StopBar(346204) -- Armed Security
	self:StopBar(1236348) -- Charged Slash
	self:StopBar(345770) -- Impound Contraband
	self:StopBar(348128) -- Fully Armed
	-- if Containment Cell is applied, the boss's energy resets and the gain is paused
	self:StopBar(348350) -- Interrogation
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alert")
	else
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

function mod:ContainmentCellRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	else
		self:Message(args.spellId, "green", CL.removed_from:format(args.spellName, self:ColorName(args.destName)))
	end
	self:CDBar(346204, 8.6) -- Armed Security
	self:CDBar(1236348, 12.0) -- Charged Slash
	self:CDBar(345770, 20.4) -- Impound Contraband
	self:CDBar(348128, 29.0) -- Fully Armed
	self:PlaySound(args.spellId, "info")
end

function mod:ContainmentCellMissed(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.extra:format(CL.removed:format(args.spellName), CL.immune))
	else
		self:Message(args.spellId, "green", CL.extra:format(CL.removed_from:format(args.spellName, self:ColorName(args.destName)), CL.immune))
	end
	self:PlaySound(args.spellId, "info")
end

function mod:ArmedSecurity(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 33.9)
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:ArmedSecurityDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(346204, "underyou")
			self:PlaySound(346204, "underyou")
		end
	end
end

function mod:FullyArmed(args)
	self:Message(args.spellId, "purple")
	self:StopBar(args.spellId)
	self:PlaySound(args.spellId, "alert")
end

function mod:ImpoundContraband(args)
	self:CDBar(345770, 26.7) -- Impound Contraband
end

function mod:ImpoundContrabandApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:ImpoundContrabandRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:ChargedSlash(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 16.9)
	self:PlaySound(args.spellId, "alarm")
end
