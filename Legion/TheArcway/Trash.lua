
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Arcway Trash", 1079)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	211217 -- Arcane Anomaly
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.anomaly = "Arcane Anomaly"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Arcane Anomaly ]]--
		211217, -- Arcane Slicer
	}, {
		[211217] = L.anomaly,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	-- Arcane Anomaly
	self:Log("SPELL_CAST_START", "ArcaneSlicer", 211217)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Arcane Anomaly
function mod:ArcaneSlicer(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end
