-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Exarch Maladaar", 558, 524)
if not mod then return end
--mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18373)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.avatar_message = "Avatar of the Martyred spawning!"
	L.avatar_soon = "Avatar of the Martyred Spawning Soon"
	L.soul_message = "%s's soul stolen!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		32346, -- Stolen Soul
		32424, -- Avatar of the Martyred
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "StolenSoul", 32346)
	self:Log("SPELL_CAST_START", "AvatarOfTheMartyred", 32424)
	
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 18373)
end

function mod:OnEngage()
	if self:CheckOption(32424, "MESSAGE") then
		self:RegisterEvent("UNIT_HEALTH")
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:StolenSoul(args)
	self:Message(args.spellId, "Attention", nil, L.soul_message:format(player))
end

function mod:AvatarOfTheMartyred(args)
	self:Message(args.spellId, "Attention", nil, L.avatar_message)
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(UnitGUID(unit)) ~= 18373 then return end
	local health = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if health > 28 and health <= 33 then
		self:UnregisterEvent("UNIT_HEALTH")
		self:Message(32424, "Important", nil, L.avatar_soon)
	end
end
