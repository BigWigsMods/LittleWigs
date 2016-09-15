
--------------------------------------------------------------------------------
-- TODO List:
-- - UNIT_HEALTH_FREQUENT warnings are coded badly, was in a hurry, fix pls

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Inquisitor Tormentorum", 1045, 1695)
if not mod then return end
mod:RegisterEnableMob(96015)
mod.engageId = 1850

--------------------------------------------------------------------------------
-- Locals
--

local warnedForTeleport1 = nil
local warnedForTeleport2 = nil

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200898, -- Teleport
		202455, -- Void Shield
		212564, -- Inquisitive Stare
		{200904, "FLASH"}, -- Sapped Soul
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Teleport", 200898)
	self:Log("SPELL_AURA_APPLIED", "VoidShieldApplied", 202455)
	self:Log("SPELL_AURA_REMOVED", "VoidShieldRemoved", 202455)
	self:Log("SPELL_AURA_APPLIED", "InquisitiveStare", 212564)
	self:Log("SPELL_AURA_REFRESH", "InquisitiveStare", 212564)
	self:Log("SPELL_CAST_SUCCESS", "SapSoul", 206303)
	self:Log("SPELL_AURA_APPLIED", "SappedSoul", 200904)
	self:Log("SPELL_AURA_REFRESH", "SappedSoul", 200904)
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Teleport(args)
	self:Message(args.spellId, "Attention", "Info", CL.casting:format(args.spellName))
end

function mod:VoidShieldApplied(args)
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:VoidShieldRemoved(args)
	self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
end

do
	local prev = 0
	function mod:InquisitiveStare(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 0.5 then
			prev = t
			self:Message(args.spellId, "Urgent", "Alarm")
		end
	end
end

function mod:SapSoul(args)
	self:Message(200904, "Attention", "Info", CL.casting:format(args.spellName))
	self:CDBar(200904, 15.8, args.spellName)
end

do
	local prev = 0
	function mod:SappedSoul(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 0.5 then
			prev = t
			self:TargetMessage(args.spellId, args.destName, "Important", "Long")
			self:Flash(args.spellId)
		end
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 75 and not warnedForTeleport1 then -- Teleport at 70%
		warnedForTeleport1 = true
		self:Message(200898, "Attention", nil, CL.soon:format(self:SpellName(200898))) -- Teleport soon
	elseif hp < 45 and not warnedForTeleport2 then -- Teleport at 40%
		warnedForTeleport2 = true
		self:Message(200898, "Important", nil, CL.soon:format(self:SpellName(200898))) -- Teleport soon
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
	end
end
