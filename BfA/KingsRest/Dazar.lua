
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dazar, The First King", 1762, 2172)
if not mod then return end
mod:RegisterEnableMob(136160, 136984, 136976) -- Dazar, Reban, T'zala
mod.engageId = 2143

--------------------------------------------------------------------------------
-- Locals
--

local nextHPWarning = 85
local mobCollector = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.spears_active = "Spear Launchers Active"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{268586, "TANK_HEALER"}, -- Blade Combo
		{268932, "SAY", "ICON", "PROXIMITY"}, -- Quaking Leap
		268403, -- Gale Slash
		269231, -- Hunting Leap
		269369, -- Deathly Roar
	}, {
		[268586] = "general",
		[269231] = -18251, -- Reban
		[269369] = -18254, -- T'zala
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Death("Deaths", 136984, 136976) -- Reban, T'zala

	self:Log("SPELL_CAST_START", "BladeCombo", 268586)
	self:Log("SPELL_CAST_START", "QuakingLeap", 268932)
	self:Log("SPELL_CAST_START", "GaleSlash", 268403)
	self:Log("SPELL_CAST_SUCCESS", "QuakingLeapLanding", 268936)
	self:Log("SPELL_CAST_SUCCESS", "HuntingLeap", 269231)
	self:Log("SPELL_DAMAGE", "HuntingLeapDamage", 269230)
	self:Log("SPELL_MISSED", "HuntingLeapDamage", 269230)
	self:Log("SPELL_CAST_START", "DeathlyRoar", 269369)
end

function mod:OnEngage()
	nextHPWarning = 85 -- 80%, 60% and 40%
	mobCollector = {}
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:INSTANCE_ENCOUNTER_ENGAGE_UNIT()

	self:CDBar(268586, 18.2) -- Blade Combo
	self:CDBar(268932, 12.1) -- Quaking Leap
	self:CDBar(268932, 12.1) -- Gale Slash
end

function mod:VerifyEnable(unit)
	local hp = UnitHealthMax(unit)
	return hp > 0 and (UnitHealth(unit) / hp) > 0.1 -- 10%
end

function mod:OnBossDisable()
	mobCollector = {}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 3 do
		local guid = self:UnitGUID(("boss%d"):format(i))
		if guid and not mobCollector[guid] then
			mobCollector[guid] = true

			local mobId = self:MobId(guid)
			if mobId == 136984 then -- Reban
				self:Message("stages", "yellow", CL.spawned:format(self:SpellName(-18251)), false)
				self:CDBar(269231, 5) -- Hunting Leap
			elseif mobId == 136976 then -- T'zala
				self:Message("stages", "yellow", CL.spawned:format(self:SpellName(-18254)), false)
				self:CDBar(269369, 8.5) -- Deathly Roar
			end
		end
	end
end

function mod:Deaths(args)
	if args.mobId == 136984 then -- Reban
		self:StopBar(269231) -- Hunting Leap
	else -- T'zala
		self:StopBar(269369) -- Deathly Roar
	end
end

do
	local mechanics = {
		-18251, -- Reban
		-18254, -- T'zala
		268796, -- Impaling Spear
	}
	function mod:UNIT_HEALTH(event, unit)
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < nextHPWarning then
			local index = 3 - (nextHPWarning - 45) / 20 -- 85 -> 1, 65 -> 2, 45 -> 3
			nextHPWarning = nextHPWarning - 20
			self:Message("stages", "cyan", CL.soon:format(self:SpellName(mechanics[index])), false)
			self:PlaySound("stages", "info")

			if index >= #mechanics then
				self:UnregisterUnitEvent(event, unit)
			end
		end
	end
end

function mod:BladeCombo(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17)
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(268932, "orange", player)
		self:PlaySound(268932, "long", nil, player)
		self:PrimaryIcon(268932, player)
		if self:Me(guid) then
			self:Say(268932)
			self:OpenProximity(268932, 20) -- 20 is a guesstimate
		else
			self:OpenProximity(268932, 20, player)
		end
	end

	function mod:QuakingLeap(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 20)
	end

	function mod:QuakingLeapLanding()
		self:PrimaryIcon(268932)
		self:CloseProximity(268932)
	end
end

function mod:GaleSlash(args)
	self:CDBar(args.spellId, 14.5)
end

function mod:HuntingLeap(args)
	self:CDBar(args.spellId, 12.2)
end

do
	local prev = 0
	function mod:HuntingLeapDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(269231, "near")
				self:PlaySound(269231, "alert")
			end
		end
	end
end

function mod:DeathlyRoar(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 13.3)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(event, unit, _, spellId)
	if spellId == 269377 then -- Spike Pattern Controller
		self:Message("stages", "yellow", L.spears_active, 268796) -- Impaling Spear
		self:UnregisterUnitEvent(event, unit)
	end
end
