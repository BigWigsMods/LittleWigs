--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkflame Cleft Trash", 2651)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	211121, -- Rank Overseer
	210818, -- Lowly Moleherd
	210812, -- Royal Wicklighter
	212383, -- Kobold Taskworker
	208450, -- Wandering Candle
	220815, -- Blazing Fiend (before Blazikon room)
	211228, -- Blazing Fiend (in Blazikon room)
	223770, -- Blazing Fiend (in Blazikon room)
	223772, -- Blazing Fiend (in Blazikon room)
	223773, -- Blazing Fiend (in Blazikon room)
	223774, -- Blazing Fiend (in Blazikon room)
	223775, -- Blazing Fiend (in Blazikon room)
	223776, -- Blazing Fiend (in Blazikon room)
	223777, -- Blazing Fiend (in Blazikon room)
	212412, -- Sootsnout
	212411, -- Torchsnarl
	208457, -- Skittering Darkness
	208456, -- Shuffling Horror
	218475, -- Skitter
	209439, -- Creaky Mine Cart
	212129 -- Creaky Mine Cart
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rank_overseer = "Rank Overseer"
	L.lowly_moleherd = "Lowly Moleherd"
	L.royal_wicklighter = "Royal Wicklighter"
	L.kobold_taskworker = "Kobold Taskworker"
	L.wandering_candle = "Wandering Candle"
	L.blazing_fiend = "Blazing Fiend"
	L.sootsnout = "Sootsnout"
	L.torchsnarl = "Torchsnarl"
	L.skittering_darkness = "Skittering Darkness"
	L.shuffling_horror = "Shuffling Horror"
	L.creaky_mine_cart = "Creaky Mine Cart"

	L.minecart = "Mine Cart Minigame"
	L.minecart_desc = 423374 -- Throw Dynamite
	L.minecart_icon = 423374 -- Throw Dynamite
	L.hits = "Hits"
	L.minecart_over = "Winner: %s (%d hits)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Rank Overseer
		{423501, "NAMEPLATE"}, -- Wild Wallop
		{428066, "NAMEPLATE"}, -- Overpowering Roar
		-- Lowly Moleherd
		{425536, "NAMEPLATE"}, -- Mole Frenzy
		-- Royal Wicklighter
		{428019, "DISPEL", "NAMEPLATE"}, -- Flashpoint
		-- Kobold Taskworker
		{426883, "NAMEPLATE"}, -- Bonk!
		-- Wandering Candle
		{440652, "NAMEPLATE"}, -- Surging Wax
		{430171, "NAMEPLATE"}, -- Quenching Blast
		{428650, "DISPEL"}, -- Burning Backlash
		-- Blazing Fiend
		{424322, "NAMEPLATE"}, -- Explosive Flame
		-- Sootsnout
		426261, -- Ceaseless Flame
		{426295, "NAMEPLATE"}, -- Flaming Tether
		-- Torchsnarl
		{426619, "SAY", "DISPEL", "NAMEPLATE"}, -- One-Hand Headlock
		426260, -- Pyro-pummel
		-- Skittering Darkness
		422393, -- Suffocating Darkness
		-- Shuffling Horror
		{422414, "NAMEPLATE"}, -- Shadow Smash
		422541, -- Drain Light
		-- Creaky Mine Cart
		{"minecart", "INFOBOX"},
	}, {
		[423501] = L.rank_overseer,
		[425536] = L.lowly_moleherd,
		[428019] = L.royal_wicklighter,
		[426883] = L.kobold_taskworker,
		[440652] = L.wandering_candle,
		[424322] = L.blazing_fiend,
		[426261] = L.sootsnout,
		[426619] = L.torchsnarl,
		[422393] = L.skittering_darkness,
		[422414] = L.shuffling_horror,
		["minecart"] = L.creaky_mine_cart,
	}
end

