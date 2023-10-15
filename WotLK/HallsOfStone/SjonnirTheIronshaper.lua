-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sjonnir The Ironshaper", 599, 607)
if not mod then return end
mod:RegisterEnableMob(27978)
mod:SetEncounterID(mod:Classic() and 569 or 1998)
mod:SetRespawnTime(30)

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		50834, -- Static Charge
		{50840, "CASTBAR"}, -- Lightning Ring
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
	self:TargetMessage(50834, "yellow", args.destName)
	self:PlaySound(50834, "alarm")
	self:TargetBar(50834, 10, args.destName)
end

function mod:LightningRing(args)
	self:Message(50840, "orange", CL.casting:format(args.spellName))
	self:CastBar(50840, 10)
end
