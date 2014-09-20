
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Teron'gor", 984, 1225)
if not mod then return end
mod:RegisterEnableMob(77734)

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
		{156921, "FLASH"}, 157001, {157039, "SAY", "FLASH"}, "bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "SeedOfCorruption", 156921)
	self:Log("SPELL_CAST_START", "ChaosWave", 157001)
	self:Log("SPELL_CAST_START", "DemonicLeap", 157039)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "Success", "boss1")
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

do
	local function printTarget(self, player, guid)
		self:TargetMessage(157001, player, "Important", "Alert")
	end
	function mod:ChaosWave(args)
		self:CDBar(args.spellId, 13.2) -- 13.2-15.7
		self:GetBossTarget(printTarget, 1, args.sourceGUID)
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(157039)
			self:Flash(157039)
		end
		self:TargetMessage(157039, player, "Urgent", "Alarm")
	end
	function mod:DemonicLeap(args)
		self:CDBar(args.spellId, 20) -- 20-23
		self:GetBossTarget(printTarget, 1, args.sourceGUID)
	end
end

function mod:Success(unit, spellName, _, _, spellId)
	if spellId == 114268 then -- Shadow Nova
		self:Win()
	end
end

