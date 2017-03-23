if select(4, GetBuildInfo()) < 70200 then return end -- XXX dont load on live

--------------------------------------------------------------------------------
-- TODO List:
-- - Mythic

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thrashbite the Scornful", 1146, 1906)
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
		240928, -- Destructive Rampage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PulverizingCudgel", 237276)
	self:Log("SPELL_AURA_APPLIED", "ScornfulGaze", 237726)
	self:Log("SPELL_CAST_SUCCESS", "DestructiveRampage", 240928)
end

function mod:OnEngage()
	self:Bar(237276, 6.1)
	self:Bar(237726, 9.7)
	self:Bar(240928, 20.6)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PulverizingCudgel(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:CDBar(args.spellId, 30)
end

function mod:ScornfulGaze(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Warning", args.spellName)
	self:TargetBar(args.spellId, 7, args.destName)
	self:CDBar(args.spellId, 30)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Flash(args.spellId)
	end
end

function mod:DestructiveRampage(args)
	self:Message(args.spellId, "Important", "Alert", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 30)
end
