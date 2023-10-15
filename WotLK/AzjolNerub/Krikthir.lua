-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Krik'thir the Gatewatcher", 601, 585)
if not mod then return end
mod:RegisterEnableMob(28684)
mod:SetEncounterID(mod:Classic() and 216 or 1971)
mod:SetRespawnTime(30)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		52592, -- Curse of Fatigue
		28747, -- Frenzy
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CurseOfFatigue", 52592, 59368) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "CurseOfFatigueRemoved", 52592, 59368)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 28747)

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CurseOfFatigue(args)
	self:TargetMessage(52592, "yellow", args.destName)
	self:TargetBar(52592, 10, args.destName)
end

function mod:CurseOfFatigueRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Frenzy(args)
	self:Message(args.spellId, "red", CL.percent:format(20, args.spellName))
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 28684 then return end
	local hp = self:GetHealth(unit)
	if hp < 26 then
		self:UnregisterUnitEvent(event, unit)
		if hp > 20 then
			self:Message(28747, "red", CL.soon:format(self:SpellName(28747))) -- Frenzy
		end
	end
end
