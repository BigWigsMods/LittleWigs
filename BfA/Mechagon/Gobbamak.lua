if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Gobbamak", 2097, 2357)
if not mod then return end
mod:RegisterEnableMob(0)
--mod.engageId = XXX

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		297254, -- Charged Smash
		297257, -- Electrical Charge XXX spell id is probably wrong
		297261, -- Rumble
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChargedSmash", 297254)
	self:Log("SPELL_AURA_APPLIED", "ElectricalChargeApplied", 297257)
	self:Log("SPELL_CAST_SUCCESS", "Rumble", 297261)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChargedSmash(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:ElectricalChargeApplied(args)
	self:TargetMessage2(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:Rumble(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 5)
end
