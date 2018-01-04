-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Jin'do the Godbreaker", 793)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52148)
mod.toggleOptions = {
	"stages",
	97172, -- Shadows of Hakkar
	97417, -- Brittle Barrier
	{97597, "ICON", "FLASHSHAKE"}, -- Spirit Warrior's Gaze
	97170, -- Deadzone
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local phase2 = false
local barrier = 3

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["barrier_down_message"] = "Barrier %d down!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Shadow", 97172)
	self:Log("SPELL_AURA_REMOVED", "BarrierRemoved", 97417)
	self:Log("SPELL_CAST_START", "ShadowCast", 97172)
	self:Log("SPELL_CAST_START", "Phase2", 97158)
	self:Log("SPELL_AURA_APPLIED", "Gaze", 97597)
	self:Log("SPELL_AURA_REMOVED", "GazeRemoved", 97597)
	self:Log("SPELL_CAST_START", "DeadZone", 97170)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 52148)
end

function mod:OnEngage()
	phase2 = false
	barrier = 3
	self:Bar(97172, LW_CL["next"]:format(GetSpellInfo(97172)), 19, 97172)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Shadow(_, spellId, _, _, spellName)
	self:Message(97172, spellName, "Important", spellId, "Long")
	self:Bar(97172, spellName, 8, spellId)
end

function mod:BarrierRemoved(_, spellId)
	barrier = barrier - 1
	self:Message(97417, L["barrier_down_message"]:format(barrier), "Important", spellId, "Alert")
end

function mod:ShadowCast(_, spellId, _, _, spellName)
	self:Message(97172, LW_CL["casting"]:format(spellName), "Attention", spellId, "Info")
	self:Bar(97172, LW_CL["next"]:format(spellName), 19, spellId) 
end

function mod:Phase2(_, spellId)
	if not phase2 then
		phase2 = true
		self:Message("stages", CL.phase:format(2), "Important", spellId, "Long")
	end
end

function mod:Gaze(player, spellId, _, _, spellName)
	self:TargetMessage(97597, spellName, player, "Important", spellId, "Alert")
	self:SecondaryIcon(97597, player)
	if UnitIsUnit("player", player) then
		self:FlashShake(97597)
	end
end

function mod:GazeRemoved()
	self:SecondaryIcon(97597)
end

function mod:DeadZone(_, spellId, _, _, spellName)
	self:Message(97170, spellName, "Important", spellId, "Long")
	self:Bar(97170, spellName, 21, spellId)
end