function mod:OnBossEnable()
	-- Rank Overseer
	self:RegisterEngageMob("RankOverseerEngaged", 211121)
	self:Log("SPELL_CAST_START", "WildWallop", 423501)
	self:Log("SPELL_CAST_START", "OverpoweringRoar", 428066)
	self:Death("RankOverseerDeath", 211121)

	-- Lowly Moleherd
	self:RegisterEngageMob("LowlyMoleherdEngaged", 210818)
	self:Log("SPELL_CAST_START", "MoleFrenzy", 425536)
	self:Log("SPELL_INTERRUPT", "MoleFrenzyInterrupt", 425536)
	self:Log("SPELL_CAST_SUCCESS", "MoleFrenzySuccess", 425536)
	self:Death("LowlyMoleherdDeath", 210818)

	-- Royal Wicklighter
	self:RegisterEngageMob("RoyalWicklighterEngaged", 210812)
	self:Log("SPELL_CAST_START", "Flashpoint", 428019)
	self:Log("SPELL_CAST_SUCCESS", "FlashpointSuccess", 428019)
	self:Log("SPELL_AURA_APPLIED", "FlashpointApplied", 428019)
	self:Death("RoyalWicklighterDeath", 210812)

	-- Kobold Taskworker
	self:RegisterEngageMob("KoboldTaskworkerEngaged", 212383)
	self:Log("SPELL_CAST_START", "Bonk", 426883)
	self:Log("SPELL_CAST_SUCCESS", "BonkSuccess", 426883)
	self:Death("KoboldTaskworkerDeath", 212383)

	-- Wandering Candle
	self:RegisterEngageMob("WanderingCandleEngaged", 208450)
	self:Log("SPELL_CAST_START", "SurgingWax", 440652)
	self:Log("SPELL_PERIODIC_DAMAGE", "SurgingWaxDamage", 440653)
	self:Log("SPELL_PERIODIC_MISSED", "SurgingWaxDamage", 440653)
	self:Log("SPELL_CAST_START", "QuenchingBlast", 430171)
	self:Log("SPELL_AURA_APPLIED", "BurningBacklashApplied", 428650)
	self:Death("WanderingCandleDeath", 208450)

	-- Blazing Fiend
	self:RegisterEngageMob("BlazingFiendEngaged", 220815, 211228, 223770, 223772, 223773, 223774, 223775, 223776, 223777)
	self:Log("SPELL_CAST_START", "ExplosiveFlame", 424322)
	self:Log("SPELL_INTERRUPT", "ExplosiveFlameInterrupt", 424322)
	self:Log("SPELL_CAST_SUCCESS", "ExplosiveFlameSuccess", 424322)
	self:Death("BlazingFiendDeath", 220815, 211228, 223770, 223772, 223773, 223774, 223775, 223776, 223777)

	-- Sootsnout
	self:RegisterEngageMob("SootsnoutEngaged", 212412)
	self:Log("SPELL_CAST_START", "CeaselessFlame", 426261)
	self:Log("SPELL_CAST_START", "FlamingTether", 426295)
	self:Death("SootsnoutDeath", 212412)

	-- Torchsnarl
	self:RegisterEngageMob("TorchsnarlEngaged", 212411)
	self:Log("SPELL_CAST_START", "OneHandHeadlock", 426619)
	self:Log("SPELL_AURA_APPLIED", "OneHandHeadlockApplied", 426277)
	self:Log("SPELL_CAST_START", "Pyropummel", 426260)
	self:Death("TorchsnarlDeath", 212411)

	-- Skittering Darkness
	self:Log("SPELL_CAST_START", "SuffocatingDarkness", 422393)

	-- Shuffling Horror
	self:RegisterEngageMob("ShufflingHorrorEngaged", 208456)
	self:Log("SPELL_CAST_START", "ShadowSmash", 422414)
	self:Log("SPELL_CAST_SUCCESS", "ShadowSmashSuccess", 422414)
	self:Log("SPELL_CAST_START", "DrainLight", 422541)
	self:Death("ShufflingHorrorDeath", 208456)

	-- Creaky Mine Cart
	self:Log("SPELL_CAST_SUCCESS", "ShadowyCloak", 423566) -- start event
	self:Log("SPELL_AURA_APPLIED", "Ouch", 423654) -- end event
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Rank Overseer

