--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magmatusk", 2519, 2494)
if not mod then return end
mod:RegisterEnableMob(181861) -- Magmatusk
mod:SetEncounterID(2610)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_neltharus"
end

--------------------------------------------------------------------------------
-- Locals
--

local volatileMutationCount = 1
local lavaSprayCount = 1
local blazingChargeCount = 1
local magmaTentacleCount = 2

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		374365, -- Volatile Mutation
		375890, -- Magma Eruption
		{375068, "OFF"}, -- Magma Lob
		{375251, "SAY"}, -- Lava Spray
		{375439, "SAY"}, -- Blazing Charge
		375535, -- Lava Wave
		{391457, "TANK"}, -- Lava Empowerment
	}, {
		[391457] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VolatileMutation", 374365)
	self:Log("SPELL_CAST_SUCCESS", "MagmaEruption", 374365) -- Volatile Mutation success starts Magma Eruption
	self:Log("SPELL_CAST_START", "MagmaLob", 375068)
	self:Log("SPELL_CAST_START", "LavaSpray", 375251)
	self:Log("SPELL_CAST_SUCCESS", "BlazingCharge", 375436)
	self:Log("SPELL_AURA_APPLIED", "BlazingChargeApplied", 375455)
	self:Log("SPELL_AURA_APPLIED", "LavaEmpowermentApplied", 391457)
	self:Log("SPELL_AURA_REMOVED", "LavaEmpowermentRemoved", 391457)
end

function mod:OnEngage()
	volatileMutationCount = 1
	lavaSprayCount = 1
	blazingChargeCount = 1
	magmaTentacleCount = 2
	self:StopBar(CL.active)
	self:CDBar(375251, 7.2) -- Lava Spray
	self:CDBar(375439, 19.1) -- Blazing Charge
	-- casts at full Magma: 30s energy gain + ~.3s delay
	self:CDBar(374365, 30.3, CL.count:format(self:SpellName(374365), volatileMutationCount)) -- Volatile Mutation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 10.6, CL.active, L.warmup_icon)
end

do
	local prev = 0
	function mod:VolatileMutation(args)
		-- sometimes gets double cast, only second cast succeeds
		local t = args.time
		if t - prev > 3 then
			prev = t
			self:StopBar(CL.count:format(args.spellName, volatileMutationCount))
			self:Message(args.spellId, "orange", CL.count:format(args.spellName, volatileMutationCount))
			self:PlaySound(args.spellId, "long")
		end
		-- pull:31.9, 32.5, 32.8, 32.8
		-- casts at full Magma: 2.5s cast + 30s energy gain
		volatileMutationCount = volatileMutationCount + 1
		self:CDBar(args.spellId, 32.5, CL.count:format(args.spellName, volatileMutationCount))
		-- soonest Lava Spray or Blazing Charge can happen after this is 5.7s
		if self:BarTimeLeft(375251) < 5.7 then -- Lava Spray
			self:CDBar(375251, {5.7, 19.4})
		end
		if self:BarTimeLeft(375439) < 5.7 then -- Blazing Charge
			self:CDBar(375439, {5.7, 26.7})
		end
	end
end

function mod:MagmaEruption(args)
	-- lasts for 5 seconds per Magma Tentacle spawned
	local magmaEruptionDuration = magmaTentacleCount * 5
	self:Message(375890, "red", CL.duration:format(self:SpellName(375890), magmaEruptionDuration)) -- Magma Eruption for x sec
	self:PlaySound(375890, "alert")
	-- self:Bar(375890, magmaEruptionDuration, CL.on_group:format(self:SpellName(375890))) not really useful?
	if magmaTentacleCount < 5 then -- caps at 5
		magmaTentacleCount = magmaTentacleCount + 1
	end
end

do
	local prev = 0
	function mod:MagmaLob(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(375251, "yellow", name)
		self:PlaySound(375251, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(375251, nil, nil, "Lava Spray")
		end
	end

	function mod:LavaSpray(args)
		-- Magmatusk targets a player about 1s into the the 3.5s Lava Spray cast
		self:GetNextBossTarget(printTarget, args.sourceGUID, 2)
		lavaSprayCount = lavaSprayCount + 1
		if lavaSprayCount == 2 then
			self:CDBar(args.spellId, 29.1)
		else
			self:CDBar(args.spellId, 19.4)
		end
		-- soonest other abilities can happen after this is ~6.06s
		local volatileMutationBarText = CL.count:format(self:SpellName(374365), volatileMutationCount) -- Volatile Mutation (n)
		if self:BarTimeLeft(volatileMutationBarText) < 6.06 then
			self:CDBar(374365, {6.06, 27.9}, volatileMutationBarText) -- Volatile Mutation
		end
		if self:BarTimeLeft(375439) < 6.06 then -- Blazing Charge
			self:CDBar(375439, {6.06, 26.7})
		end
	end
end

function mod:BlazingCharge(args)
	self:TargetMessage(375439, "red", args.destName)
	self:PlaySound(375439, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(375439, nil, nil, "Blazing Charge")
	end
	blazingChargeCount = blazingChargeCount + 1
	if blazingChargeCount == 2 then
		self:CDBar(375439, 23.9)
	else
		self:CDBar(375439, 26.7)
	end
	-- Lava Spray can't be sooner than 8.5s after Blazing Charge
	if self:BarTimeLeft(375251) < 8.5 then -- Lava Spray
		self:CDBar(375251, {8.5, 19.4})
	end
end

function mod:BlazingChargeApplied(args)
	-- when Magmatusk hits the wall it gets the Blazing Charge debuff and sends out a Lava Wave
	self:Message(375535, "orange") -- Lava Wave
	self:PlaySound(375535, "alarm")
end

do
	local timer

	local function alertLavaEmpowerment(spellName)
		timer = nil
		mod:Message(391457, "purple", CL.onboss:format(spellName))
		mod:PlaySound(391457, "alert")
	end

	function mod:LavaEmpowermentApplied(args)
		-- allow 1.5 seconds of Magmatusk standing in lava before alerting
		timer = self:ScheduleTimer(alertLavaEmpowerment, 1.5, args.spellName)
	end

	function mod:LavaEmpowermentRemoved(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		else
			-- alert when removed only if we've previously shown an application alert
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end
