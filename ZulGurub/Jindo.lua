-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Jin'do the Godbreaker", "Zul'Gurub")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52148)
mod.toggleOptions = {
	"phase",
	97172,
	97417,
	97198,
	97170,
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local phase2 = false
local barrier = 3
local shadows = GetSpellInfo(97172)
local slam = GetSpellInfo(43140)

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["phase"] = "Phase"
L["phase_desc"] = "Warn for phase changes."
L["phase_message"] = "Phase 2!"
L["barrier_down_message"] = "Barrier %d%!"
--@localization(locale="enUS", namespace="ZulGurub/Jindo", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Shadow", 97172)
	self:Log("SPELL_AURA_REMOVED", "BarrierRemoved", 97417)
	self:Log("SPELL_CAST_START", "ShadowCast", 97172)
	self:Log("SPELL_CAST_START", "Phase2", 97158)
	self:Log("SPELL_CAST_START", "BodySlam", 97198)
	self:Log("SPELL_CAST_START", "DeadZone", 97170)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 52148)
end

function mod:OnEngage()
	phase2 = false
	barrier = 3
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Shadow(_, spellId, _, _, spellName)
	self:Message(97172, spellName, "Important", spellId, "Long")
	self:Bar(97172, spellName, 10, spellId)
	self:Bar(97172, LW_CL["next"]:format(shadows), 21, spellId)
end

function mod:BarrierRemoved(_, spellId)
	barrier = barrier - 1
	self:Message(97417, L["barrier_down_message"]:format(barrier), "Important", spellId, "Alert")
end

function mod:ShadowCast(_, spellId, _, _, spellName)
	self:Message(97172, LW_CL["casting"]:format(spellName), "Attention", spellId, "Info")
end

function mod:Phase2(_, spellId, _, _, spellName)
	phase2 = true
	self:Message("phase", L["phase_message"], "Important", spellId, "Long")
end

do
	local function checkTarget()
		local player = UnitName("boss1target")
		mod:TargetMessage(97198, slam, player, "Important", 97198, "Alert")
	end
	function mod:BodySlam()
		self:ScheduleTimer(checkTarget, 0.2)
	end
end

function mod:DeadZone(_, spellId, _, _, spellName)
	self:Message(97170, spellName, "Important", spellId, "Long")
	self:Bar(97170, spellName, 21, spellId)
end

