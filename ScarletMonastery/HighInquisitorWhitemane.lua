
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Inquisitor Whitemane", 874, 674)
mod:RegisterEnableMob(3977, 60040) -- Whitemane, Durand

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "yell"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"bosskill"}
end

function mod:OnBossEnable()
	--self:Log("SPELL_AURA_APPLIED", "QuickenedMind", 113682)
	--self:Log("SPELL_CAST_START", "BreathCast", 113641)
	--self:Log("SPELL_AURA_APPLIED", "BreathChannel", 113641)
	--self:Log("SPELL_AURA_REMOVED", "BreathEnd", 113641)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	--self:Death("Win", 3977)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
--[[
function mod:QuickenedMind(player, spellId, _, _, spellName)
	self:Message(spellId, CL["other"]:format(spellName, player), "Urgent", spellId, "Alert")
end

function mod:BreathCast(_, spellId)
	self:Message(spellId, CL["cast"]:format(breath), "Attention", spellId, "Alarm")
	self:Bar(spellId, CL["cast"]:format(breath), 2, spellId)
end

function mod:BreathChannel(_, spellId)
	self:Bar(spellId, "<"..breath..">", 10, spellId)
end

function mod:BreathEnd(_, spellId)
	self:Bar(spellId, "~"..breath, 33, spellId)
end
]]
