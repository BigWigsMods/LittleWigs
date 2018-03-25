
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
local scheduled, bossesDead = {}, {}

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
	--[[
	self:Log("SPELL_AURA_APPLIED", "Intensity", 113315)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Intensity", 113315)
	self:Log("SPELL_AURA_REMOVED", "IntensityRemoved", 113315)
	self:Log("SPELL_AURA_APPLIED", "UltimatePower", 113309)
	self:Death("BossDeath", 59051, 59726) -- Strife, Peril
	]]

	-- [[ The Champion of the Five Suns ]] --
	self:Log("SPELL_CAST_START", "HellfireArrows", 113017)
	self:Death("SunDeath", 56915)
	self:Death("ShaDeath", 58856)
end

function mod:OnEngage()
	sunsDead = 0
	shaDead = 0
	--[[
	wipe(scheduled)
	wipe(bossesDead)

end

function mod:OnBossDisable()
	wipe(scheduled)
	wipe(bossesDead)
	]]
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
-- FIXME: rewrite this with UNIT_AURA because
-- consistency regarding combat logs is overrated.
--[[
do
	local function announce(self, destGUID, destName, spellName)
		if not bossesDead[destGUID] then -- they lose the buff 2s after dying, so CancelTimer() didn't work
			self:Message(-5549, "Positive", "Info", CL.removed_from:format(spellName, destName))
		end
		scheduled[destGUID] = nil
	end

	function mod:Intensity(args)
		local amount = args.amount or 1
		if (amount % 3 == 1 or amount > 7) and amount ~= 10 then -- 1, 4, 7, 8, 9 (10th stack gets instantly replaced by "Ultimate Power")
			self:StackMessage(-5549, args.destName, amount, "Urgent", amount > 7 and UnitGUID("target") == args.destGUID and "Warning" or "Alert")
		end
	end

	function mod:IntensityRemoved(args) -- "Ultimate Power" removes "Intensity", so we are scheduling a bit
		scheduled[args.destGUID] = self:ScheduleTimer(announce, 0.2, self, args.destGUID, args.destName, args.spellName)
	end

	function mod:UltimatePower(args)
		self:TargetMessage(-5549, args.destName, "Important", "Warning", args.spellId)
		if scheduled[args.destGUID] then
			self:CancelTimer(scheduled[args.destGUID])
		end
	end

	function mod:BossDeath(args)
		bossesDead[args.destGUID] = true
	end
end
]]

-- [[ The Champion of the Five Suns ]] --
function mod:SunDeath(args)
	sunsDead = sunsDead + 1
	self:Message("stages", "Positive", "Info", CL.mob_killed:format(args.destName, sunsDead, 4), false)
end

function mod:ShaDeath(args)
	shaDead = shaDead + 1

	-- High level characters can oneshot suns before ENCOUNTER_START fires
	if shaDead > sunsDead then
		sunsDead = shaDead
	end

	self:Message("stages", "Positive", "Info", CL.mob_killed:format(args.destName, shaDead, 4), false)
	if shaDead == 4 then
		self:Bar("stages", 9.5, CL.stage:format(2), "inv_summerfest_firespirit")
	end
end

-- Using this to detect stage 2, because both
-- UnitIsEnemy() and UnitCanAttack() return false
-- when IEEU fires.
function mod:HellfireArrows(args)
	self:RemoveLog("SPELL_CAST_START", args.spellId)
	self:Message("stages", "Positive", "Info", CL.stage:format(2), false)
end
