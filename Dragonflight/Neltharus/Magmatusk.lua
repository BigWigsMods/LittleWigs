--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magmatusk", 2519, 2494)
if not mod then return end
mod:RegisterEnableMob(181861) -- Magmatusk
mod:SetEncounterID(2610)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local volatileMutationCount = 0
local lavaSprayCount = 0
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
		375251, -- Lava Spray
		{375439, "SAY"}, -- Blazing Charge
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
	self:Log("SPELL_AURA_APPLIED", "LavaEmpowermentApplied", 391457)
	self:Log("SPELL_AURA_REMOVED", "LavaEmpowermentRemoved", 391457)
end

function mod:OnEngage()
	volatileMutationCount = 0
	lavaSprayCount = 0
	magmaTentacleCount = 2
	self:CDBar(375251, 7.2) -- Lava Spray
	self:CDBar(375439, 19.1) -- Blazing Charge
	-- casts at full Magma: 25s energy gain + ~.3s delay
	self:CDBar(374365, 25.3, CL.count:format(self:SpellName(374365), 1)) -- Volatile Mutation (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 10.6, CL.active, "achievement_dungeon_neltharus")
end

do
	local prev = 0
	function mod:VolatileMutation(args)
		-- sometimes gets double cast, only second cast succeeds
		local t = args.time
		if t - prev > 3 then
			prev = t
			volatileMutationCount = volatileMutationCount + 1
			self:StopBar(CL.count:format(args.spellName, volatileMutationCount))
			self:Message(args.spellId, "orange", CL.count:format(args.spellName, volatileMutationCount))
			self:PlaySound(args.spellId, "long")
		end
		-- pull:25.3, 31.5, 27.9, 31.6, 26.8, 31.6, 28.0, 31.6, 26.8, 31.6, 28.0, 28.0
		-- pull:26.8, 31.7, 27.9, 27.9, 31.6, 27.9, 27.9, 31.6, 27.9, 31.6, 28.0
		-- casts at full Magma: 2.5s cast + 25s energy gain + .4s minimum delay
		self:CDBar(args.spellId, 27.9, CL.count:format(args.spellName, volatileMutationCount + 1))
	end
end

function mod:MagmaEruption(args)
	-- lasts for 5 seconds per Magma Tentacle spawned
	local magmaEruptionDuration = magmaTentacleCount * 5
	local spellName = self:SpellName(375890) -- Magma Eruption
	self:Message(375890, "red", CL.duration:format(spellName, magmaEruptionDuration)) -- Magma Eruption for x sec
	self:PlaySound(375890, "alert")
	-- self:Bar(375890, magmaEruptionDuration, CL.on_group:format(spellName)) not really useful?
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

function mod:LavaSpray(args)
	lavaSprayCount = lavaSprayCount + 1
	-- boss takes too long (>1s) to target the player and there is no debuff, so we can't use TargetMessage
	-- if 375247 is ever unhidden that presumably would have the target at the right time to alert
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	if lavaSprayCount == 1 then
		self:CDBar(args.spellId, 22.7)
	else
		self:CDBar(args.spellId, 19.4)
	end
	-- soonest Volatile Mutation can happen after this is ~6.06s
	local volatileMutationBarText = CL.count:format(self:SpellName(374365), volatileMutationCount + 1) -- Volatile Mutation (n)
	if self:BarTimeLeft(volatileMutationBarText) < 6 then
		self:CDBar(374365, {6, 27.9}, volatileMutationBarText) -- Volatile Mutation
	end
end

function mod:BlazingCharge(args)
	self:TargetMessage(375439, "red", args.destName)
	self:PlaySound(375439, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(375439)
	end
	self:CDBar(375439, 23.0)
end

do
	local timer

	local function alertLavaEmpowerment(spellName)
		timer = nil
		mod:Message(391457, "purple", CL.onboss:format(spellName))
		mod:PlaySound(391457, "alert")
	end
	
	function mod:LavaEmpowermentApplied(args)
		-- allow 2 seconds of Magmatusk standing in lava before alerting
		timer = self:ScheduleTimer(alertLavaEmpowerment, 2, args.spellName)
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
