
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
		{167757, "FLASH"}, -- Fixate
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:RegisterEvent("RAID_BOSS_WHISPER")

	--self:Log("SPELL_AURA_APPLIED", "Fixate", 167757) -- XXX wowNext/6.2
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

--[[ XXX wowNext/6.2
function mod:Fixate(args)
	self:Message(args.spellId, "Personal", "Alarm", CL.you:format(args.spellName))
	self:Flash(args.spellId)
end
]]

function mod:RAID_BOSS_WHISPER()
	-- RAID_BOSS_WHISPER#|TInterface\\Icons\\ability_fixated_state_red:20|tA Solar Flare has |cFFFF0000|Hspell:176544|h[Fixated]|h|r on you! If it reaches you it will |cFFFF0000|Hspell:153828|h[Explode]|h|r!#Solar Flare#1#true
	self:Message(167757, "Personal", "Alarm", CL.you:format(self:SpellName(167757)))
	self:Flash(167757)
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

