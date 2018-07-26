-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Jin'do the Godbreaker", 859, 185)
if not mod then return end
mod:RegisterEnableMob(52148)
mod.engageId = 1182
mod.respawnTime = 30

--------------------------------------------------------------------------------
--  Locals
--

local barriersLeft = 3

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L.barrier_down_message = "Barrier down, %d remaining" -- short name for "Brittle Barrier" (97417)
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		97172, -- Shadows of Hakkar
		97170, -- Deadzone
		{-2910, "ICON", "SAY", "FLASH"}, -- Brittle Barrier
	}, {
		[97172] = CL.stage:format(1),
		[-2910] = CL.stage:format(2),
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowsOfHakkar", 97172)
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfHakkarApplied", 97172)
	self:Log("SPELL_AURA_REMOVED", "ShadowsOfHakkarRemoved", 97172)
	self:Log("SPELL_CAST_START", "Deadzone", 97170)

	self:Log("SPELL_AURA_REMOVED", "BrittleBarrierRemoved", 97417)
	self:Log("SPELL_AURA_APPLIED", "SpiritWarriorsGaze", 97597)
	self:Log("SPELL_AURA_REMOVED", "SpiritWarriorsGazeRemoved", 97597)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:CDBar(97172, 19) -- Shadows of Hakkar
end

-------------------------------------------------------------------------------
--  Event Handlers
--


function mod:ShadowsOfHakkar(args)
	self:Message(args.spellId, "yellow", "Info", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 19)
end

function mod:ShadowsOfHakkarApplied(args)
	self:Message(args.spellId, "red", "Long")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:ShadowsOfHakkarRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Deadzone(args)
	self:Message(args.spellId, "red", "Long")
	self:Bar(args.spellId, 21)
end

function mod:BrittleBarrierRemoved()
	barriersLeft = barriersLeft - 1
	self:Message(-2910, "red", "Alert", L.barrier_down_message:format(barriersLeft))
end

function mod:SpiritWarriorsGaze(args)
	if self:Me(args.destGUID) then
		self:Say(-2910, args.spellId)
		self:Flash(-2910, args.spellId)
	end
	self:TargetMessage(-2910, args.destName, "red", "Alert", args.spellId)
	self:SecondaryIcon(-2910, args.destName)
end

function mod:SpiritWarriorsGazeRemoved()
	self:SecondaryIcon(-2910)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 98861 then -- Spirit World
		barriersLeft = 3
		self:Message("stages", "red", "Long", CL.other:format(CL.stage:format(2), self:SpellName(spellId)), false)
		self:StopBar(97172) -- Shadows of Hakkar
	end
end
