
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Volkhan", 602, 598)
if not mod then return end
mod:RegisterEnableMob(28587)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		59529, -- Shattering Stomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShatteringStomp", 52237, 59529) -- normal, heroic

	self:Death("Win", 28587)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShatteringStomp(args)
	self:MessageOld(59529, "orange", nil, CL.casting:format(args.spellName))
	self:Bar(59529, 3)
end

