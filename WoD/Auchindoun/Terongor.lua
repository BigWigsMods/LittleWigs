
--------------------------------------------------------------------------------
-- Module Declaration
--

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
		{156921, "FLASH", "PROXIMITY"}, -- Seed of Malevolence
		{157001, "SAY"}, -- Chaos Wave
		{157039, "SAY", "FLASH"}, -- Demonic Leap
		156854, -- Drain Life
		{157168, "ICON"}, -- Fixate
		156856, -- Rain of Fire
		"bosskill",
	}
end

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 15 then
		return true
	end
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "SeedOfMalevolence", 156921)
	self:Log("SPELL_AURA_REMOVED", "SeedOfMalevolenceRemoved", 156921)
	self:Log("SPELL_AURA_APPLIED", "Fixate", 157168)
	self:Log("SPELL_AURA_APPLIED", "RainOfFire", 156856)
	self:Log("SPELL_CAST_START", "ChaosWave", 157001)
	self:Log("SPELL_CAST_START", "DemonicLeap", 157039)
	self:Log("SPELL_CAST_SUCCESS", "DrainLife", 156854)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "Success", "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SeedOfMalevolence(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL.you:format(args.spellName))
		self:TargetBar(args.spellId, 18, args.destName)
		self:Flash(args.spellId)
		self:OpenProximity(args.spellId, 10)
	end
end

function mod:SeedOfMalevolenceRemoved(args)
	if self:Me(args.destGUID) then
		self:CloseProximity(args.spellId)
	end
end

function mod:Fixate(args)
	self:TargetMessage(args.spellId, args.destName, "Positive", "Warning")
	self:TargetBar(args.spellId, 12, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:RainOfFire(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.you:format(args.spellName))
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(157001)
		end
		self:TargetMessage(157001, player, "Important", "Alert")
	end
	local function grabTrashTarget(self, mobGUID)
		local unit = self:GetUnitIdByGUID(mobGUID)
		if unit then
			local unitTarget = unit.."target"
			local name = self:UnitName(unitTarget)
			local guid = UnitGUID(unitTarget)
			if name and guid then
				printTarget(self, name, guid)
			end
		end
	end
	function mod:ChaosWave(args)
		if self:MobId(args.sourceGUID) == 77734 then -- Boss
			self:CDBar(args.spellId, 13.2) -- 13.2-15.7
			self:GetBossTarget(printTarget, 0.3, args.sourceGUID)
		else -- Trash
			self:ScheduleTimer(grabTrashTarget, 0.1, self, args.sourceGUID)
		end
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
		self:GetBossTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:DrainLife(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end

function mod:Success(unit, spellName, _, _, spellId)
	if spellId == 114268 then -- Shadow Nova
		self:Win()
	end
end

