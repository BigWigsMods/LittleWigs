--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkheart Thicket Trash", 1466)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	95769,  -- Mindshattered Screecher
	95771,  -- Dreadsoul Ruiner
	101679, -- Dreadsoul Poisoner
	95766,  -- Crazed Razorbeak
	95779,  -- Festerhide Grizzly
	99360,  -- Vilethorn Blossom
	99358,  -- Rotheart Dryad
	99359,  -- Rotheart Keeper
	101991, -- Nightmare Dweller
	100531, -- Bloodtainted Fury
	113398, -- Bloodtainted Fury
	99366,  -- Taintheart Summoner
	100527, -- Dreadfire Imp
	100526  -- Tormented Bloodseeker
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!"

	L.mindshattered_screecher = "Mindshattered Screecher"
	L.dreadsoul_ruiner = "Dreadsoul Ruiner"
	L.dreadsoul_poisoner = "Dreadsoul Poisoner"
	L.crazed_razorbeak = "Crazed Razorbeak"
	L.festerhide_grizzly = "Festerhide Grizzly"
	L.vilethorn_blossom = "Vilethorn Blossom"
	L.rotheart_dryad = "Rotheart Dryad"
	L.rotheart_keeper = "Rotheart Keeper"
	L.nightmare_dweller = "Nightmare Dweller"
	L.bloodtainted_fury = "Bloodtainted Fury"
	L.bloodtainted_burster = "Bloodtainted Burster"
	L.taintheart_summoner = "Taintheart Summoner"
	L.dreadfire_imp = "Dreadfire Imp"
	L.tormented_bloodseeker = "Tormented Bloodseeker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Mindshattered Screecher
		200630, -- Unnerving Screech
		-- Dreadsoul Ruiner
		200658, -- Star Shower
		{200642, "DISPEL"}, -- Despair
		-- Dreadsoul Poisoner
		{200684, "SAY"}, -- Nightmare Toxin
		-- Crazed Razorbeak
		200768, -- Propelling Charge
		-- Festerhide Grizzly
		200580, -- Maddening Roar
		218759, -- Corruption Pool
		-- Vilethorn Blossom
		201129, -- Root Burst
		-- Rotheart Dryad
		{198904, "DISPEL"}, -- Poison Spear
		-- Rotheart Keeper
		198910, -- Vile Mushroom
		-- Nightmare Dweller
		204243, -- Tormenting Eye
		{204246, "DISPEL"}, -- Tormenting Fear
		-- Bloodtainted Fury
		201226, -- Blood Assault
		201272, -- Blood Bomb
		-- Bloodtainted Burster
		225562, -- Blood Metamorphosis
		-- Taintheart Summoner
		{201839, "SAY"}, -- Curse of Isolation
		-- Dreadfire Imp
		201399, -- Dread Inferno
		-- Tormented Bloodseeker
		{201365, "DISPEL"}, -- Darksoul Drain
	}, {
		[200630] = L.mindshattered_screecher,
		[200658] = L.dreadsoul_ruiner,
		[200684] = L.dreadsoul_poisoner,
		[200768] = L.crazed_razorbeak,
		[200580] = L.festerhide_grizzly,
		[201129] = L.vilethorn_blossom,
		[198904] = L.rotheart_dryad,
		[198910] = L.rotheart_keeper,
		[204243] = L.nightmare_dweller,
		[201226] = L.bloodtainted_fury,
		[225562] = L.bloodtainted_burster,
		[201839] = L.taintheart_summoner,
		[201399] = L.dreadfire_imp,
		[201365] = L.tormented_bloodseeker,
	}
end

