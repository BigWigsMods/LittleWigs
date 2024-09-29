-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trollgore", 600, 588)
if not mod then return end
mod:RegisterEnableMob(26630)
--mod:SetEncounterID(mod:Classic() and 369 or 1974) -- starts randomly when other trash mobs attack him
--mod:SetRespawnTime(0) -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{49639, "TANK"}, -- Crush
		{49637, "DISPEL"}, -- Infected Wound
		59803, -- Consume
	}
end

function mod:OnBossEnable()
	if self:Classic() then
		self:CheckForEngage()
	else
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	end
	self:Log("SPELL_AURA_APPLIED", "InfectedWound", 49637)
	self:Log("SPELL_AURA_REMOVED", "InfectedWoundRemoved", 49637)
	self:Log("SPELL_CAST_SUCCESS", "InfectedWoundCastSuccess", 49637)

	self:Log("SPELL_CAST_SUCCESS", "Crush", 49639)
	self:Log("SPELL_CAST_SUCCESS", "Consume", 49380, 59803) -- normal, heroic
	self:Death("Win", 26630)
end

function mod:OnEngage()
	if self:Classic() then
		self:CheckForWipe()
	end
	self:CDBar(49639, 8.5) -- Crush
	self:CDBar(59803, 15.6) -- Consume
	self:CDBar(49637, 19.2) -- Infected Wound
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:InfectedWound(args)
	if self:Me(args.destGUID) or self:Healer() or self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:InfectedWoundRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:InfectedWoundCastSuccess(args)
	self:CDBar(args.spellId, 15.8) -- 15.8 - 20.7s
end

function mod:Crush(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 8) -- 8 - 15.2s
end

function mod:Consume()
	self:Message(59803, "yellow")
	self:CDBar(59803, 15.8)
end
