--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gahz'rilla", 209, 483)
if not mod then return end
mod:RegisterEnableMob(7273) -- Gahz'rilla
mod:SetEncounterID(594)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{11836, "DISPEL"}, -- Freeze Solid
		11902, -- Gahz'rilla Slam
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FreezeSolid", 11836)
	self:Log("SPELL_AURA_APPLIED", "FreezeSolidApplied", 11836)
	self:Log("SPELL_CAST_START", "GahzrillaSlam", 11902)
	self:Log("SPELL_CAST_SUCCESS", "GahzrillaSlamSuccess", 11902)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 7273)
	end
end

function mod:OnEngage()
	self:CDBar(11836, 12.2) -- Freeze Solid
	self:CDBar(11902, 13.1) -- Gahz'rilla Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FreezeSolid(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:FreezeSolidApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", true, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

function mod:GahzrillaSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:GahzrillaSlamSuccess(args)
	self:CDBar(args.spellId, 7.3)
end
