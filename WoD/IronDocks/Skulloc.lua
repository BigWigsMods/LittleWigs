
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skulloc", 987, 1238)
if not mod then return end
mod:RegisterEnableMob(83612, 83613, 83616) -- Skulloc, Koramar, Zoggosh

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
		{168929, "FLASH"}, -- Cannon Barrage
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "CannonBarrage", 168929)

	self:Death("Win", 83612)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CannonBarrage(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:Flash(args.spellId)
end

