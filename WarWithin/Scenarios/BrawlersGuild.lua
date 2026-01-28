--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brawler's Guild", UnitFactionGroup("player") == "Horde" and 1043 or 369)
if not mod then return end
mod:RegisterEnableMob(
	67267, -- Brawl'gar Arena Grunt
	68408, -- Bizmo's Brawlpub Bouncer
	252778, -- Sunny
	117145, -- Doomflipper
	68257, -- Goredome
	68255, -- Dippy
	67262, -- Bruce
	117077, -- Bill the Janitor
	117753, -- Oso
	209227, -- The Quacken
	71085, -- Razorgrin
	67594, -- Blat
	67595, -- Blat (summoned)
	117133, -- Ooliss
	68254, -- King Kulaka
	67573, -- Meatball
	116855, -- Ash'katzuum
	67540, -- Crush
	252597, -- Glorp
	119150, -- Klunk
	117275, -- Stitches
	116539, -- Topps
	115233, -- Carl
	67511, -- Queasy
	67513, -- Sleazy
	67514, -- Greazy
	67515, -- Fleasy
	67516, -- Wheezy
	71081, -- Mecha-Bruce
	67487, -- Bo Bobble
	67488, -- Max Megablast
	70647, -- Dippy
	70648, -- Doopy
	252721, -- Renegade Swabbie
	114955, -- Dole Dastardly
	114951, -- Hudson
	114941, -- Stuffshrew
	70740, -- Blingtron 3000
	67490 -- Epicus Maximus
)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local brawling = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.brawlers_guild = "Brawler's Guild"
	L.rank = "Rank %d"
	L.defeated = "%s defeated"

	L.sunny = "Sunny"
	L.doomflipper = "Doomflipper"
	L.goredome = "Goredome"
	L.dippy = "Dippy"
	L.bruce = "Bruce"
	L.bill_the_janitor = "Bill the Janitor"
	L.oso = "Oso"
	L.the_quacken = "The Quacken"
	L.razorgrin = "Razorgrin"
	L.blat = "Blat"
	L.ooliss = "Ooliss"
	L.king_kulaka = "King Kulaka"
	L.meatball = "Meatball"
	L.ash_katzuum = "Ash'katzuum"
	L.crush = "Crush"
	L.glorp = "Glorp"
	L.klunk = "Klunk"
	L.stitches = "Stitches"
	L.topps = "Topps"
	L.carl = "Carl"
	L.leper_gnome_quintet = "Leper Gnome Quintet"
	L.mecha_bruce = "Mecha-Bruce"
	L.gg_engineering = "GG Engineering"
	L.doopy = "Doopy"
	L.renegade_swabbie = "Renegade Swabbie"
	L.ogrewatch = "Ogrewatch"
	L.blingtron_3000 = "Blingtron 3000"
	L.epicus_maximus = "Epicus Maximus"

	L["133359_icon"] = "spell_fire_immolation" -- Enraging Flames
	L["133359_desc"] = 134545 -- Enraging Flames
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.brawlers_guild
end

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Enrage
		133359, -- Enraging Flames
		---- Rank 1 ----
		-- Sunny
		1256730, -- Sun Blast
		1256734, -- Germinate
		-- Doomflipper
		1263281, -- Flipping Out
		-- Goredome
		134527, -- Lumbering Charge
		-- Dippy
		134537, -- Peck
		---- Rank 2 ----
		-- Bruce
		135342, -- Chomp Chomp Chomp
		-- Bill the Janitor
		1261661, -- Summon Broom
		236453, -- Janitor's Revenge
		-- Oso
		234489, -- Shotgun Roar
		234365, -- Grizzly Leap
		-- The Quacken
		1257208, -- Fowl Play
		---- Rank 3 ----
		-- Razorgrin
		1267024, -- Bite
		-- Blat
		133302, -- Split
		-- Ooliss
		{233224, "CASTBAR"}, -- Horrific Pursuit
		-- King Kulaka
		1259113, -- Infected Wounds
		1259119, -- Dash
		---- Rank 4 ----
		-- Meatball
		134851, -- Strange Feeling
		-- Ash'katzuum (not interesting)
		-- Crush
		133253, -- Charge
		-- Glorp
		1256185, -- Gloop
		1256193, -- Gloopsie
		---- Rank 5 ----
		-- Klunk
		236875, -- Klunk
		-- Stitches
		236155, -- Aura of Rot
		236146, -- Stitches' Hook
		-- Topps
		232252, -- Dino Dash
		232285, -- Dino Daze
		232297, -- Tail Whip
		-- Carl
		229358, -- Burrow
		---- Rank 6 ----
		-- Leper Gnome Quintet
		133157, -- Leperous Spew
		-- Mecha-Bruce
		142788, -- Chomp Chomp Chomp Chomp Chomp Chomp Chomp
		142769, -- Stasis Beam
		-- GG Engineering
		133212, -- Goblin Rocket Barrage
		133162, -- Emergency Teleport
		-- Doopy
		142804, -- Big Peck
		---- Rank 7 ----
		-- Renegade Swabbie
		1256549, -- Searing Axe
		1256558, -- Repel
		1256569, -- Towering
		1256648, -- The Storm
		-- Ogrewatch
		{229154, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- High Noon
		230366, -- Barrier Projector
		230373, -- Jump Pack
		230372, -- Tesla Cannon
		229998, -- Maniacal Laugh
		-- Blingtron 3000
		141359, -- Mostly-Accurate Rocket
		141059, -- Overcharged!
		141229, -- Malfunctioning
		-- Epicus Maximus
		133250, -- Destructolaser
		133262, -- Blue Crush
	}, {
		{
			tabName = CL.general,
			{autotalk, 133359},
		},
		{
			tabName = L.rank:format(1),
			{1256730, 1256734, 1263281, 134527, 134537},
		},
		{
			tabName = L.rank:format(2),
			{135342, 1261661, 236453, 234489, 234365, 1257208},
		},
		{
			tabName = L.rank:format(3),
			{1267024, 133302, 233224, 1259113, 1259119},
		},
		{
			tabName = L.rank:format(4),
			{134851, 133253, 1256185, 1256193},
		},
		{
			tabName = L.rank:format(5),
			{236875, 236155, 236146, 232252, 232285, 232297, 229358},
		},
		{
			tabName = L.rank:format(6),
			{133157, 142788, 142769, 133212, 133162, 134537, 142804},
		},
		{
			tabName = L.rank:format(7),
			{1256549, 1256558, 1256569, 1256648, 229154, 230366, 230373, 230372, 229998, 141359, 141059, 141229, 133250, 133262},
		},
		-- General
		[autotalk] = CL.general,
		[133359] = CL.enrage,
		-- Rank 1
		[1256730] = L.sunny,
		[1263281] = L.doomflipper,
		[134527] = L.goredome,
		[134537] = L.dippy,
		-- Rank 2
		[135342] = L.bruce,
		[1261661] = L.bill_the_janitor,
		[234489] = L.oso,
		[1257208] = L.the_quacken,
		-- Rank 3
		[1267024] = L.razorgrin,
		[133302] = L.blat,
		[233224] = L.ooliss,
		[1259113] = L.king_kulaka,
		-- Rank 4
		[134851] = L.meatball,
		--[] = L.ash_katzuum,
		[133253] = L.crush,
		[1256185] = L.glorp,
		-- Rank 5
		[236875] = L.klunk,
		[236155] = L.stitches,
		[232252] = L.topps,
		[229358] = L.carl,
		-- Rank 6
		[133157] = L.leper_gnome_quintet,
		[142788] = L.mecha_bruce,
		[133212] = L.gg_engineering,
		[142804] = L.doopy,
		-- Rank 7
		[1256549] = L.renegade_swabbie,
		[229154] = L.ogrewatch,
		[141359] = L.blingtron_3000,
		[133250] = L.epicus_maximus,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Combat Detection
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	-- Sunny, Doomflipper, Goredome, Dippy, Bruce, Bill the Janitor, Oso, The Quacken, Razorgrin, Blat, Ooliss, King Kulaka, Meatball, Ash'katzuum, Crush, Glorp, Klunk, Stitches, Topps, Carl, Mecha-Bruce, Renegade Swabbie, Blingtron 3000, Epicus Maximus
	self:RegisterEngageMob("BossEngaged", 252778, 117145, 68257, 68255, 67262, 117077, 117753, 209227, 71085, 67594, 117133, 68254, 67573, 116855, 67540, 252597, 119150, 117275, 116539, 115233, 71081, 252721, 70740, 67490)
	self:Death("BossDeath", 252778, 117145, 68257, 68255, 67262, 117077, 117753, 209227, 71085, 67594, 117133, 68254, 67573, 116855, 67540, 252597, 119150, 117275, 116539, 115233, 71081, 252721, 70740, 67490)
	-- Leper Gnome Quintet
	self:RegisterEngageMob("LeperGnomeQuintetEngaged", 67511)
	self:Death("LeperGnomeQuintetDeath", 67511, 67513, 67514, 67515, 67516)
	-- GG Engineering
	self:RegisterEngageMob("GGEngineeringEngaged", 67488)
	self:Death("GGEngineeringDeath", 67488)
	-- Dippy and Doopy
	self:RegisterEngageMob("DippyAndDoopyEngaged", 70647)
	self:Death("DippyAndDoopyDeath", 70647, 70648)
	-- Ogrewatch
	self:RegisterEngageMob("OgrewatchEngaged", 114951)
	self:Death("OgrewatchDeath", 114955, 114951, 114941)

	-- Enrage
	self:Log("SPELL_CAST_SUCCESS", "EnragingFlames", 133359)

	-- Sunny
	self:Log("SPELL_CAST_START", "SunBlast", 1256730)
	self:Log("SPELL_CAST_SUCCESS", "Germinate", 1256734)
	self:Death("SunlingDeath", 252782)
	self:Log("SPELL_AURA_REMOVED", "GerminateRemoved", 1256753)

	-- Doomflipper
	self:Log("SPELL_CAST_START", "FlippingOut", 1263281)

	-- Goredome
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START") -- Lumbering Charge

	-- Dippy
	self:Log("SPELL_CAST_START", "Peck", 134537)

	-- Bruce
	self:Log("SPELL_CAST_START", "ChompChompChomp", 135342)

	-- Bill the Janitor
	self:Log("SPELL_CAST_START", "SummonBroom", 1261661)
	self:RegisterEngageMob("BoomBroomEngaged", 119094)

	-- Oso
	self:Log("SPELL_CAST_START", "ShotgunRoar", 234489)
	self:Log("SPELL_CAST_START", "GrizzlyLeap", 234365)

	-- The Quacken
	self:Log("SPELL_CAST_START", "FowlPlay", 1257208)

	-- Razorgrin
	self:Log("SPELL_DAMAGE", "Bite", 1267024)

	-- Blat
	self:Log("SPELL_CAST_START", "Split", 133302)

	-- Ooliss
	self:Log("SPELL_CAST_START", "HorrificPursuit", 233224)

	-- King Kulaka
	self:Log("SPELL_AURA_APPLIED_DOSE", "InfectedWoundsApplied", 1259113)
	self:Log("SPELL_AURA_REMOVED", "InfectedWoundsRemoved", 1259113)
	self:Log("SPELL_CAST_SUCCESS", "Dash", 1259119)

	-- Meatball
	self:Log("SPELL_AURA_APPLIED_DOSE", "StrangeFeelingApplied", 134851)
	self:Log("SPELL_AURA_REMOVED", "StrangeFeelingRemoved", 134851)

	-- Ash'katzuum (not interesting)

	-- Crush
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Charge

	-- Glorp
	self:Log("SPELL_PERIODIC_DAMAGE", "GloopDamage", 1256185)
	self:Log("SPELL_PERIODIC_MISSED", "GloopDamage", 1256185)
	self:Log("SPELL_CAST_START", "Gloopsie", 1256193)

	-- Klunk
	self:Log("SPELL_CAST_START", "Klunk", 236875)

	-- Stitches
	self:Log("SPELL_AURA_APPLIED_DOSE", "AuraOfRotApplied", 236155)
	self:Log("SPELL_AURA_REMOVED", "AuraOfRotRemoved", 236155)
	self:Log("SPELL_CAST_SUCCESS", "StitchesHook", 236146)

	-- Topps
	self:Log("SPELL_CAST_START", "DinoDash", 232252, 1259085)
	self:Log("SPELL_AURA_APPLIED", "DinoDaze", 232285)
	self:Log("SPELL_CAST_SUCCESS", "TailWhip", 232297)

	-- Carl
	self:Log("SPELL_CAST_START", "Burrow", 229358)

	-- Leper Gnome Quintet
	self:Log("SPELL_AURA_APPLIED_DOSE", "LeperousSpewApplied", 133157)
	self:Log("SPELL_AURA_REMOVED", "LeperousSpewRemoved", 133157)

	-- Mecha-Bruce
	self:Log("SPELL_CAST_START", "ChompChompChompChompChompChompChomp", 142788)
	self:Log("SPELL_CAST_START", "StasisBeam", 142769)

	-- GG Engineering
	self:Log("SPELL_CAST_START", "GoblinRocketBarrage", 133212)
	self:Log("SPELL_CAST_START", "EmergencyTeleport", 133162)

	-- Doopy
	self:Log("SPELL_CAST_START", "BigPeck", 142804)

	-- Renegade Swabbie
	self:Log("SPELL_CAST_START", "SearingAxe", 1256549)
	self:Log("SPELL_CAST_START", "Repel", 1256558)
	self:Log("SPELL_CAST_START", "Towering", 1256569)
	self:Log("SPELL_CAST_SUCCESS", "ToweringOver", 1256583)
	self:Log("SPELL_PERIODIC_DAMAGE", "TheStormDamage", 1256648)
	self:Log("SPELL_PERIODIC_MISSED", "TheStormDamage", 1256648)

	-- Ogrewatch
	self:Log("SPELL_CAST_START", "HighNoon", 229154)
	self:Log("SPELL_CAST_SUCCESS", "BarrierProjector", 230366)
	self:Log("SPELL_AURA_REMOVED", "BarrierProjectorRemoved", 230366)
	self:Log("SPELL_CAST_START", "JumpPack", 230373)
	self:Log("SPELL_CAST_START", "TeslaCannon", 230372)
	self:Log("SPELL_CAST_SUCCESS", "TeslaCannonSuccess", 230372)
	self:Log("SPELL_INTERRUPT", "TeslaCannonInterrupt", 230372)
	self:Log("SPELL_CAST_START", "ManiacalLaugh", 229998)

	-- Blingtron 3000
	self:Log("SPELL_CAST_SUCCESS", "MostlyAccurateRocket", 141359)
	self:Log("SPELL_CAST_SUCCESS", "Overcharged", 141059)
	self:Log("SPELL_CAST_SUCCESS", "Malfunctioning", 141229)

	-- Epicus Maximus
	self:Log("SPELL_CAST_SUCCESS", "Destructolaser", 133250)
	self:Log("SPELL_CAST_START", "BlueCrush", 133262)
end

function mod:OnBossDisable()
	brawling = false
end

function mod:OnEngage()
	-- 1:30 enrage timer, start Bar at 30 seconds left
	self:ScheduleTimer("Bar", 89.5, 133359, 30, nil, L["133359_icon"]) -- Enraging Flames
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(41149) then -- Brawl'gar Arena Grunt
			-- 41149:Yes, sign me up for a fight!
			self:SelectGossipID(41149)
		elseif self:GetGossipID(41787) then -- Bizmo's Brawlpub Bouncer
			-- 41787:Yes, sign me up for a fight!
			self:SelectGossipID(41787)
		end
	end
end

-- Combat Detection

function mod:Brawling()
	return brawling
end

function mod:PLAYER_REGEN_DISABLED()
	brawling = true
	self:Debug("PLAYER_REGEN_DISABLED")
	self:Engage()
end

function mod:PLAYER_REGEN_ENABLED()
	self:SimpleTimer(function()
		if brawling then
			brawling = false
			self:Debug("PLAYER_REGEN_ENABLED")
			self:Wipe()
		end
	end, 2)
end

function mod:BossEngaged(guid, mobId)
	if self:Brawling() then
		self:Debug("BossEngaged", guid, mobId)
		if mobId == 117145 then -- Doomflipper
			self:CDBar(1263281, 6.0) -- Flipping Out
		elseif mobId == 67262 then -- Bruce
			self:CDBar(135342, 3.6) -- Chomp Chomp Chomp
		elseif mobId == 209227 then -- The Quacken
			self:CDBar(1257208, 20.2) -- Fowl Play
		elseif mobId == 117133 then -- Ooliss
			self:CDBar(233224, 12.4) -- Horrific Pursuit
		elseif mobId == 67540 then -- Crush
			self:CDBar(133253, 4.6) -- Charge
		elseif mobId == 252597 then -- Glorp
			self:CDBar(1256193, 13.2) -- Gloopsie
		elseif mobId == 115233 then -- Carl
			self:CDBar(229358, 10.7) -- Burrow
		elseif mobId == 67488 then -- Max Megablast
			self:CDBar(133212, 2.3) -- Goblin Rocket Barrage
		elseif mobId == 252721 then -- Renegade Swabbie
			self:CDBar(1256549, 3.2) -- Searing Axe
			self:CDBar(1256558, 10.5) -- Repel
			self:CDBar(1256569, 14.0) -- Towering
		elseif mobId == 70740 then -- Blingtron 3000
			self:CDBar(141359, 5.9) -- Mostly Accurate Rocket
		elseif mobId == 67490 then -- Epicus Maximus
			self:CDBar(133250, 3.6) -- Destructolaser
			self:CDBar(133262, 15.8) -- Blue Crush
		end
	end
end

function mod:BossDeath(args)
	if self:Brawling() then
		brawling = false
		self:Debug("BossDeath")
		self:SendMessage("BigWigs_Message", self, nil, L.defeated:format(args.destName), "green")
		self:SendMessage("BigWigs_VictorySound", self)
		self:Reboot()
	else
		brawling = false
	end
end

do
	local leperGnomesAlive = 0

	function mod:LeperGnomeQuintetEngaged(guid, mobId)
		if self:Brawling() then
			leperGnomesAlive = 5
			self:Debug("BossEngaged", guid, mobId)
		end
	end

	function mod:LeperGnomeQuintetDeath(args)
		leperGnomesAlive = leperGnomesAlive - 1
		if self:Brawling() and leperGnomesAlive == 0 then
			brawling = false
			self:Debug("BossDeath")
			self:SendMessage("BigWigs_Message", self, nil, L.defeated:format(L.leper_gnome_quintet), "green")
			self:SendMessage("BigWigs_VictorySound", self)
			self:Reboot()
		elseif leperGnomesAlive == 0 then
			brawling = false
		end
	end
end

function mod:GGEngineeringEngaged(guid, mobId)
	if self:Brawling() then
		self:Debug("BossEngaged", guid, mobId)
	end
end

function mod:GGEngineeringDeath(args)
	if self:Brawling() then
		brawling = false
		self:Debug("BossDeath")
		self:SendMessage("BigWigs_Message", self, nil, L.defeated:format(L.gg_engineering), "green")
		self:SendMessage("BigWigs_VictorySound", self)
		self:Reboot()
	else
		brawling = false
	end
end

do
	local penguinsAlive = 0

	function mod:DippyAndDoopyEngaged(guid, mobId)
		if self:Brawling() then
			penguinsAlive = 2
			self:Debug("BossEngaged", guid, mobId)
		end
	end

	function mod:DippyAndDoopyDeath(args)
		penguinsAlive = penguinsAlive - 1
		if self:Brawling() and penguinsAlive == 0 then
			brawling = false
			self:Debug("BossDeath")
			self:SendMessage("BigWigs_Message", self, nil, L.defeated:format(CL.plus:format(L.dippy, L.doopy)), "green")
			self:SendMessage("BigWigs_VictorySound", self)
			self:Reboot()
		elseif penguinsAlive == 0 then
			brawling = false
		end
	end
end

do
	local ogrewatchAlive = 0

	function mod:OgrewatchEngaged(guid, mobId)
		if self:Brawling() then
			ogrewatchAlive = 3
			self:Debug("BossEngaged", guid, mobId)
			self:CDBar(229998, 2.3) -- Maniacal Laugh
			self:CDBar(230373, 7.8) -- Jump Pack
			self:CDBar(230372, 10.7) -- Tesla Cannon
		end
	end

	function mod:OgrewatchDeath(args)
		ogrewatchAlive = ogrewatchAlive - 1
		if args.mobId == 114955 then -- Dole Dastardly
			self:StopCastBar(229154) -- High Noon
		elseif args.mobId == 114951 then -- Hudson
			self:StopBar(230373) -- Jump Pack
			self:StopBar(230372) -- Tesla Cannon
		else -- 114941, Stuffshrew
			self:StopBar(229998) -- Maniacal Laugh
		end
		if self:Brawling() and ogrewatchAlive == 0 then
			brawling = false
			self:Debug("BossDeath")
			self:SendMessage("BigWigs_Message", self, nil, L.defeated:format(L.ogrewatch), "green")
			self:SendMessage("BigWigs_VictorySound", self)
			self:Reboot()
		elseif ogrewatchAlive == 0 then
			brawling = false
		end
	end
end

-- Enrage

function mod:EnragingFlames(args)
	if self:Brawling() then
		self:StopBar(args.spellId)
		self:Message(args.spellId, "cyan", nil, L["133359_icon"])
		self:PlaySound(args.spellId, "long")
	end
end

-- Sunny

function mod:SunBlast(args)
	if self:Brawling() then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local addsAlive = 0

	function mod:Germinate(args)
		if self:Brawling() then
			addsAlive = 4
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end

	function mod:SunlingDeath()
		if self:Brawling() then
			addsAlive = addsAlive - 1
			if addsAlive > 0 then
				self:Message(1256734, "cyan", CL.add_remaining:format(addsAlive))
				self:PlaySound(1256734, "info")
			end
		end
	end
end

function mod:GerminateRemoved(args)
	if self:Brawling() then
		self:Message(1256734, "green", CL.over:format(args.spellName))
		self:PlaySound(1256734, "info")
	end
end

-- Doomflipper

function mod:FlippingOut(args)
	if self:Brawling() then
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 25.4)
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Goredome

