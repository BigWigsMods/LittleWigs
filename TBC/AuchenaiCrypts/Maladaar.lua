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
		"avatar", -- Avatar of the Martyred
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "StolenSoul", 32346)
	self:Log("SPELL_CAST_SUCCESS", "SummonAvatar", 32424)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 18373)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:StolenSoul(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
end

function mod:SummonAvatar(args)
	self:MessageOld("avatar", "red", "info", CL.spawned:format(self:SpellName(L.avatar)), args.spellId)
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 18373 then return end
	local hp = self:GetHealth(unit)
	if hp < 30 then
		self:UnregisterEvent(event)
		self:Message("avatar", "yellow", CL.soon:format(self:SpellName(32424)), false) -- Summon Avatar soon
	end
end
