--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Kolurg/Stoutbeard", 576, UnitFactionGroup("player") == "Horde" and 617 or 833)
if not mod then return end
mod:RegisterEnableMob(26798, 26796) -- Commander Kolurg, Commander Stoutbeard

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		38618, -- Whirlwind
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Whirlwind", 38618)

	self:Death("Win", 26798, 26796)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Whirlwind(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 14.5)
end
