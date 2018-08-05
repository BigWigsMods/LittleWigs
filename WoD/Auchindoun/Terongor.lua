
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Teron'gor", 1182, 1225)
if not mod then return end
mod:RegisterEnableMob(77734)
mod.engageId = 1714
mod.respawnTime = 33

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	local _
	_, L.affliction = GetSpecializationInfoByID(265)
	_, L.demonology = GetSpecializationInfoByID(266)
	_, L.destruction = GetSpecializationInfoByID(267)
end


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		156854, -- Drain Life
		156856, -- Rain of Fire
		{157168, "ICON"}, -- Fixate
		{156921, "FLASH", "PROXIMITY"}, -- Seed of Malevolence
		{157001, "SAY"}, -- Chaos Wave
		{157039, "SAY", "FLASH"}, -- Demonic Leap
		156975, -- Chaos Bolt
	}, {
		["stages"] = "general",
		[156921] = L.affliction,
		[157001] = L.demonology,
		[156975] = L.destruction,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SeedOfMalevolence", 156921)
	self:Log("SPELL_AURA_REMOVED", "SeedOfMalevolenceRemoved", 156921)
	self:Log("SPELL_AURA_APPLIED", "Fixate", 157168)
	self:Log("SPELL_AURA_APPLIED", "RainOfFire", 156856)
	self:Log("SPELL_CAST_START", "ChaosWave", 157001)
	self:Log("SPELL_CAST_START", "DemonicLeap", 157039)
	self:Log("SPELL_CAST_SUCCESS", "DrainLife", 156854)
	self:Log("SPELL_CAST_START", "ChaosBolt", 156975)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:Message("stages", "green", "Info", CL.stage:format(1), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 80 then
		self:UnregisterUnitEvent(event, unit)
		self:Message("stages", "yellow", "Info", CL.soon:format(CL.stage:format(2)), false)
	end
end

function mod:SeedOfMalevolence(args)
	self:TargetMessage(args.spellId, args.destName, "yellow", "Alert")
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
	self:TargetMessage(args.spellId, args.destName, "green", "Warning")
	self:TargetBar(args.spellId, 12, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:RainOfFire(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "blue", "Alarm", CL.you:format(args.spellName))
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(157001)
		end
		self:TargetMessage(157001, player, "red", "Alert")
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
		self:TargetMessage(157039, player, "orange", "Alarm")
	end
	function mod:DemonicLeap(args)
		self:CDBar(args.spellId, 20) -- 20-23
		self:GetBossTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:DrainLife(args)
	self:Message(args.spellId, "yellow", "Long", CL.casting:format(args.spellName))
end

function mod:ChaosBolt(args)
	self:Message(args.spellId, "yellow", "Long", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 24)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 156863 then -- Affliction Transformation
		self:Message("stages", "green", "Info", CL.other:format(CL.stage:format(2), L.affliction), "spell_shadow_deathcoil")
	elseif spellId == 156919 then -- Demonology Transformation
		self:Message("stages", "green", "Info", CL.other:format(CL.stage:format(2), L.demonology), "spell_shadow_metamorphosis")
	elseif spellId == 156866 then -- Destruction Transformation
		self:Message("stages", "green", "Info", CL.other:format(CL.stage:format(2), L.destruction), "spell_shadow_rainoffire")
	end
end
