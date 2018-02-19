--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Botanist Freywinn", 553, 559)
if not mod then return end
--mod.otherMenu = "Tempest Keep"
mod:RegisterEnableMob(17975)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34550, -- Tranquility
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Tranquility", 34550)
	self:Death("Win", 17975)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Tranquility(args)
	self:Message(args.spellId, "Important", nil, CL.casting(args.spellName))
	self:Bar(args.spellId, 15)
end
