
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Teron'gor", 984, 1225)
if not mod then return end
mod:RegisterEnableMob(77734)

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
		156975, -- Chaos Bolt
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
	self:Log("SPELL_CAST_START", "ChaosBolt", 156975)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "Success", "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SeedOfMalevolence(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 18, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:OpenProximity(args.spellId, 10)
	end
end

function mod:SeedOfMalevolenceRemoved(args)
	self:StopBar(args.spellId, args.destName) -- on death
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
	function mod:ChaosWave(args)
		self:CDBar(args.spellId, 13.2) -- 13.2-15.7
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID) -- GetUnitTarget so it works for the trash add also
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

function mod:ChaosBolt(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 24)
end

function mod:Success(_, _, _, _, spellId)
	if spellId == 114268 then -- Shadow Nova
		self:Win()
	end
end

