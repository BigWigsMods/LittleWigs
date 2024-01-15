
--------------------------------------------------------------------------------
-- TODO List:
-- - Mythic

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thrashbite the Scornful", 1677, 1906)
if not mod then return end
mod:RegisterEnableMob(117194)
mod.engageId = 2057

--------------------------------------------------------------------------------
-- Locals
--

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		237276, -- Pulverizing Cudgel
		{237726, "SAY", "FLASH"}, -- Scornful Gaze
		243124, -- Heave Cudgel
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PulverizingCudgel", 237276)
	self:Log("SPELL_AURA_APPLIED", "ScornfulGaze", 237726)
	self:Log("SPELL_CAST_SUCCESS", "HeaveCudgel", 243124)
end

function mod:OnEngage()
	self:Bar(237276, 6.1)
	self:Bar(243124, 15.8)
	self:Bar(237726, 25.5)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PulverizingCudgel(args)
	self:MessageOld(args.spellId, "orange", "alert")
	self:CDBar(args.spellId, 37)
end

function mod:ScornfulGaze(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "warning", args.spellName)
	self:TargetBar(args.spellId, 7, args.destName)
	self:CDBar(args.spellId, 37)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Scornful Gaze")
		self:Flash(args.spellId)
	end
end

function mod:HeaveCudgel(args)
	self:MessageOld(args.spellId, "red", "alert", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 37)
end
