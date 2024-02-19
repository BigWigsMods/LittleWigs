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
local focusedTempestCount = 1
local nextShockBlast = 0
local shockBlastCD = 0
local nextGeysers = 0
local geysersCD = 0
local nextFocusedTempest = 0
local focusedTempestCD = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.high_tide_trigger1 = "Take arms, minions! Rise from the icy depths!"
	L.high_tide_trigger2 = "Destroy these intruders! Leave them for the great dark beyond!"
end

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
		self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
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
	focusedTempestCount = 1
	focusedTempestCD = 7.0
	nextFocusedTempest = t + focusedTempestCD
	shockBlastCD = 18.0
	nextShockBlast = t + shockBlastCD
	geysersCD = 16.1
	nextGeysers = t + geysersCD
	self:CDBar(428374, focusedTempestCD, CL.count:format(self:SpellName(428374), focusedTempestCount)) -- Focused Tempest
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

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.high_tide_trigger1 or msg == L.high_tide_trigger2 then
		-- we can clean up the bars a bit early based on the yells
		self:HighTideStarting()
	end
end

function mod:HighTideStarting()
	self:StopBar(CL.count:format(self:SpellName(428374), focusedTempestCount)) -- Focused Tempest
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
		focusedTempestCD = 2.4
		nextFocusedTempest = t + focusedTempestCD
		shockBlastCD = 24.3
		nextShockBlast = t + shockBlastCD
		geysersCD = 28.0
		nextGeysers = t + geysersCD
		self:CDBar(428374, focusedTempestCD, CL.count:format(self:SpellName(428374), focusedTempestCount)) -- Focused Tempest
		self:CDBar(428054, shockBlastCD) -- Shock Blast
		self:CDBar(427771, geysersCD) -- Geysers
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(428054, "red", name)
		self:PlaySound(428054, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(428054, nil, nil, "Shock Blast")
		end
	end

	function mod:ShockBlast(args)
		local t = GetTime()
		-- this debuff is sometimes applied to the tank instead of the targeted player,
		-- so we have to revert back to target scanning to get the real target. if this
		-- is ever fixed we can just check who gets the debuff instead.
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		shockBlastCD = 21.8
		nextShockBlast = t + shockBlastCD
		self:CDBar(428054, shockBlastCD)
		-- 3.67s delay after this spell before anything else can be cast
		if nextGeysers - t < 3.67 then
			nextGeysers = t + 3.67
			self:CDBar(427771, {3.67, geysersCD}) -- Geysers
		end
		if nextFocusedTempest - t < 3.67 then
			nextFocusedTempest = t + 3.67
			if focusedTempestCD < 3.67 then
				focusedTempestCD = 3.67
			end
			self:CDBar(428374, {3.67, focusedTempestCD}, CL.count:format(self:SpellName(428374), focusedTempestCount)) -- Focused Tempest
		end
	end
end

function mod:Geysers(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	geysersCD = 23.0
	nextGeysers = t + geysersCD
	self:CDBar(args.spellId, geysersCD)
	-- 3.67s delay after this spell before anything else can be cast
	if nextShockBlast - t < 3.67 then
		nextShockBlast = t + 3.67
		self:CDBar(428054, {3.67, shockBlastCD}) -- Shock Blast
	end
	if nextFocusedTempest - t < 3.67 then
		nextFocusedTempest = t + 3.67
		if focusedTempestCD < 3.67 then
			focusedTempestCD = 3.67
		end
		self:CDBar(428374, {3.67, focusedTempestCD}, CL.count:format(self:SpellName(428374), focusedTempestCount)) -- Focused Tempest
	end
end

function mod:FocusedTempest(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, focusedTempestCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, focusedTempestCount))
	self:PlaySound(args.spellId, "alert")
	focusedTempestCount = focusedTempestCount + 1
	focusedTempestCD = 17.0
	nextFocusedTempest = t + focusedTempestCD
	self:CDBar(args.spellId, focusedTempestCD, CL.count:format(args.spellName, focusedTempestCount))
	-- 7.3s delay after this spell before anything else can be cast
	if nextShockBlast - t < 7.3 then
		nextShockBlast = t + 7.3
		self:CDBar(428054, {7.3, shockBlastCD}) -- Shock Blast
	end
	if nextGeysers - t < 7.3 then
		nextGeysers = t + 7.3
		self:CDBar(427771, {7.3, geysersCD}) -- Geysers
	end
end

function mod:WaterBolt(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert")
	end
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