do
	local prev = 0
	function mod:UNIT_SPELLCAST_CHANNEL_START(_, _, _, spellId)
		if self:Brawling() then
			if not self:IsSecret(spellId) and spellId == 134527 then -- Lumbering Charge
				local t = GetTime()
				if t - prev > 5 then -- castGUID is nil
					prev = t
					self:Message(134527, "orange")
					self:CDBar(134527, 11.0)
					self:PlaySound(134527, "alarm")
				end
			end
		end
	end
end

-- Dippy

function mod:Peck(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end

-- Bruce

function mod:ChompChompChomp(args)
	if self:Brawling() then
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 8.4)
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Bill the Janitor

function mod:SummonBroom(args)
	if self:Brawling() then
		local _, isReady = self:Interrupter()
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		if isReady then
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:BoomBroomEngaged()
	if self:Brawling() then
		self:Message(236453, "yellow")
		self:PlaySound(236453, "long")
	end
end

-- Oso

function mod:ShotgunRoar(args)
	if self:Brawling() then
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 10.9)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:GrizzlyLeap(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

-- The Quacken

function mod:FowlPlay(args)
	if self:Brawling() then
		self:Message(args.spellId, "cyan")
		self:CDBar(args.spellId, 31.5)
		self:PlaySound(args.spellId, "long")
	end
end

-- Razorgrin

function mod:Bite(args)
	if self:Brawling() then
		if self:Me(args.destGUID) then
			self:PersonalMessage(args.spellId, "near")
		else
			self:TargetMessage(args.spellId, "blue", args.destName)
		end
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Blat

function mod:Split(args)
	if self:Brawling() then
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
	end
end

-- Ooliss

function mod:HorrificPursuit(args)
	if self:Brawling() then
		self:Message(args.spellId, "red")
		self:CastBar(args.spellId, 10)
		self:CDBar(args.spellId, 25.5)
		self:PlaySound(args.spellId, "warning")
	end
end

-- King Kulaka

function mod:InfectedWoundsApplied(args)
	if self:Brawling() then
		if args.amount % 5 == 0 then
			self:StackMessage(args.spellId, "orange", args.destName, args.amount, 1)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:InfectedWoundsRemoved(args)
	if self:Brawling() then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:Dash(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end

-- Meatball

function mod:StrangeFeelingApplied(args)
	if self:Brawling() then
		if args.amount % 5 == 0 then
			self:StackMessage(args.spellId, "green", args.destName, args.amount, 1)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end

function mod:StrangeFeelingRemoved(args)
	if self:Brawling() then
		self:Message(args.spellId, "red", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Ash'katzuum (not interesting)

-- Crush

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if self:Brawling() then
			if not self:IsSecret(spellId) and spellId == 133253 and castGUID ~= prev then -- Charge
				prev = castGUID
				self:Message(spellId, "orange")
				self:CDBar(spellId, 21.8)
				self:PlaySound(spellId, "alarm")
			end
		end
	end
end

-- Glorp

do
	local prev = 0
	function mod:GloopDamage(args)
		if self:Brawling() then
			if self:Me(args.destGUID) and args.time - prev > 3 then
				prev = args.time
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

function mod:Gloopsie(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 23.8)
		self:PlaySound(args.spellId, "long")
	end
end

-- Klunk

function mod:Klunk(args)
	if self:Brawling() then
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Stitches

function mod:AuraOfRotApplied(args)
	if self:Brawling() then
		if args.amount == 5 or args.amount == 8 or args.amount == 9 then
			self:StackMessage(args.spellId, "orange", args.destName, args.amount, 8)
			if args.amount == 9 then
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			else
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

function mod:AuraOfRotRemoved(args)
	if self:Brawling() then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:StitchesHook(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Topps

function mod:DinoDash(args)
	if self:Brawling() then
		self:Message(232252, "orange")
		self:PlaySound(232252, "alarm")
	end
end

function mod:DinoDaze(args)
	if self:Brawling() then
		self:Bar(232297, 12.0) -- Tail Whip
		self:Message(args.spellId, "green")
		self:PlaySound(args.spellId, "info")
	end
end

function mod:TailWhip(args)
	if self:Brawling() then
		self:StopBar(args.spellId)
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Carl

function mod:Burrow(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 29.0)
		self:PlaySound(args.spellId, "info")
	end
end

-- Leper Gnome Quintet

function mod:LeperousSpewApplied(args)
	if self:Brawling() then
		if args.amount % 5 == 0 then
			self:StackMessage(args.spellId, "orange", args.destName, args.amount, 1)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:LeperousSpewRemoved(args)
	if self:Brawling() then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Mecha-Bruce

function mod:ChompChompChompChompChompChompChomp(args)
	if self:Brawling() then
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:StasisBeam(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end

-- GG Engineering

function mod:GoblinRocketBarrage(args)
	if self:Brawling() then
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 17.0)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:EmergencyTeleport(args)
	if self:Brawling() then
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
	end
end

-- Doopy

function mod:BigPeck(args)
	if self:Brawling() then
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Renegade Swabbie

function mod:SearingAxe(args)
	if self:Brawling() then
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 9.6)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:Repel(args)
	if self:Brawling() then
		self:Message(args.spellId, "orange")
		self:StopBar(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:Towering(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:StopBar(1256549) -- Searing Axe
		self:StopBar(1256558) -- Repel
		self:StopBar(args.spellId)
		self:PlaySound(args.spellId, "long")
	end
end

function mod:ToweringOver(args)
	if self:Brawling() then
		self:CDBar(1256549, 1.0) -- Searing Axe
		self:CDBar(1256558, 15.0) -- Repel
		self:CDBar(1256569, 18.6) -- Towering
		self:Message(1256569, "green", CL.over:format(args.spellName))
		self:PlaySound(1256569, "info")
	end
end

do
	local prev = 0
	function mod:TheStormDamage(args)
		if self:Brawling() then
			if self:Me(args.destGUID) and args.time - prev > 3 then
				prev = args.time
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Ogrewatch

function mod:HighNoon(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:CastBar(args.spellId, 80)
		self:PlaySound(args.spellId, "long")
	end
end

function mod:BarrierProjector(args)
	if self:Brawling() then
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
	end
end

function mod:BarrierProjectorRemoved(args)
	if self:Brawling() then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:JumpPack(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 13.3)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:TeslaCannon(args)
	if self:Brawling() then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:TeslaCannonInterrupt(args)
	if self:Brawling() then
		self:CDBar(230372, 10.0)
	end
end

function mod:TeslaCannonSuccess(args)
	if self:Brawling() then
		self:CDBar(args.spellId, 10.0)
	end
end

function mod:ManiacalLaugh(args)
	if self:Brawling() then
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 20.6)
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Blingtron 3000

function mod:MostlyAccurateRocket(args)
	if self:Brawling() then
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 7.1)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:Overcharged(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
	end
end

function mod:Malfunctioning(args)
	if self:Brawling() then
		self:StopBar(141359) -- Mostly-Accurate Rocket
		self:Message(args.spellId, "green")
		self:PlaySound(args.spellId, "long")
	end
end

-- Epicus Maximus

function mod:Destructolaser(args)
	if self:Brawling() then
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 20.6)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:BlueCrush(args)
	if self:Brawling() then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 21.8)
		self:PlaySound(args.spellId, "alert")
	end
end
