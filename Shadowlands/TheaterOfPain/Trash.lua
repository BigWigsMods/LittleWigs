
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Theater Of Pain Trash", 2293)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	164506, -- Ancient Captain
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ancient_captain = "Ancient Captain"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ancient Captain
		330562, -- Demoralizing Shout
	}, {
		[330562] = L.ancient_captain,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DemoralizingShout", 330562)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Ancient Captain
function mod:DemoralizingShout(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
end