function mod:OnBossEnable()
	-- Warmup
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Mindshattered Screecher
	self:Log("SPELL_CAST_START", "UnnervingScreech", 200630)

	-- Dreadsoul Ruiner
	self:Log("SPELL_CAST_START", "StarShower", 200658)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DespairApplied", 200642)

	-- Dreadsoul Poisoner
	self:Log("SPELL_AURA_APPLIED", "NightmareToxinApplied", 200684)

	-- Crazed Razorbeak
	self:Log("SPELL_CAST_START", "PropellingCharge", 200768)

	-- Festerhide Grizzly
	self:Log("SPELL_CAST_START", "MaddeningRoar", 200580)
	self:Log("SPELL_AURA_APPLIED", "CorruptionPool", 218759)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorruptionPool", 218759)
	self:Log("SPELL_PERIODIC_MISSED", "CorruptionPool", 218759)

	-- Vilethorn Blossom
	self:Log("SPELL_CAST_SUCCESS", "RootBurst", 201129)

	-- Rotheart Dryad
	self:Log("SPELL_AURA_APPLIED", "PoisonSpear", 198904)

	-- Rotheart Keeper
	self:Log("SPELL_SUMMON", "VileMushroom", 198910)

	-- Nightmare Dweller
	self:Log("SPELL_AURA_APPLIED", "TormentingEye", 204243)
	self:Log("SPELL_AURA_APPLIED", "TormentingFear", 204246)

	-- Bloodtainted Fury
	self:Log("SPELL_CAST_START", "BloodAssault", 201226)
	self:Log("SPELL_CAST_SUCCESS", "BloodBomb", 201272)

	-- Bloodtainted Burster
	self:Log("SPELL_CAST_START", "BloodMetamorphosis", 225562)

	-- Taintheart Summoner
	self:Log("SPELL_AURA_APPLIED", "CurseOfIsolation", 201839)

	-- Dreadfire Imp
	self:Log("SPELL_CAST_START", "DreadInferno", 201399)

	-- Tormented Bloodseeker
	self:Log("SPELL_AURA_APPLIED", "DarksoulDrain", 201365)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg == L.archdruid_glaidalis_warmup_trigger then
		-- Archdruid Glaidalis Warmup
		local archdruidGlaidalisModule = BigWigs:GetBossModule("Archdruid Glaidalis", true)
		if archdruidGlaidalisModule then
			archdruidGlaidalisModule:Enable()
			archdruidGlaidalisModule:Warmup()
		end
		self:UnregisterEvent(event)
	end
end

-- Mindshattered Screecher

do
	local prev = 0
	function mod:UnnervingScreech(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Dreadsoul Ruiner

do
	local prev = 0
	function mod:StarShower(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:DespairApplied(args)
		local t = args.time
		local amount = args.amount
		-- 10% heal reduction per stack in M+ (2% otherwise)
		-- alert at 3, increase severity at 6 and up
		if self:MythicPlus() and t - prev > 2 and (amount == 3 or amount >= 6)
				and (self:Me(args.destGUID) or (self:Player(args.destFlags) and self:Dispeller("magic", nil, args.spellId))) then
			prev = t
			self:StackMessage(args.spellId, "yellow", args.destName, amount, 6)
			if amount >= 6 then
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			else
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

-- Dreadsoul Poisoner

function mod:NightmareToxinApplied(args)
	if not self:Player(args.destFlags) then -- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
		return
	end
	if self:Me(args.destGUID) and self:MythicPlus() then -- avoid spamming in trivial difficulties
		self:Say(args.spellId, nil, nil, "Nightmare Toxin")
	end
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

-- Crazed Razorbeak

do
	local prev = 0
	function mod:PropellingCharge(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Festerhide Grizzly

do
	local prev = 0
	function mod:MaddeningRoar(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:CorruptionPool(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", nil, args.destName)
			end
		end
	end
end

-- Vilethorn Blossom

do
	local prev = 0
	function mod:RootBurst(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Rotheart Dryad

function mod:PoisonSpear(args)
	-- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
	if self:Player(args.destFlags) and self:Dispeller("poison", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Rotheart Keeper

do
	local prev = 0
	function mod:VileMushroom(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Nightmare Dweller

do
	local prev = 0
	function mod:TormentingEye(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:TormentingFear(args)
	if self:Dispeller("magic", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

-- Bloodtainted Fury

function mod:BloodAssault(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:BloodBomb(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

-- Bloodtainted Burster

do
	local prev = 0
	function mod:BloodMetamorphosis(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Taintheart Summoner

function mod:CurseOfIsolation(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Curse of Isolation")
	end
end

-- Dreadfire Imp

do
	local prev = 0
	function mod:DreadInferno(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Tormented Bloodseeker

do
	local prev = 0
	function mod:DarksoulDrain(args)
		-- this can apply to pets, to hostile NPCs by a mind-controlled Tormented Bloodseeker,
		-- and can be applied by multiple mobs on the same player
		local t = args.time
		if t - prev > 2 and self:Player(args.destFlags) and self:Dispeller("disease", nil, args.spellId) then
			prev = t
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end
