
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rukhran", 989, 967)
if not mod then return end
mod:RegisterEnableMob(76143)

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
		{153794, "TANK"}, -- Pierce Armor
		153810, -- Summon Solar Flare
		159382, -- Quills
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Emote("Fixated", "Fixated")

	self:Log("SPELL_CAST_START", "PierceArmor", 153794)
	self:Log("SPELL_CAST_START", "SummonSolarFlare", 153810)
	self:Log("SPELL_CAST_START", "Quills", 159382)

	self:Death("Win", 76143)
end

function mod:OnEngage()
	self:Bar(153794, 10.5) -- Pierce Armor
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Fixated()
	-- fixme
	self:Message(159382, "Personal", "Alarm", CL.you:format("Fixated"), false)
	--self:Flash()
end

function mod:PierceArmor(args)
	self:Message(args.spellId, "Attention", "Warning")
	self:Bar(args.spellId, 10.9)
end

function mod:SummonSolarFlare(args)
	self:Message(args.spellId, "Important", "Info")
end

function mod:Quills(args)
	self:Message(args.spellId, "Urgent", "Long")
end

