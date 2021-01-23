
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Theater Of Pain Trash", 2293)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	164506, -- Ancient Captain
	174210, -- Blighted Sludge-Spewer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ancient_captain = "Ancient Captain"
	L.blighted_sludge_spewer = "Blighted Sludge-Spewer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ancient Captain
		330562, -- Demoralizing Shout
		-- Blighted Sludge-Spewer
		341969, -- Withering Discharge
	}, {
		[330562] = L.ancient_captain,
		[341969] = L.blighted_sludge_spewer,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DemoralizingShout", 330562)
	self:Log("SPELL_CAST_START", "WitheringDischarge", 341969)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Ancient Captain
function mod:DemoralizingShout(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
end

-- Blighted Sludge-Spewer
function mod:WitheringDischarge(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
