
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Temple of Sethraliss Trash", 1822)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	134600, -- Sandswept Marksman
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.marksman = "Sandswept Marksman"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Sandswept Marksman
		264574, -- Power Shot
	}, {
		[264574] = L.marksman,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PowerShot", 264574)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PowerShot(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end
