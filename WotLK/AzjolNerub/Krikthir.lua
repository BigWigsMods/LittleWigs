-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Krik'thir the Gatewatcher", 533, 585)
if not mod then return end
--mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(28684)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		52592, -- Curse of Fatigue
		28747, -- Frenzy
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CurseOfFatigue", 52592, 59368)
	self:Log("SPELL_AURA_APPLIED", "CurseOfFatigueRemoved", 52592, 59368)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 28747)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 28684)
end

function mod:OnEngage()
	if self:CheckOption(28747, "MESSAGE") then -- Frenzy is %-based
		self:RegisterEvent("UNIT_HEALTH")
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CurseOfFatigue(args)
	self:TargetMessage(52592, args.destName, "Attention")
	self:TargetBar(52592, 10, args.destName)
end

function mod:CurseOfFatigueRemoved(args)
	self:StopBar(52592, args.destName)
end

function mod:Frenzy(args)
	self:Message(args.spellId, "Important", nil, CL.onboss:format(args.spellName))
end

function mod:UNIT_HEALTH(event, unit)
	if UnitName(unit) ~= self.displayName then return end
	local health = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if health > 10 and health <= 15 then
		self:UnregisterEvent("UNIT_HEALTH")
		self:Message(28747, "Important", nil, CL.soon(self:SpellName(28747))) -- Frenzy
	end
end
