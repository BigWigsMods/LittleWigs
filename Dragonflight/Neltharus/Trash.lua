--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharus Trash", 2519)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	189265 -- Qalashi Bonetender
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.qalashi_bonetender = "Qalashi Bonetender"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Qalashi Bonetender
		372223, -- Mending Clay
	}, {
		[372223] = L.qalashi_bonetender,
	}
end

function mod:OnBossEnable()
	-- Qalashi Bonetender
	self:Log("SPELL_CAST_START", "MendingClay", 372223)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Qalashi Bonetender

function mod:MendingClay(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
