if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Galvazzt", 1877, 2144)
if not mod then return end
mod:RegisterEnableMob(133389)
mod.engageId = 2126

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		266923, -- Electroshock
		266512, -- Consume Charge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Electroshock", 266923)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Electroshock", 266923)
	self:Log("SPELL_AURA_APPLIED", "ElectroshockOnBoss", 265986) -- Buff for boss is Arc
	self:Log("SPELL_CAST_START", "ConsumeCharge", 266512)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Electroshock(args)
	if self:Me(args.destGUID) then
		local amount = args.amount or 1
		if amount % 2 == 1 then
			self:TargetMessage2(args.spellId, "cyan", args.destName)
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:ElectroshockOnBoss(args)
	self:TargetMessage2(266923, "orange", args.destName)
	self:PlaySound(266923, "alarm")
end

function mod:ConsumeCharge(args)
	self:Message(args.spellId, "red", "Warning")
end
