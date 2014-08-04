
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Teron'gor", 984, 1225)
mod:RegisterEnableMob(77734)

-- XXX Notes
-- This fight seems unfinished by Blizzard.
-- Drain Life/Chaos Bolt seem too frequent to bother.

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{156921, "FLASH"}, "bosskill",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SeedOfCorruption", 156921)

	self:Death("Win", 77734)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SeedOfCorruption(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:TargetBar(args.spellId, 18, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

