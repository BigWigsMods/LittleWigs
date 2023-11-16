--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lady Naz'jar", 643, 101)
if not mod then return end
mod:RegisterEnableMob(40586) -- Lady Naz'jar
mod:SetEncounterID(1045)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local highTideCount = 1
local nextShockBlast = 0
local shockBlastCD = 0
local nextGeysers = 0
local geysersCD = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Lady Naz'jar
		75683, -- High Tide
		{428054, "SAY"}, -- Shock Blast
		427771, -- Geysers
		428374, -- Focused Tempest
		{428263, "OFF"}, -- Water Bolt
		-- Naz'jar Honor Guard
		428293, -- Trident Flurry
	}, {
		[75683] = self.displayName,
		[428293] = -2183, -- Naz'jar Honor Guard
	}
end

function mod:OnBossEnable()
	-- Lady Naz'jar
	if self:Retail() then
		self:Log("SPELL_CAST_START", "HighTideStarting", 75683)
	end
	self:Log("SPELL_AURA_APPLIED", "HighTide", 75683)
	self:Log("SPELL_AURA_REMOVED", "HighTideOver", 75683)
	if self:Retail() then
		self:Log("SPELL_AURA_APPLIED", "ShockBlast", 429263)
		self:Log("SPELL_CAST_START", "Geysers", 427771)
		self:Log("SPELL_CAST_START", "FocusedTempest", 428374)
		self:Log("SPELL_CAST_START", "WaterBolt", 428263)

		-- Naz'jar Honor Guard
		self:Log("SPELL_CAST_START", "TridentFlurry", 428293)
		self:Death("NazjarHonorGuardDeath", 40633)
	end
end

function mod:OnEngage()
	local t = GetTime()
	self:SetStage(1)
	highTideCount = 1
	shockBlastCD = 18.0
	nextShockBlast = t + shockBlastCD
	geysersCD = 16.1
	nextGeysers = t + geysersCD
	self:CDBar(428374, 7.0) -- Focused Tempest
	self:CDBar(427771, geysersCD) -- Geysers
	self:CDBar(428054, shockBlastCD) -- Shock Blast
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			75683, -- Waterspout
		}
	end

	function mod:OnEngage()
		self:SetStage(1)
		highTideCount = 1
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Lady Naz'jar

function mod:HighTideStarting(args)
	self:StopBar(428374) -- Focused Tempest
	self:StopBar(427771) -- Geysers
	self:StopBar(428054) -- Shock Blast
end

function mod:HighTide(args)
	self:SetStage(2)
	local percent = highTideCount == 1 and 60 or 30
	self:Message(args.spellId, "cyan", CL.percent:format(percent, args.spellName))
	self:PlaySound(args.spellId, "long")
	highTideCount = highTideCount + 1
end

function mod:HighTideOver(args)
	self:SetStage(1)
	self:Message(args.spellId, "cyan", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	if self:Retail() then
		local t = GetTime()
		shockBlastCD = 24.3
		nextShockBlast = t + shockBlastCD
		geysersCD = 28.0
		nextGeysers = t + geysersCD
		self:CDBar(428374, 2.4) -- Focused Tempest
		self:CDBar(428054, shockBlastCD) -- Shock Blast
		self:CDBar(427771, geysersCD) -- Geysers
	end
end

function mod:ShockBlast(args)
	self:TargetMessage(428054, "red", args.destName)
	self:PlaySound(428054, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(428054)
	end
	local t = GetTime()
	shockBlastCD = 21.8
	nextShockBlast = t + shockBlastCD
	self:CDBar(428054, shockBlastCD)
end

function mod:Geysers(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	local t = GetTime()
	geysersCD = 23.0
	nextGeysers = t + geysersCD
	self:CDBar(args.spellId, geysersCD)
end

function mod:FocusedTempest(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17.0)
	-- 7.3s delay after this spell before anything else can be cast
	local t = GetTime()
	if nextShockBlast - t < 7.3 then
		self:CDBar(428054, {7.3, shockBlastCD}) -- Shock Blast
	end
	if nextGeysers - t < 7.3 then
		self:CDBar(427771, {7.3, geysersCD}) -- Geysers
	end
end

function mod:WaterBolt(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Naz'jar Honor Guard

function mod:TridentFlurry(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 11.9)
end

function mod:NazjarHonorGuardDeath(args)
	self:StopBar(428293) -- Trident Flurry
end
