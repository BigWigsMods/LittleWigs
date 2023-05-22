--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Gobbamak", 2097, 2357)
if not mod then return end
mod:RegisterEnableMob(150159)
mod.engageId = 2290

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{297254, "CASTBAR"}, -- Charged Smash
		{297257, "ME_ONLY"}, -- Electrical Charge
		{297261, "CASTBAR"}, -- Rumble
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChargedSmash", 297254)
	self:Log("SPELL_AURA_APPLIED", "ElectricalChargeApplied", 297257)
	self:Log("SPELL_CAST_SUCCESS", "Rumble", 297261)
end

function mod:OnEngage()
	self:Bar(297261, 8.4) -- Rumble
	self:Bar(297254, 21.8) -- Charged Smash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChargedSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 3)
	self:CDBar(args.spellId, 33)
end

function mod:ElectricalChargeApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:Rumble(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 5)
	self:CDBar(args.spellId, 50)
end
