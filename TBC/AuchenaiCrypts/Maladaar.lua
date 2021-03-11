-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Exarch Maladaar", 558, 524)
if not mod then return end
mod:RegisterEnableMob(18373)
-- mod.engageId = 1889 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.avatar = -5046 -- Avatar of the Martyred
	L.avatar_desc = -5045 -- EJ entry of the summoning spell, has better description than that of the actual spell
	L.avatar_icon = -5045
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		32346, -- Stolen Soul
		"avatar",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "target", "focus")
	self:Log("SPELL_AURA_APPLIED", "StolenSoul", 32346)
	self:Log("SPELL_CAST_SUCCESS", "AvatarOfTheMartyred", 32424)

	self:Death("Win", 18373)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:StolenSoul(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
end

function mod:AvatarOfTheMartyred(args)
	self:MessageOld("avatar", "red", "info", CL.spawned:format(self:SpellName(L.avatar)), args.spellId)
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 18373 then return end
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 30 then
		self:UnregisterUnitEvent(event, "target", "focus")
		self:MessageOld("avatar", "yellow", nil, CL.soon:format(CL.spawning:format(self:SpellName(L.avatar))), 32424)
	end
end
