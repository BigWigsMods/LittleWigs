-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sjonnir The Ironshaper", 599, 607)
if not mod then return end
--mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27978)

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
	self:Log("SPELL_AURA_APPLIED", "StaticCharge", 50834, 59846)
	self:Log("SPELL_CAST_SUCCESS", "LightningRing", 50840, 59848, 59861, 51849)
	self:Death("Win", 27978)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:StaticCharge(args)
	self:TargetMessage(50834, args.destName, "Personal", "Alarm")
	self:TargetBar(50834, 10, args.destName)
end

function mod:LightningRing(args)
	self:Message(50840, "Urgent", nil, CL.casting:format(args.spellName))
	self:CastBar(50840, 10)
end
