-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Exarch Maladaar", 722, 524)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18373)
mod.toggleOptions = {
	32346, -- Stolen Soul
	32424, -- Avatar of the Martyred
}

-------------------------------------------------------------------------------
--  Locals

local warned = nil

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["avatar_message"] = "Avatar of the Martyred spawning!"
	L["avatar_soon"] = "Avatar of the Martyred Spawning Soon"
	L["soul_message"] = "%s's soul stolen!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	if self:CheckOption(32424, "MESSAGE") then
		self:RegisterEvent("UNIT_HEALTH")
	end

	self:Log("SPELL_AURA_APPLIED", "Soul", 32346)
	self:Log("SPELL_CAST_START", "Avatar", 32424)
	self:Death("Win", 18373)
end

function mod:OnEnable()
	warned = nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Soul(player)
	self:Message(32346, L["soul_message"]:format(player), "Attention", 32346)
end

function mod:Avatar()
	self:Message(32424, L["avatar_message"], "Attention")
end

function mod:UNIT_HEALTH(event, msg)
	if UnitName(msg) ~= mod.displayName then return end
	local health = UnitHealth(msg)
	if health > 28 and health <= 33 and not warned then
		warned = true
		self:Message(32424, L["avatar_soon"], "Important", 32424)
	elseif health > 33 and warned then
		warned = nil
	end
end
