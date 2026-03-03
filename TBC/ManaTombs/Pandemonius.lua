
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
	},nil,{
		[38759] = CL.spell_reflection, -- Dark Shell (Spell Reflection)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DarkShellApplied", 32358, 38759) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "DarkShellRemoved", 32358, 38759)

	self:Death("Win", 18341)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkShellApplied(args)
	self:Message(38759, "yellow", CL.spell_reflection)
	self:Bar(38759, self:Classic() and 8 or 6, CL.spell_reflection)
	self:PlaySound(38759, "warning")
end

function mod:DarkShellRemoved(args)
	self:Message(38759, "green", CL.over:format(CL.spell_reflection))
	self:PlaySound(38759, "info")
end
