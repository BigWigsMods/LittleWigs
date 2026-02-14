--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rukhran", 1209, 967)
if not mod then return end
mod:RegisterEnableMob(76143)
mod:SetEncounterID(1700)
mod:SetRespawnTime(15)
mod:SetPrivateAuraSounds({
	{1253511, sound = "info"}, -- Burning Pursuit
	{1253520, sound = "alarm"}, -- Burning Claws
})

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
		167757, -- Fixate
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("RAID_BOSS_WHISPER")
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
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{1253511, "PRIVATE"}, -- Burning Pursuit
			{1253520, "PRIVATE"}, -- Burning Claws
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RAID_BOSS_WHISPER()
	-- RAID_BOSS_WHISPER#|TInterface\\Icons\\ability_fixated_state_red:20|tA Solar Flare has |cFFFF0000|Hspell:176544|h[Fixated]|h|r on you! If it reaches you it will |cFFFF0000|Hspell:153828|h[Explode]|h|r!#Solar Flare#1#true
	self:Message(167757, "blue", CL.you:format(self:SpellName(167757)))
	self:PlaySound(167757, "warning")
end

function mod:PierceArmor(args)
	self:Message(args.spellId, "purple")
	self:Bar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SummonSolarFlare(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "info")
end

function mod:Quills(args)
	self:Message(args.spellId, "orange", CL.percent:format(quillsWarn, args.spellName))
	self:Bar(args.spellId, 17)
	self:PlaySound(args.spellId, "long")
end

function mod:QuillsWarn(event, unit)
	local hp = self:GetHealth(unit)
	if (hp < 67 and quillsWarn == 100) or (hp < 27 and quillsWarn == 60) then
		quillsWarn = quillsWarn - 40
		self:Message(159382, "green", CL.soon:format(self:SpellName(159382)), false)
		if quillsWarn == 20 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end
