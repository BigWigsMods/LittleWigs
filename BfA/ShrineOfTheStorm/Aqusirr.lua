if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Aqu'sirr", 1864, 2153)
if not mod then return end
mod:RegisterEnableMob(134056)
mod.engageId = 2130

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		265001, -- Sea Blast
		264560, -- Choking Brine
		264155, -- Surging Rush
		264166, -- Undertow
		264903, -- Erupting Waters
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SeaBlast", 265001)
	self:Log("SPELL_AURA_APPLIED", "ChokingBrine", 264560)
	self:Log("SPELL_CAST_SUCCESS", "SurgingRush", 264155)
	self:Log("SPELL_CAST_SUCCESS", "Undertow", 264166)
	self:Log("SPELL_CAST_START", "EruptingWaters", 264903)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SeaBlast(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ChokingBrine(args)
	self:Message(args.spellId, "yellow")
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:PlaySound(args.spellId, "alarm", self:Dispeller("magic") and "dispel")
	end
end

function mod:SurgingRush(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:Undertow(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:EruptingWaters(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long", "stage")
end