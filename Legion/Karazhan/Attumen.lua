
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Attumen the Huntsman", 1651, 1835)
if not mod then return end
mod:RegisterEnableMob(114262, 114264) -- Attumen, Midnight
mod.engageId = 1960

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		227404, -- Intangible Presence
		227493, -- Mortal Strike
		228852, -- Shared Suffering
		227365, -- Spectral Charge
		228895, -- Enrage
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")
	self:Log("SPELL_CAST_START", "MortalStrike", 227493)
	self:Log("SPELL_AURA_APPLIED", "MortalStrikeApplied", 227493)
	self:Log("SPELL_AURA_REMOVED", "MortalStrikeRemoved", 227493)
	self:Log("SPELL_CAST_START", "SharedSuffering", 228852)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Enrage", 228895)
end

function mod:OnEngage()
	self:CDBar(227404, 5)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 227404 then -- Intangible Presence
		self:Message(spellId, "Attention", self:Dispeller("magic") and "Warning")
		self:Bar(spellId, 30)
	elseif spellId == 227338 then -- Riderless
		self:Message("stages", "Neutral", "Long", spellName, false)
		self:StopBar(227404) -- Intangible Presence
	elseif spellId == 227584 then -- Mounted
		self:Message("stages", "Neutral", "Long", spellName, false)
	elseif spellId == 227601 then -- Intermission, starts Spectral Charges
		self:Message(227365, "Attention", "Alert")
	end
end

function mod:MortalStrike(args)
	self:Message(args.spellId, "Important", (self:Tank() or self:Healer()) and "Alarm", CL.casting:format(args.spellName))
end

function mod:MortalStrikeApplied(args)
	if self:Tank(args.destName) then
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:MortalStrikeRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:SharedSuffering(args)
	self:Message(args.spellId, "Urgent", "Info")
end

function mod:Enrage(args)
	self:Message(args.spellId, "Important", "Long")
end
