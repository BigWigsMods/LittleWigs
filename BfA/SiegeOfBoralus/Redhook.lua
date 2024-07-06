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

local bombsRemaining = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds = 274002 -- Call Adds
	L.adds_icon = "inv_misc_groupneedmore"
	L.remaining = "%s on %s, %d remaining"
	L.remaining_boss = "%s on BOSS, %d remaining"
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
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4", "boss5")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "OnTheHookApplied", 257459)
	self:Log("SPELL_AURA_REMOVED", "OnTheHookRemoved", 257459)
	self:Log("SPELL_CAST_START", "MeatHook", 257348)
	self:Log("SPELL_CAST_START", "GoreCrash", 257326)
	self:Log("SPELL_DAMAGE", "HeavyOrdnanceDamage", 273720, 280934) -- Damage to player, damage to add
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnanceApplied", 273721)
end

function mod:OnEngage()
	bombsRemaining = 0
	self:CDBar(257585, 11) -- Cannon Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_START(_, unit, _, spellId)
	if spellId == 257288 and self:MobId(self:UnitGUID(unit)) == 129879 then -- Heavy Slash, Irontide Cleaver
		self:Message(spellId, "purple")
		self:PlaySound(spellId, "alert")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 257540 then -- Cannon Barrage
		bombsRemaining = 3
		self:Message(257585, "orange")
		self:PlaySound(257585, "warning")
		self:CDBar(257585, 60.7)
		self:Bar(273721, 43, CL.count:format(self:SpellName(273721), bombsRemaining)) -- Heavy Ordnance
	elseif spellId == 274002 then -- Call Adds
		if self:GetHealth(unit) > 33 then -- Spams every second under 33% but doesn't actually spawn adds
			self:Message("adds", "yellow", CL.incoming:format(CL.adds), false)
			self:PlaySound("adds", "long")
		end
	end
end

function mod:OnTheHookApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 20, args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:OnTheHookRemoved(args)
	self:StopBar(args.spellId, args.destName)
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
	end
end

function mod:GoreCrash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:HeavyOrdnanceDamage(args)
		local t = args.time
		if t ~= prev then
			prev = t
			local barText = CL.count:format(args.spellName, bombsRemaining)
			bombsRemaining = bombsRemaining - 1
			local timer = self:BarTimeLeft(barText)
			self:StopBar(barText)
			if bombsRemaining > 0 then
				self:Bar(273721, timer, CL.count:format(args.spellName, bombsRemaining))
			end
			self:Message(273721, "orange", L.remaining:format(args.spellName, args.destName, bombsRemaining))
			self:PlaySound(273721, "info")
		end
	end
end

function mod:HeavyOrdnanceApplied(args)
	local barText = CL.count:format(args.spellName, bombsRemaining)
	bombsRemaining = bombsRemaining - 1
	local timer = self:BarTimeLeft(barText)
	self:StopBar(barText)
	if bombsRemaining > 0 then
		self:Bar(args.spellId, timer, CL.count:format(args.spellName, bombsRemaining))
	end
	self:Message(args.spellId, "green", L.remaining_boss:format(args.spellName, bombsRemaining))
	self:PlaySound(args.spellId, "alert")
	-- 10s TWW, 6s live
	if BigWigsLoader.isBeta then
		self:TargetBar(args.spellId, 10, CL.boss)
	else
		self:TargetBar(args.spellId, 6, CL.boss)
	end
end
