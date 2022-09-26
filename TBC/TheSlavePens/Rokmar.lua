
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Rokmar the Crackler", 547, 571)
if not mod then return end
mod:RegisterEnableMob(17991)
-- mod.engageId = 1941 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34970, -- Frenzy
		31948, -- Ensnaring Moss
		38801, -- Grievous Wound
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 34970)
	self:Log("SPELL_AURA_APPLIED", "EnsnaringMoss", 31948)
	self:Log("SPELL_AURA_REMOVED", "EnsnaringMossRemoved", 31948)
	self:Log("SPELL_AURA_APPLIED", "GrievousWound", 31956, 38801)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 17991)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Frenzy(args)
	self:MessageOld(args.spellId, "red", nil, CL.percent:format(20, args.spellName))
end

function mod:EnsnaringMoss(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:EnsnaringMossRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:GrievousWound(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessageOld(38801, args.destName, "orange")
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 17991 then
		local hp = self:GetHealth(unit)
		if hp < 26 then
			self:UnregisterEvent(event)
			self:MessageOld(34970, "green", nil, CL.soon:format(self:SpellName(34970)), false)
		end
	end
end

