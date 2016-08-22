-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Karsh Steelbender", 753)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39698)
mod.toggleOptions = {
	75842, -- Quicksilver Armor
	93567, -- Superheated Quicksilver Armor
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local superheated = GetSpellInfo(101305)

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Armor", 75842)
	self:Log("SPELL_AURA_APPLIED", "HeatedArmor", 75846, 93567)
	self:Log("SPELL_AURA_APPLIED_DOSE", "HeatedArmorDose", 75846, 93567)

	self:Death("Win", 39698)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Armor(_, _, _, _, spellName)
	self:Message(75842, spellName, "Attention", 75842, "Alert")
end

do
	local function HeatedArmorBar(spellId, buffStack)
		if not buffStack then buffStack = 1 end
		mod:SendMessage("BigWigs_StopBar", mod, ("%dx %s"):format(buffStack - 1, superheated))
		mod:Bar(93567, ("%dx %s"):format(buffStack, superheated), 17, spellId)
	end

	function mod:HeatedArmor(_, spellId, _, _, spellName, buffStack)
		mod:Message(93567, spellName, "Important", spellId, "Info")
		HeatedArmorBar(spellId, buffStack)
	end

	function mod:HeatedArmorDose(_, spellId, _, _, spellName, buffStack)
		HeatedArmorBar(spellId, buffStack)
	end
end

