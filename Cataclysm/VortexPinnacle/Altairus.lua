
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Altairus", 769, 115)
if not mod then return end
mod:RegisterEnableMob(43873)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		88282, -- Upwind of Altairus
		88286, -- Downwind of Altairus
		{88308, "ICON"}, -- Chilling Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Wind", 88282, 88286) -- Upwind of Altairus, Downwind of Altairus
	self:Log("SPELL_CAST_START", "ChillingBreath", 88308)

	self:Death("Win", 43873)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Wind(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Info")
	end
end

function mod:ChillingBreath(args)
	self:Bar(args.spellId, 12)
	self:TargetMessage(args.spellId, self:UnitName("boss1target"), "Urgent")
	self:PrimaryIcon(args.spellId, self:UnitName("boss1target"))
	self:ScheduleTimer("PrimaryIcon", 4, args.spellId)
end

