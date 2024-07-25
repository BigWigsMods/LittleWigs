--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chopper Redhook", 1822, 2132)
if not mod then return end
mod:RegisterEnableMob(128650) -- Chopper Redhook
mod:SetEncounterID(2098)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local callAddsCount = 1
local ordnanceRemaining = 0
local ordnanceCollector = {}
local ordnanceExplosionTime = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds = 274002 -- Call Adds
	L.adds_icon = "inv_misc_groupneedmore"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"adds",
		257459, -- On the Hook
		{257348, "SAY"}, -- Meat Hook
		257326, -- Gore Crash
		257585, -- Cannon Barrage
		273721, -- Heavy Ordnance
		257288, -- Heavy Slash
	}, {
		["adds"] = "general",
		[257288] = -17725, -- Irontide Cleaver
	}, {
		[257459] = CL.fixate, -- On the Hook (Fixate)
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4", "boss5")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "OnTheHookApplied", 257459)
	self:Log("SPELL_AURA_REMOVED", "OnTheHookRemoved", 257459)
	self:Log("SPELL_CAST_START", "MeatHook", 257348)
	self:Log("SPELL_CAST_START", "GoreCrash", 257326)
	self:Log("SPELL_DAMAGE", "HeavyOrdnanceDamage", 273720, 280934) -- damage to player, damage to add
	self:Log("SPELL_MISSED", "HeavyOrdnanceDamage", 273720) -- missed player
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnanceApplied", 273721)
end

function mod:OnEngage()
	callAddsCount = 1
	ordnanceRemaining = 0
	ordnanceCollector = {}
	ordnanceExplosionTime = 0
	self:CDBar(257585, 11.1) -- Cannon Barrage
	--self:CDBar(257348, 21.0) -- Meat Hook
	--self:CDBar(257326, 24.8) -- Gore Crash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_START(_, unit, _, spellId)
	if spellId == 257288 then -- Heavy Slash
		local mobId = self:MobId(self:UnitGUID(unit))
		if mobId == 129879 or mobId == 129996 then -- Irontide Cleaver (initial spawn), Irontide Cleaver (boss summon)
			self:Message(spellId, "purple")
			self:PlaySound(spellId, "alarm")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 257540 then -- Cannon Barrage
		ordnanceRemaining = 3
		ordnanceCollector = {}
		self:Message(257585, "orange")
		self:PlaySound(257585, "warning")
		self:CDBar(257585, 60.7)
		ordnanceExplosionTime = GetTime() + 52.5
		self:Bar(273721, 52.5, CL.count:format(self:SpellName(273721), ordnanceRemaining)) -- Heavy Ordnance
	elseif spellId == 274002 then -- Call Adds
		if callAddsCount <= 3 then -- ignore any additional casts
			local percent
			if callAddsCount == 1 then
				percent = 75
			elseif callAddsCount == 2 then
				percent = 50
			else -- 3
				percent = 33
			end
			self:Message("adds", "yellow", CL.percent:format(percent, CL.incoming:format(CL.adds)), L.adds_icon)
			self:PlaySound("adds", "long")
			callAddsCount = callAddsCount + 1
		end
	end
end

function mod:OnTheHookApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate)
	self:TargetBar(args.spellId, 20, args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:OnTheHookRemoved(args)
	self:StopBar(CL.fixate, args.destName)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(257348, "red", name)
		self:PlaySound(257348, "alert", nil, name)
		if self:Me(guid) then
			self:Say(257348, nil, nil, "Meat Hook")
		end
	end

	function mod:MeatHook(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		--self:CDBar(args.spellId, 27.0)
	end
end

function mod:GoreCrash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:CDBar(args.spellId, 27.0)
end

function mod:HeavyOrdnanceDamage(args)
	if not ordnanceCollector[args.sourceGUID] then
		local ordnanceTimeLeft = ordnanceExplosionTime - GetTime()
		ordnanceCollector[args.sourceGUID] = true
		self:StopBar(CL.count:format(args.spellName, ordnanceRemaining))
		ordnanceRemaining = ordnanceRemaining - 1
		if ordnanceRemaining > 0 and ordnanceTimeLeft > 0 then
			self:Bar(273721, ordnanceTimeLeft, CL.count:format(args.spellName, ordnanceRemaining))
		end
		self:Message(273721, "orange", CL.extra:format(CL.on:format(args.spellName, args.destName), CL.remaining:format(ordnanceRemaining)))
		self:PlaySound(273721, "info")
	end
end

function mod:HeavyOrdnanceApplied(args)
	local ordnanceTimeLeft = ordnanceExplosionTime - GetTime()
	self:StopBar(CL.count:format(args.spellName, ordnanceRemaining))
	ordnanceRemaining = ordnanceRemaining - 1
	if ordnanceRemaining > 0 and ordnanceTimeLeft > 0 then
		self:Bar(args.spellId, ordnanceTimeLeft, CL.count:format(args.spellName, ordnanceRemaining))
	end
	self:Message(args.spellId, "green", CL.extra:format(CL.onboss:format(args.spellName), CL.remaining:format(ordnanceRemaining)))
	self:PlaySound(args.spellId, "info")
	self:TargetBar(args.spellId, 10, CL.boss)
end
