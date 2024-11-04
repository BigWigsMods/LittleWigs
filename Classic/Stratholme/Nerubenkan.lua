--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nerub'enkan", 329, 452)
if not mod then return end
mod:RegisterEnableMob(10437) -- Nerub'enkan
mod:SetEncounterID(480)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		17235, -- Raise Undead Scarab
		{6016, "TANK"}, -- Pierce Armor
		{4962, "DISPEL"}, -- Encasing Webs
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RaiseUndeadScarab", 17235)
	self:Log("SPELL_CAST_SUCCESS", "PierceArmor", 6016)
	self:Log("SPELL_CAST_SUCCESS", "EncasingWebs", 4962)
	self:Log("SPELL_AURA_APPLIED", "EncasingWebsApplied", 4962)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10437)
	end
end

function mod:OnEngage()
	self:CDBar(4962, 6.1) -- Encasing Webs
	self:CDBar(6016, 8.0) -- Pierce Armor
	self:CDBar(17235, 8.5) -- Raise Undead Scarab
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RaiseUndeadScarab(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 27.9)
	self:PlaySound(args.spellId, "info")
end

function mod:PierceArmor(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 8.0)
	self:PlaySound(args.spellId, "alert")
end

function mod:EncasingWebs(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 10437 then -- Nerub'enkan
		self:CDBar(args.spellId, 10.9)
	end
end

function mod:EncasingWebsApplied(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 10437 then -- Nerub'enkan
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alarm", nil, args.destName)
		end
	end
end