function mod:RankOverseerEngaged(guid)
	self:Nameplate(423501, 5.1, guid) -- Wild Wallop
	self:Nameplate(428066, 14.9, guid) -- Overpowering Roar
end

do
	local prev = 0
	function mod:WildWallop(args)
		self:Nameplate(args.spellId, 13.4, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:OverpoweringRoar(args)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:RankOverseerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Lowly Moleherd

function mod:LowlyMoleherdEngaged(guid)
	self:Nameplate(425536, 5.8, guid) -- Mole Frenzy
end

do
	local prev = 0
	function mod:MoleFrenzy(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:MoleFrenzyInterrupt(args)
	self:Nameplate(425536, 45.4, args.destGUID)
end

function mod:MoleFrenzySuccess(args)
	self:Nameplate(args.spellId, 45.4, args.sourceGUID)
end

function mod:LowlyMoleherdDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Royal Wicklighter

function mod:RoyalWicklighterEngaged(guid)
	self:Nameplate(428019, 5.7, guid) -- Flashpoint
end

function mod:Flashpoint(args)
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:FlashpointSuccess(args)
	self:Nameplate(args.spellId, 10.8, args.sourceGUID)
end

do
	local playerList = {}
	local prev = 0
	function mod:FlashpointApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
			local t = args.time
			if t - prev > .5 then -- throttle alerts to .5s intervals
				prev = t
				playerList = {}
			end
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "red", playerList, 5, nil, nil, .5)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end

function mod:RoyalWicklighterDeath(args)
end

-- Kobold Taskworker

function mod:KoboldTaskworkerEngaged(guid)
	self:Nameplate(426883, 8.4, guid) -- Bonk!
end

function mod:Bonk(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:BonkSuccess(args)
	self:Nameplate(args.spellId, 17.4, args.sourceGUID)
end

function mod:KoboldTaskworkerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Wandering Candle

function mod:WanderingCandleEngaged(guid)
	self:Nameplate(430171, 8.0, guid) -- Quenching Blast
	self:Nameplate(440652, 16.4, guid) -- Surging Wax
end

function mod:SurgingWax(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 21.9, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:SurgingWaxDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(440652, "underyou")
			self:PlaySound(440652, "underyou")
		end
	end
end

function mod:QuenchingBlast(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 13.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:BurningBacklashApplied(args)
		if self:Me(args.destGUID) or (self:Dispeller("magic", nil, args.spellId) and self:Player(args.destFlags)) then
			self:TargetMessage(args.spellId, "red", args.destName)
			local t = args.time
			if t - prev > 1.5 then -- throttle sound in the unlikely event that more than one player is affected
				prev = t
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			end
		end
	end
end

function mod:WanderingCandleDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Blazing Fiend

function mod:BlazingFiendEngaged(guid)
	self:Nameplate(424322, 6.7, guid) -- Explosive Flame
end

function mod:ExplosiveFlame(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:ExplosiveFlameInterrupt(args)
	self:Nameplate(424322, 21.3, args.destGUID)
end

function mod:ExplosiveFlameSuccess(args)
	self:Nameplate(args.spellId, 21.3, args.sourceGUID)
end

function mod:BlazingFiendDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sootsnout

do
	local timer

	function mod:SootsnoutEngaged(guid)
		self:CDBar(426295, 19.1) -- Flaming Tether
		self:Nameplate(426295, 19.1, guid) -- Flaming Tether
		timer = self:ScheduleTimer("SootsnoutDeath", 40)
	end

	function mod:CeaselessFlame(args)
		if timer then
			self:CancelTimer(timer)
		end
		-- this is only cast if the tank is grabbed by One-Hand Headlock or if Torchsnarl is dead
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("SootsnoutDeath", 40)
	end

	function mod:FlamingTether(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 38.9)
		self:Nameplate(args.spellId, 38.9, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("SootsnoutDeath", 40)
	end

	function mod:SootsnoutDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(426295) -- Flaming Tether
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Torchsnarl

do
	local timer

	function mod:TorchsnarlEngaged(guid)
		self:CDBar(426619, 0.9) -- One-Hand Headlock
		self:Nameplate(426619, 0.9, guid) -- One-Hand Headlock
		timer = self:ScheduleTimer("TorchsnarlDeath", 45)
	end

	do
		local function printTarget(self, name, guid)
			self:TargetMessage(426619, "red", name, CL.casting:format(self:SpellName(426619)))
			if self:Me(guid) then
				self:Say(426619, nil, nil, "One-Hand Headlock")
			end
			self:PlaySound(426619, "alarm", nil, name)
		end

		function mod:OneHandHeadlock(args)
			if timer then
				self:CancelTimer(timer)
			end
			self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
			self:CDBar(args.spellId, 36.4)
			self:Nameplate(args.spellId, 36.4, args.sourceGUID)
			timer = self:ScheduleTimer("TorchsnarlDeath", 45)
		end
	end

	function mod:OneHandHeadlockApplied(args)
		if self:Dispeller("movement", nil, 426619) then
			self:TargetMessage(426619, "yellow", args.destName)
			self:PlaySound(426619, "info", nil, args.destName)
		end
	end

	function mod:Pyropummel(args)
		if timer then
			self:CancelTimer(timer)
		end
		-- this is only cast if someone is rooted by Flaming Tether or if Sootsnout is dead
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("TorchsnarlDeath", 45)
	end

	function mod:TorchsnarlDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(426619) -- One-Hand Headlock
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Skittering Darkness

do
	local prev = 0
	function mod:SuffocatingDarkness(args)
		local t = args.time
		if t - prev > 3.5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Shuffling Horror

function mod:ShufflingHorrorEngaged(guid)
	self:Nameplate(422414, 12.0, guid) -- Shadow Smash
end

function mod:ShadowSmash(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ShadowSmashSuccess(args)
	self:Nameplate(args.spellId, 12.0, args.sourceGUID)
end

function mod:DrainLight(args)
	-- just cast once
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:ShufflingHorrorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Creaky Mine Cart

do
	local playerHits = {}

	function mod:ShadowyCloak() -- start event
		playerHits = {}
		self:Log("SPELL_DAMAGE", "ThrowDynamite", 423384)
		self:Bar("minecart", 38.3, L.minecart_icon, L.minecart_icon)
		self:Message("minecart", "cyan", L.minecart_icon, L.minecart_icon)
		self:PlaySound("minecart", "long")
	end

	function mod:ThrowDynamite(args) -- scored a hit
		if not next(playerHits) then
			self:OpenInfo("minecart", L.hits)
		end
		local hits = playerHits[args.sourceName]
		if not hits then
			playerHits[args.sourceName] = 1
		else
			playerHits[args.sourceName] = hits + 1
		end
		self:SetInfoByTable("minecart", playerHits)
	end

	function mod:Ouch(args) -- end event
		if self:MobId(args.destGUID) == 218475 then -- Skitter
			self:StopBar(L.minecart_icon)
			self:RemoveLog("SPELL_DAMAGE", 423384)
			local winnerList
			local winnerCount = 0
			local score = 0
			for playerName, hits in next, playerHits do
				if hits > score then
					score = hits
					winnerCount = 1
					winnerList = { self:ColorName(playerName) }
				elseif hits == score then -- there's a tie
					winnerCount = winnerCount + 1
					winnerList[winnerCount] = self:ColorName(playerName)
				end
			end
			if winnerList and score > 0 then
				self:Message("minecart", "green", L.minecart_over:format(self:TableToString(winnerList, winnerCount), score), L.minecart_icon, nil, 5) -- display message for 5s
				self:PlaySound("minecart", "info")
				-- close infobox after 10 seconds
				self:SimpleTimer(function() self:CloseInfo("minecart") end, 10)
			end
		end
	end
end
