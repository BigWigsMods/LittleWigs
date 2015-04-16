
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Pandemonius", 732, 534)
if not mod then return end
mod:RegisterEnableMob(18341)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		38759, -- Dark Shell
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DarkShell", 32358, 38759)

	self:Death("Win", 18341)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkShell(args)
	self:Message(38759, "Attention", nil, CL.casting:format(args.spellName))
	self:Bar(38759, 6)
end

