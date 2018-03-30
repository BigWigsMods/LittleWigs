
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skulloc", 1195, 1238)
if not mod then return end
mod:RegisterEnableMob(83612, 83613, 83616) -- Skulloc, Koramar, Zoggosh

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then

end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		168227, -- Gronn Smash
		{168929, "FLASH"}, -- Cannon Barrage
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "GronnSmash", 168227)
	self:Log("SPELL_CAST_START", "CannonBarrage", 168929)

	self:Death("Win", 83612)
end

function mod:OnEngage()
	self:CDBar(168227, 30) -- Gronn Smash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GronnSmash(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 60)
end

function mod:CannonBarrage(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Flash(args.spellId)
end
