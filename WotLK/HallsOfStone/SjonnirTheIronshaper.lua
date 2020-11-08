-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sjonnir The Ironshaper", 599, 607)
if not mod then return end
mod:RegisterEnableMob(27978)
mod.engageId = 1998
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		50834, -- Static Charge
		50840, -- Lightning Ring
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "StaticCharge", 50834, 59846) -- normal, heroic
	self:Log("SPELL_CAST_SUCCESS", "LightningRing", 50840, 59848) -- normal, heroic
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:StaticCharge(args)
	self:TargetMessageOld(50834, args.destName, "blue", "alarm")
	self:TargetBar(50834, 10, args.destName)
end

function mod:LightningRing(args)
	self:MessageOld(50840, "orange", nil, CL.casting:format(args.spellName))
	self:CastBar(50840, 10)
end
