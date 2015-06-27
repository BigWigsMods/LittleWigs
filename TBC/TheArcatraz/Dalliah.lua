
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Dalliah the Doomsayer", 731, 549)
if not mod then return end
mod:RegisterEnableMob(20885)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		39013, -- Heal
		36175, -- Whirlwind
		39009, -- Gift of the Doomsayer
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Heal", 36144, 39013)
	self:Log("SPELL_CAST_START", "Whirlwind", 36175, 36142)
	self:Log("SPELL_AURA_APPLIED", "GiftOfTheDoomsayer", 36173, 39009)

	self:Death("Win", 20885)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Heal(args)
	self:Message(39013, "Urgent", nil, CL.casting:format(args.spellName))
end

function mod:Whirlwind()
	self:Message(36175, "Important")
	self:Bar(36175, 6)
end

function mod:GiftOfTheDoomsayer(args)
	self:TargetMessage(39009, args.destName, "Attention")
	self:TargetBar(39009, 10, args.destName)
end

