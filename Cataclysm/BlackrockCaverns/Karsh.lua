-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Karsh Steelbender", 753, 107)
if not mod then return end
mod:RegisterEnableMob(39698)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		75842, -- Quicksilver Armor
		75846, -- Superheated Quicksilver Armor
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Armor", 75842)
	self:Log("SPELL_AURA_APPLIED", "SuperheatedArmor", 75846)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SuperheatedArmorDose", 75846)

	self:Death("Win", 39698)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Armor(args)
	self:Message(args.spellId, "Attention", "Alert")
end

do
	local function HeatedArmorBar(self, spellId, spellName, stacks)
		self:StopBar(("%dx %s"):format(stacks - 1, spellName))
		self:Bar(spellId, 17, ("%dx %s"):format(stacks, spellName))
	end

	function mod:SuperheatedArmor(args)
		mod:Message(args.spellId, "Important", "Info")
		HeatedArmorBar(self, args.spellId, args.spellName, 1)
	end

	function mod:SuperheatedArmorDose(args)
		HeatedArmorBar(self, args.spellId, args.spellName, args.amount)
	end
end

