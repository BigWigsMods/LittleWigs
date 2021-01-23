
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lorewalker Stonestep", 960, 664)
if not mod then return end
mod:RegisterEnableMob(
	57080, -- Corrupted Scroll

	-- The Trial of the Yaungol:
	59051, -- Strife
	59726, -- Peril

	-- The Champion of the Five Suns:
	58826, -- Zao Sunseeker
	56915 -- Sun
)
mod.engageId = 1417
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

-- [[ The Trial of the Yaungol ]] --
local isTrialOfTheYaungol = nil
local stacksOfIntensity = {}

-- [[ The Champion of the Five Suns ]] --
local sunsDead, shaDead = 0, 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	L.yaungol_warmup_trigger = "Ah, it is not yet over."

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	L.five_suns_warmup_trigger = "If I am not mistaken"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		-5549, -- Intensity
		"stages",
	}, {
		["warmup"] = "general",
		[-5549] = -5537, -- The Trial of the Yaungol
		["stages"] = -5536, -- The Champion of the Five Suns
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	-- [[ The Trial of the Yaungol ]] --
	self:RegisterUnitEvent("UNIT_AURA", nil, "boss1", "boss2")
	self:Log("SPELL_AURA_APPLIED", "UltimatePower", 113309)

	-- [[ The Champion of the Five Suns ]] --
	self:Log("SPELL_CAST_START", "HellfireArrows", 113017)
	self:Death("SunDeath", 56915)
	self:Death("ShaDeath", 58856)
end

function mod:OnEngage()
	sunsDead = 0
	shaDead = 0
	isTrialOfTheYaungol = nil
	stacksOfIntensity = {}
end

function mod:OnBossDisable()
	stacksOfIntensity = {}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg:find(L.yaungol_warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 16.7, CL.active, "achievement_jadeserpent")
	elseif msg:find(L.five_suns_warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 31.45, CL.active, "achievement_jadeserpent")
	end
end

-- Zao Sunseeker's encounter has no boss frames during the first stage
-- forcing pre-ba08796 behaviour to counter that.
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

-- [[ The Trial of the Yaungol ]] --

-- SPELL_AURA_* events for Intensity behave inconsistently on this encounter, sometimes one of them fires them
-- but the other one doesn't, then they might even switch on the next pull. A lot of fun.
function mod:UNIT_AURA(event, unit)
	local guid = self:UnitGUID(unit)
	if not isTrialOfTheYaungol then -- check mob ids and unregister the event if it's not needed
		local mobId = self:MobId(guid)
		if mobId == 59051 or mobId == 59726 then
			isTrialOfTheYaungol = true
		else
			self:UnregisterUnitEvent(event, "boss1", "boss2")
			return
		end
	end

	-- 10th stack gets replaced by Ultimate Power (113309),
	-- this is why I'm not showing a warning for it and not showing
	-- a message that stacks are gone when Ultimate Power is present
	local destName, spellName = self:UnitName(unit), self:SpellName(113315)
	local _, stacks = self:UnitBuff(unit, 113315) -- Intensity
	if not stacks then
		if stacksOfIntensity[guid] and stacksOfIntensity[guid] > 0 then
			stacksOfIntensity[guid] = 0
			if not UnitIsDead(unit) and not self:UnitBuff(unit, 113309) then -- Ultimate Power
				self:MessageOld(-5549, "green", "info", CL.removed_from:format(spellName, destName))
			end
		end
	elseif not stacksOfIntensity[guid] or stacksOfIntensity[guid] < stacks then
		stacksOfIntensity[guid] = stacks
		if (stacks % 3 == 1 or stacks > 7) and stacks ~= 10 then
			self:MessageOld(-5549, "orange", stacks > 7 and self:UnitGUID("target") == guid and "warning" or "alert", CL.stack:format(stacks, spellName, destName))
		end
	end
end

function mod:UltimatePower(args)
	self:MessageOld(-5549, "red", "warning", CL.other:format(args.spellName, args.destName), args.spellId)
	self:TargetBar(-5549, 15, args.destName, args.spellId)
end

-- [[ The Champion of the Five Suns ]] --
function mod:SunDeath(args)
	sunsDead = sunsDead + 1
	self:MessageOld("stages", "green", "info", CL.mob_killed:format(args.destName, sunsDead, 4), false)
end

function mod:ShaDeath(args)
	shaDead = shaDead + 1

	-- High level characters can oneshot suns before ENCOUNTER_START fires
	if shaDead > sunsDead then
		sunsDead = shaDead
	end

	self:MessageOld("stages", "green", "info", CL.mob_killed:format(args.destName, shaDead, 4), false)
	if shaDead == 4 then
		self:Bar("stages", 9.5, CL.stage:format(2), "inv_summerfest_firespirit")
	end
end

-- Using this to detect stage 2, because both
-- UnitIsEnemy() and UnitCanAttack() return false
-- when IEEU fires.
function mod:HellfireArrows(args)
	self:RemoveLog("SPELL_CAST_START", args.spellId)
	self:MessageOld("stages", "green", "info", CL.stage:format(2), false)
end
