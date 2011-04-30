-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Jin'do the Godbreaker", "Zul'Gurub")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52148)
mod.toggleOptions = {
	"phase",
	97172, -- Shadows of Hakkar
	97417, -- Brittle Barrier
	97198, -- Body Slam
	97170, -- Deadzone
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local phase2 = false
local barrier = 3
local slam = GetSpellInfo(43140)

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["phase"] = "Phase"
L["phase_desc"] = "Warn for phase changes."
L["barrier_down_message"] = "Barrier %d!"
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
	self:Bar(97172, LW_CL["next"]:format(spellName), 21, spellId)
end

function mod:BarrierRemoved(_, spellId)
	barrier = barrier - 1
	self:Message(97417, L["barrier_down_message"]:format(barrier), "Important", spellId, "Alert")
end

function mod:ShadowCast(_, spellId, _, _, spellName)
	self:Message(97172, LW_CL["casting"]:format(spellName), "Attention", spellId, "Info")
end

function mod:Phase2(_, spellId)
	if not phase2 then
		phase2 = true
		self:Message("phase", LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["phase"]:format(2), "Important", spellId, "Long")
	end
end

do
	local function checkTarget(sGUID)
		local mobId = mod:GetUnitIdByGUID(sGUID)
		if mobId then
			local player = UnitName(mobId.."target")
			mod:TargetMessage(97198, slam, player, "Important", 97198, "Alert")
		end
	end
	function mod:BodySlam(...)
		local sGUID = select(11, ...)
		self:ScheduleTimer(checkTarget, 0.2, sGUID)
	end
end

function mod:DeadZone(_, spellId, _, _, spellName)
	self:Message(97170, spellName, "Important", spellId, "Long")
	self:Bar(97170, spellName, 21, spellId)
end

