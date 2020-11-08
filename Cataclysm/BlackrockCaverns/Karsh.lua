-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Karsh Steelbender", 645, 107)
if not mod then return end
mod:RegisterEnableMob(39698)
mod.engageId = 1039
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		75842, -- Quicksilver Armor
		75846, -- Superheated Quicksilver Armor
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "QuicksilverArmor", 75842)
	self:Log("SPELL_AURA_APPLIED", "SuperheatedQuicksilverArmor", 75846)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SuperheatedQuicksilverArmorDose", 75846)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:QuicksilverArmor(args)
	self:MessageOld(args.spellId, "yellow", "alert")
end

function mod:SuperheatedQuicksilverArmor(args)
	self:MessageOld(args.spellId, "red", "info")
	self:Bar(args.spellId, 17)
end

function mod:SuperheatedQuicksilverArmorDose(args)
	self:Bar(args.spellId, 17)
	if args.amount % 2 == 1 or args.amount > 5 then
		self:StackMessage(args.spellId, args.destName, args.amount, "red", self:Tank() and "warning")
	end
end
