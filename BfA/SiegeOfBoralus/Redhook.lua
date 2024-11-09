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

local bossCollector = {}
local callIrontideCount = 1
--local ordnanceRemaining = 0
local ordnanceCollector = {}
--local ordnanceExplosionTime = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L["274002_icon"] = "inv_misc_groupneedmore"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self:SetSpellRename(257459, CL.fixate) -- On the Hook (Fixate)
end

function mod:GetOptions()
	return {
		274002, -- Call Irontide
		257459, -- On the Hook
		{257348, "SAY"}, -- Meat Hook
		272662, -- Iron Hook
		257326, -- Gore Crash
		257585, -- Cannon Barrage
		273721, -- Heavy Ordnance
		-- Irontide Cleaver
		{257288, "NAMEPLATE"}, -- Heavy Slash
	}, {
		[274002] = "general",
		[257288] = -17725, -- Irontide Cleaver
	}, {
		[274002] = CL.adds, -- Call Irontide (Adds)
		[257459] = CL.fixate, -- On the Hook (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CallIrontide", 274002)
	self:Log("SPELL_AURA_APPLIED", "OnTheHookApplied", 257459)
	self:Log("SPELL_AURA_REMOVED", "OnTheHookRemoved", 257459)
	self:Log("SPELL_CAST_START", "MeatHook", 257348) -- non-Mythic only
	self:Log("SPELL_CAST_START", "IronHook", 272662) -- Mythic only
	self:Log("SPELL_CAST_START", "GoreCrash", 257326)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Cannon Barrage
	self:Log("SPELL_DAMAGE", "HeavyOrdnanceDamage", 273720, 280934) -- damage to player, damage to add
	self:Log("SPELL_MISSED", "HeavyOrdnanceDamage", 273720) -- missed player
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnanceApplied", 273721)

	-- Irontide Cleaver
	self:Log("SPELL_CAST_START", "HeavySlash", 257288)
	self:Death("IrontideCleaverDeath", 129879, 129996) -- initial spawn, boss summon
end

function mod:OnEngage()
	bossCollector = {}
	callIrontideCount = 1
	--ordnanceRemaining = 0
	ordnanceCollector = {}
	--ordnanceExplosionTime = 0
	self:CDBar(257585, 11.1) -- Cannon Barrage
	local _, guid = self:GetBossId(129879) -- Irontide Cleaver
	if guid then
		bossCollector[guid] = true
		self:Nameplate(257288, 6.2, guid) -- Heavy Slash
	end
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Siege of Boralus Trash", true)
	if trashMod then
		trashMod:Enable()
		trashMod:FirstBossDefeated()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	for i = 1, 5 do
		local guid = self:UnitGUID(("boss%d"):format(i))
		if guid and not bossCollector[guid] then
			bossCollector[guid] = true
			local mobId = self:MobId(guid)
			if mobId == 129879 then -- Irontide Cleaver (initial spawn)
				self:Nameplate(257288, 6.2, guid) -- Heavy Slash
			elseif mobId == 129996 then -- Irontide Cleaver (boss summon)
				self:Nameplate(257288, 3.6, guid) -- Heavy Slash
			end
		end
	end
end

function mod:CallIrontide(args)
	if callIrontideCount <= 3 then -- ignore any additional casts
		local percent
		if callIrontideCount == 1 then
			percent = 75
		elseif callIrontideCount == 2 then
			percent = 50
		else -- 3
			percent = 33
		end
		callIrontideCount = callIrontideCount + 1
		self:Message(args.spellId, "yellow", CL.percent:format(percent, CL.adds_spawning), L["274002_icon"])
		self:PlaySound(args.spellId, "long")
	end
end

function mod:OnTheHookApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate)
	self:TargetBar(args.spellId, 20, args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:OnTheHookRemoved(args)
	self:StopBar(CL.fixate, args.destName)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(257348, "red", name)
		if self:Me(guid) then
			self:Say(257348, nil, nil, "Meat Hook")
			self:PlaySound(257348, "alarm", nil, name)
		else
			self:PlaySound(257348, "alert", nil, name)
		end
	end

	function mod:MeatHook(args)
		-- this is cast when a Fixate channel finishes without the boss being stunned,
		-- or sometimes when the boss's stun fades.
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

function mod:IronHook(args)
	-- this is also cast by trash (Irontide Raider)
	if self:MobId(args.sourceGUID) == 128650 then -- Chopper Redhook
		-- this is cast when a Fixate channel finishes without the boss being stunned,
		-- or sometimes when the boss's stun fades.
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
	end
end

do
	local prev = 0
	function mod:GoreCrash(args)
		-- this ability always follows Meat Hook / Iron Hook
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 257540 then -- Cannon Barrage
		--ordnanceRemaining = 3 -- was 3, 3, 4, 6, 5, 7, 6, 3...
		ordnanceCollector = {}
		--ordnanceExplosionTime = GetTime() + 52.5
		self:Message(257585, "orange")
		self:CDBar(257585, 60.7)
		--self:Bar(273721, 52.5, CL.count:format(self:SpellName(273721), ordnanceRemaining)) -- Heavy Ordnance
		self:Bar(273721, 52.5) -- Heavy Ordnance
		self:PlaySound(257585, "alarm")
	end
end

do
	local prevSound = 0

	function mod:HeavyOrdnanceDamage(args)
		if not ordnanceCollector[args.sourceGUID] then
			--local ordnanceTimeLeft = ordnanceExplosionTime - GetTime()
			ordnanceCollector[args.sourceGUID] = true
			--self:StopBar(CL.count:format(args.spellName, ordnanceRemaining))
			--ordnanceRemaining = ordnanceRemaining - 1
			--if ordnanceRemaining > 0 and ordnanceTimeLeft > 0 then
				--self:Bar(273721, ordnanceTimeLeft, CL.count:format(args.spellName, ordnanceRemaining))
			--end
			--self:Message(273721, "orange", CL.extra:format(CL.on:format(args.spellName, args.destName), CL.remaining:format(ordnanceRemaining)))
			if self:Player(args.destFlags) then
				self:TargetMessage(273721, "orange", args.destName)
			else
				self:Message(273721, "orange", CL.on:format(args.spellName, args.destName))
			end
			if args.time - prevSound > 1.5 then
				prevSound = args.time
				self:PlaySound(273721, "info")
			end
		end
	end

	function mod:HeavyOrdnanceApplied(args)
		--local ordnanceTimeLeft = ordnanceExplosionTime - GetTime()
		--self:StopBar(CL.count:format(args.spellName, ordnanceRemaining))
		--ordnanceRemaining = ordnanceRemaining - 1
		--if ordnanceRemaining > 0 and ordnanceTimeLeft > 0 then
			--self:Bar(args.spellId, ordnanceTimeLeft, CL.count:format(args.spellName, ordnanceRemaining))
		--end
		--self:Message(args.spellId, "green", CL.extra:format(CL.onboss:format(args.spellName), CL.remaining:format(ordnanceRemaining)))
		self:Message(args.spellId, "green", CL.onboss:format(args.spellName))
		self:TargetBar(args.spellId, 10, CL.boss)
		if args.time - prevSound > 1.5 then
			prevSound = args.time
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Irontide Cleaver

do
	local prev = 0
	function mod:HeavySlash(args)
		local mobId = self:MobId(args.sourceGUID)
		if mobId == 129879 or mobId == 129996 then -- Irontide Cleaver (initial spawn), Irontide Cleaver (boss summon)
			self:Nameplate(args.spellId, 20.6, args.sourceGUID)
			if args.time - prev > 2 then
				prev = args.time
				self:Message(args.spellId, "purple")
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

function mod:IrontideCleaverDeath(args)
	self:ClearNameplate(args.destGUID)
end
