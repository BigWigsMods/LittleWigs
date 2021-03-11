
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rukhran", 1209, 967)
if not mod then return end
mod:RegisterEnableMob(76143)
mod.engageId = 1700
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Locals
--

local quillsWarn = 100

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
	self:RegisterEvent("RAID_BOSS_WHISPER")
	--self:Log("SPELL_AURA_APPLIED", "Fixate", 167757) -- XXX

	self:Log("SPELL_CAST_START", "PierceArmor", 153794)
	self:Log("SPELL_CAST_START", "SummonSolarFlare", 153810)
	self:Log("SPELL_CAST_START", "Quills", 159382)
end

function mod:OnEngage()
	quillsWarn = 100
	self:RegisterUnitEvent("UNIT_HEALTH", "QuillsWarn", "boss1")
	self:Bar(153794, 10.5) -- Pierce Armor
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RAID_BOSS_WHISPER()
	-- RAID_BOSS_WHISPER#|TInterface\\Icons\\ability_fixated_state_red:20|tA Solar Flare has |cFFFF0000|Hspell:176544|h[Fixated]|h|r on you! If it reaches you it will |cFFFF0000|Hspell:153828|h[Explode]|h|r!#Solar Flare#1#true
	self:MessageOld(167757, "blue", "alarm", CL.you:format(self:SpellName(167757)))
	self:Flash(167757)
end

-- XXX
--function mod:Fixate(args)
--	if self:Me(args.destGUID) then
--		self:MessageOld(args.spellId, "blue", "alarm", CL.you:format(args.spellName))
--		self:Flash(args.spellId)
--	end
--end

function mod:PierceArmor(args)
	self:MessageOld(args.spellId, "yellow", "warning")
	self:Bar(args.spellId, 10.9)
end

function mod:SummonSolarFlare(args)
	self:MessageOld(args.spellId, "red", "info")
end

function mod:Quills(args)
	self:MessageOld(args.spellId, "orange", "long", CL.percent:format(quillsWarn, args.spellName))
	self:Bar(args.spellId, 17)
end

function mod:QuillsWarn(event, unitId)
	local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
	if (hp < 67 and quillsWarn == 100) or (hp < 27 and quillsWarn == 60) then
		quillsWarn = quillsWarn - 40
		self:MessageOld(159382, "green", nil, CL.soon:format(self:SpellName(159382)), false)
		if quillsWarn == 20 then
			self:UnregisterUnitEvent(event, unitId)
		end
	end
end
