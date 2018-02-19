-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Jin'do the Godbreaker", 859, 185)
if not mod then return end
mod:RegisterEnableMob(52148)

--------------------------------------------------------------------------------
--  Locals

local stage2 = false
local barrier = 3

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.barrier_down_message = "Barrier %d down!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"stages",
		97172, -- Shadows of Hakkar
		97417, -- Brittle Barrier
		{97597, "ICON", "FLASH"}, -- Spirit Warrior's Gaze
		97170, -- Deadzone
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowsOfHakkar", 97172)
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfHakkarApplied", 97172)
	self:Log("SPELL_AURA_REMOVED", "BarrierRemoved", 97417)
	self:Log("SPELL_CAST_START", "Phase2", 97158) -- Shadow Spike
	self:Log("SPELL_AURA_APPLIED", "WarriorsGaze", 97597)
	self:Log("SPELL_AURA_REMOVED", "WarriorsGazeRemoved", 97597)
	self:Log("SPELL_CAST_START", "Deadzone", 97170)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 52148)
end

function mod:OnEngage()
	stage2 = false
	barrier = 3
	self:CDBar(97172, 19) -- Shadows of Hakkar
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ShadowsOfHakkar(args)
	self:Message(args.spellId, "Attention", "Info", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 19)
end

function mod:ShadowsOfHakkarApplied(args)
	self:Message(args.spellId, "Important", "Long")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:BarrierRemoved(args)
	barrier = barrier - 1
	self:Message(args.spellId, "Important", "Alert", L.barrier_down_message:format(barrier))
end

function mod:Phase2(args)
	if not stage then
		stage2 = true
		self:Message("stages", "Important", "Long", CL.stage:format(2))
	end
end

function mod:WarriorsGaze(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:SecondaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:WarriorsGazeRemoved(args)
	self:SecondaryIcon(args.spellId)
end

function mod:Deadzone(args)
	self:Message(args.spellId, "Important", "Long")
	self:Bar(args.spellId, 21)
end
