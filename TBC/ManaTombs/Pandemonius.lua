
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Pandemonius", 557, 534)
if not mod then return end
mod:RegisterEnableMob(18341)
-- mod.engageId = 1900 -- no boss frames, no ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		38759, -- Dark Shell
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DarkShell", 32358, 38759) -- normal, heroic

	self:Death("Win", 18341)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkShell(args)
	self:MessageOld(38759, "yellow", nil, CL.casting:format(args.spellName))
	self:Bar(38759, 6)
end

