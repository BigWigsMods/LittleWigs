if not BigWigsLoader.isNext then return end -- 12.1.5
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kindo'jan", 3043)
if not mod then return end
mod:SetEncounterID(3548)
mod:SetAllowWin(true)
--mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	kindojan = "Kindo'jan",
})
mod.displayName = L.kindojan

--------------------------------------------------------------------------------
-- Auras
--

mod:SetAuraData({
	{1301288, soundOnApplied = "info", tip = CL.debuffTargetedNote:format(mod:SpellName(1301288))}, -- Eruption of Mojo
	{1300767, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Erratic Mojo
	{1303494, soundOnApplied = "warning", soundOnAppliedDose = "warning", tip = CL.debuffFailureNote}, -- Disgraceful Display
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
