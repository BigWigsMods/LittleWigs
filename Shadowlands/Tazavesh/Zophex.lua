local isElevenDotTwo = BigWigsLoader.isNext -- XXX remove in 11.2
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zo'phex the Sentinel", 2441, 2437)
if not mod then return end
mod:RegisterEnableMob(175616) -- Zo'phex the Sentinel
mod:SetEncounterID(2425)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

local containmentCellMarker = mod:AddMarkerOption(true, "npc", 8, 345764, 8) -- Containment Cell
if isElevenDotTwo then -- XXX remove check in 11.2
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
else -- XXX remove block in 11.2
	function mod:GetOptions()
		return {
			"warmup",
			348350, -- Interrogation
			345990, -- Containment Cell
			345770, -- Impound Contraband
			346204, -- Armed Security
		}
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Interrogation", 348350)
	self:Log("SPELL_AURA_APPLIED", "InterrogationApplied", 347949)
	self:Log("SPELL_AURA_REMOVED", "InterrogationRemovedBoss", 345989)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_SUMMON", "ContainmentCellSummon", 345764)
	end
	self:Log("SPELL_AURA_APPLIED", "ContainmentCellApplied", 345990)
	self:Log("SPELL_AURA_REMOVED", "ContainmentCellRemoved", 345990)
	self:Log("SPELL_MISSED", "ContainmentCellMissed", 345990)
	self:Log("SPELL_CAST_SUCCESS", "ArmedSecurity", 346204)
	self:Log("SPELL_PERIODIC_DAMAGE", "ArmedSecurityDamage", 348366)
	self:Log("SPELL_PERIODIC_MISSED", "ArmedSecurityDamage", 348366)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_CAST_START", "FullyArmed", 348128)
	end
	self:Log("SPELL_CAST_SUCCESS", "ImpoundContraband", 346006)
	self:Log("SPELL_AURA_APPLIED", "ImpoundContrabandApplied", 345770)
	self:Log("SPELL_AURA_REMOVED", "ImpoundContrabandRemoved", 345770)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_CAST_START", "ChargedSlash", 1236348)
	end
end

function mod:OnEngage()
	self:CDBar(346204, 8.7) -- Armed Security
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:CDBar(1236348, 12.1) -- Charged Slash
		self:CDBar(345770, 20.4) -- Impound Contraband
		self:CDBar(348128, 29.0) -- Fully Armed
		self:CDBar(348350, 39.9) -- Interrogation
	else -- XXX remove block in 11.2
		self:CDBar(345770, 19.3) -- Impound Contraband
		self:CDBar(348350, 34.1) -- Interrogation
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 9.2, CL.active, "achievement_dungeon_brokerdungeon")
end

function mod:Interrogation(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	-- energy is reset to 0 after this 1.5s cast, with a 30s energy gain afterwards
	self:CDBar(args.spellId, 31.5)
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
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:CDBar(346204, 8.6) -- Armed Security
		self:CDBar(1236348, 12.0) -- Charged Slash
		self:CDBar(345770, 20.4) -- Impound Contraband
		self:CDBar(348128, 29.0) -- Fully Armed
	else -- XXX remove block in 11.2
		self:CDBar(348350, 31.5) -- Interrogation
	end
	self:PlaySound(args.spellId, "info")
end

function mod:ContainmentCellMissed(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	else
		self:Message(args.spellId, "green", CL.removed_from:format(args.spellName, self:ColorName(args.destName)))
	end
	if not isElevenDotTwo then -- XXX remove block in 11.2
		-- if you immune the Interrogation cast Zo'phex's energy doesn't reset back to 0 which makes the next Interrogation phase come sooner
		self:CDBar(348350, 26.5) -- Interrogation
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
	self:CDBar(args.spellId, 20.7)
	self:PlaySound(args.spellId, "alarm")
end
