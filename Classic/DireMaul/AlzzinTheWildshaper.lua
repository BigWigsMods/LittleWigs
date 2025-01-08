--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Alzzin the Wildshaper", 429, 405)
if not mod then return end
mod:RegisterEnableMob(11492) -- Alzzin the Wildshaper
mod:SetEncounterID(346)
mod:SetStage(1)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Satyr Form
		22661, -- Enervate
		{22662, "DISPEL"}, -- Wither
		-- Tree Form
		7948, -- Wild Regeneration
		{10101, "TANK"}, -- Knock Away
		22415, -- Entangling Roots
		-- Dire Wolf Form
		22689, -- Mangle
	}, {
		[22662] = -4921, -- Satyr Form
		[22415] = -4926, -- Tree Form
		[22689] = -4925, -- Dire Wolf Form
	}
end

function mod:OnBossEnable()
	-- Satyr Form
	self:Log("SPELL_CAST_START", "Enervate", 22661)
	self:Log("SPELL_CAST_START", "Wither", 22662)
	self:Log("SPELL_AURA_APPLIED", "WitherApplied", 22662)

	-- Tree Form
	self:Log("SPELL_AURA_APPLIED", "TreeForm", 22688)
	self:Log("SPELL_AURA_REMOVED", "TreeFormOver", 22688)
	self:Log("SPELL_CAST_START", "WildRegeneration", 7948)
	self:Log("SPELL_CAST_SUCCESS", "KnockAway", 10101)
	self:Log("SPELL_CAST_START", "EntanglingRoots", 22415)

	-- Dire Wolf Form
	self:Log("SPELL_AURA_APPLIED", "DireWolfForm", 22660)
	self:Log("SPELL_AURA_REMOVED", "DireWolfFormOver", 22660)
	self:Log("SPELL_CAST_SUCCESS", "Mangle", 22689)
	self:Log("SPELL_AURA_APPLIED", "MangleApplied", 22689)

	if self:Heroic() or (self:Classic() and not self:Vanilla()) then -- no encounter events in Timewalking or Cataclysm Classic
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11492)
	elseif self:Classic() then -- no ENCOUNTER_END in Vanilla
		self:Death("Win", 11492)
	end
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(22662, 0.9) -- Wither
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Satyr Form

function mod:Enervate(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	-- unknown CD
	self:PlaySound(args.spellId, "alert")
end

function mod:Wither(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 7.3)
	self:PlaySound(args.spellId, "alert")
end

function mod:WitherApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

-- Tree Form

function mod:TreeForm(args)
	self:StopBar(22662) -- Wither
	self:SetStage(2)
	self:Message("stages", "cyan", args.spellName, args.spellId)
	self:CDBar(22415, 6.4) -- Entangling Roots
	self:CDBar(10101, 7.3) -- Knock Away
	self:PlaySound("stages", "long")
end

function mod:TreeFormOver(args)
	self:StopBar(22415) -- Entangling Roots
	self:StopBar(10101) -- Knock Away
	self:SetStage(1)
end

function mod:WildRegeneration(args)
	-- cast immediately on entering Tree Form, but only if below 50%.
	-- will also cast immediately if brought below 50% while already in Tree Form.
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:KnockAway(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:EntanglingRoots(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 6.1)
	self:PlaySound(args.spellId, "alert")
end

-- Dire Wolf Form

function mod:DireWolfForm(args)
	self:StopBar(22662) -- Wither
	self:SetStage(3)
	self:Message("stages", "cyan", args.spellName, args.spellId)
	self:CDBar(22689, 4.8) -- Mangle
	self:PlaySound("stages", "long")
end

function mod:DireWolfFormOver(args)
	self:StopBar(22689) -- Mangle
	self:SetStage(1)
end

function mod:Mangle(args)
	self:CDBar(args.spellId, 7.3)
end

function mod:MangleApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end
