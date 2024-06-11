--------------------------------------------------------------------------------
-- TODO
-- Walkie Shockie X1 spawn warning and fixate nameplate icons
-- Scrapbone Grunter fixate nameplate icons
--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Operation: Mechagon Trash", 2097)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	150146, -- Scrapbone Shaman
	150160, -- Scrapbone Bully
	150143, -- Scrapbone Grinder
	150154, -- Saurolisk Bonenipper
	152009, -- Malfunctioning Scrapbot
	150276, -- Heavy Scrapbot
	150250, -- Pistonhead Blaster
	150249, -- Pistonhead Scrapper
	150253, -- Weaponized Crawler
	150165, -- Slime Elemental
	150168, -- Toxic Monstrosity
	154758, -- Toxic Monstrosity
	154744, -- Toxic Monstrosity
	150169, -- Toxic Lurker
	150251, -- Pistonhead Mechanic
	150254, -- Scraphound
	150297, -- Mechagon Renormalizer
	150292, -- Mechagon Cavalry
	155094, -- Mechagon Trooper
	155090, -- Anodized Coilbearer
	151657, -- Bomb Tonk
	151659, -- Rocket Tonk
	144293, -- Waste Processing Unit
	144301, -- Living Waste
	144294, -- Mechagon Tinkerer
	151613, -- Anti-Personnel Squirrel
	144298, -- Defense Bot Mk III
	151476, -- Blastatron X-80
	144295, -- Mechagon Mechanic
	144299, -- Workshop Defender
	144296, -- Spider Tank
	151773  -- Junkyard D.0.G.
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.scrapbone_shaman = "Scrapbone Shaman"
	L.scrapbone_bully = "Scrapbone Bully"
	L.scrapbone_grinder = "Scrapbone Grinder"
	L.saurolisk_bonenipper = "Saurolisk Bonenipper"
	L.malfunctioning_scrapbot = "Malfunctioning Scrapbot"
	L.heavy_scrapbot = "Heavy Scrapbot"
	L.pistonhead_blaster = "Pistonhead Blaster"
	L.pistonhead_scrapper = "Pistonhead Scrapper"
	L.weaponized_crawler = "Weaponized Crawler"
	L.slime_elemental = "Slime Elemental"
	L.toxic_monstrosity = "Toxic Monstrosity"
	L.toxic_lurker = "Toxic Lurker"
	L.pistonhead_mechanic = "Pistonhead Mechanic"
	L.scraphound = "Scraphound"
	L.mechagon_renormalizer = "Mechagon Renormalizer"
	L.mechagon_cavalry = "Mechagon Cavalry"
	L.mechagon_trooper = "Mechagon Trooper"
	L.anodized_coilbearer = "Anodized Coilbearer"
	L.bomb_tonk = "Bomb Tonk"
	L.rocket_tonk = "Rocket Tonk"
	L.waste_processing_unit = "Waste Processing Unit"
	L.living_waste = "Living Waste"
	L.mechagon_tinkerer = "Mechagon Tinkerer"
	L.anti_personnel_squirrel = "Anti-Personnel Squirrel"
	L.defense_bot_mk_iii = "Defense Bot Mk III"
	L.blastatron_x80 = "Blastatron X-80"
	L.mechagon_mechanic = "Mechagon Mechanic"
	L.workshop_defender = "Workshop Defender"
	L.junkyard_d0g = "Junkyard D.0.G."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Scrapbone Shaman
		300436, -- Grasping Hex
		{300514, "DISPEL"}, -- Stoneskin
		-- Scrapbone Grinder
		{300414, "DISPEL"}, -- Enrage
		-- Scrapbone Bully
		300424, -- Shockwave
		-- Saurolisk Bonenipper
		299474, -- Ripping Slash
		-- Malfunctioning Scrapbot
		300102, -- Exhaust
		294884, -- Gyro-Scrap
		300129, -- Self-Destruct Protocol
		-- Heavy Scrapbot
		300177, -- Exhaust
		300159, -- Gyro-Scrap
		300171, -- Repair Protocol
		-- Pistonhead Blaster
		299525, -- Scrap Grenade
		-- Pistonhead Scrapper
		{299438, "TANK_HEALER"}, -- Sledgehammer
		-- Weaponized Crawler
		{300188, "SAY", "FLASH"}, -- Scrap Cannon
		{300207, "CASTBAR"}, -- Shock Coil
		-- Slime ELemental
		300764, -- Slimebolt
		300777, -- Slimewave
		-- Toxic Monstrosity
		{300687, "CASTBAR"}, -- Consume
		-- Toxic Lurker
		{300650, "DISPEL"}, -- Suffocating Smog
		-- Pistonhead Mechanic
		{299588, "DISPEL"}, -- Overclock
		300087, -- Repair
		-- Scraphound
		299475, -- B.O.R.K.
		-- Mechagon Renormalizer
		{284219, "SAY", "DISPEL"}, -- Shrink
		-- Mechagon Cavalry
		301667, -- Rapid Fire
		301681, -- Charge
		-- Mechagon Trooper
		299502, -- Nanoslicer
		-- Anodized Coilbearer
		{303941, "DISPEL"}, -- Defensive Countermeasure
		-- Bomb Tonk
		301088, -- Detonate
		-- Rocket Tonk
		{294103, "CASTBAR"}, -- Rocket Barrage
		-- Waste Processing Unit
		294324, -- Mega Drill
		294290, -- Process Waste
		-- Living Waste
		294349, -- Volatile Waste
		-- Mechagon Tinkerer
		293827, -- Giga-Wallop
		-- Anti-Personnel Squirrel
		293861, -- Anti-Personnel Squirrel (aoe effect)
		-- Defense Bot Mk III
		{294195, "DISPEL"}, -- Arcing Zap
		{297133, "DISPEL"}, -- Defensive Countermeasure
		{297128, "CASTBAR"}, -- Short Out
		-- Blastatron X-80
		294015, -- Launch High-Explosive Rockets
		293986, -- Sonic Pulse
		295169, -- Capacitor Discharge
		-- Mechagon Mechanic
		293729, -- Tune Up
		293930, -- Overclock
		-- Workshop Defender
		{293670, "TANK_HEALER"}, -- Chainblade
		293683, -- Shield Generator
		-- Junkyard D.0.G.
		{294180, "DISPEL"}, -- Flaming Refuse
	}, {
		[300436] = L.scrapbone_shaman,
		[300414] = L.scrapbone_grinder,
		[300424] = L.scrapbone_bully,
		[299474] = L.saurolisk_bonenipper,
		[294884] = L.malfunctioning_scrapbot,
		[300177] = L.heavy_scrapbot,
		[299525] = L.pistonhead_blaster,
		[299438] = L.pistonhead_scrapper,
		[300764] = L.slime_elemental,
		[300650] = L.toxic_lurker,
		[299588] = L.pistonhead_mechanic,
		[299475] = L.scraphound,
		[284219] = L.mechagon_renormalizer,
		[301667] = L.mechagon_cavalry,
		[299502] = L.mechagon_trooper,
		[303941] = L.anodized_coilbearer,
		[301088] = L.bomb_tonk,
		[294103] = L.rocket_tonk,
		[294324] = L.waste_processing_unit,
		[294349] = L.living_waste,
		[293827] = L.mechagon_tinkerer,
		[293861] = L.anti_personnel_squirrel,
		[294195] = L.defense_bot_mk_iii,
		[294015] = L.blastatron_x80,
		[293729] = L.mechagon_mechanic,
		[293670] = L.workshop_defender,
		[294180] = L.junkyard_d0g,
	}
end

function mod:OnBossEnable()
	-- Scrapbone Shaman
	self:Log("SPELL_CAST_START", "GraspingHex", 300436)
	self:Log("SPELL_CAST_START", "Stoneskin", 300514)
	self:Log("SPELL_AURA_APPLIED", "StoneskinApplied", 300514)
	-- Scrapbone Grinder
	self:Log("SPELL_CAST_START", "Enrage", 300414)
	self:Log("SPELL_AURA_APPLIED", "EnrageApplied", 300414)
	-- Scrapbone Bully
	self:Log("SPELL_CAST_START", "Shockwave", 300424)
	-- Saurolisk Bonenipper
	self:Log("SPELL_AURA_APPLIED", "RippingSlashApplied", 299474)
	-- Malfunctioning Scrapbot
	self:Log("SPELL_CAST_START", "MalfunctioningExhaust", 300102)
	self:Log("SPELL_CAST_START", "MalfunctioningGyroScrap", 294884)
	self:Log("SPELL_CAST_START", "SelfDestructProtocol", 300129)
	-- Heavy Scrapbot
	self:Log("SPELL_CAST_START", "HeavyExhaust", 300177)
	self:Log("SPELL_CAST_START", "HeavyGyroScrap", 300159)
	self:Log("SPELL_CAST_START", "RepairProtocol", 300171)
	-- Pistonhead Blaster
	self:Log("SPELL_CAST_SUCCESS", "ScrapGrenade", 299525)
	-- Pistonhead Scrapper
	self:Log("SPELL_AURA_APPLIED", "SledgehammerApplied", 299438)
	-- Weaponized Crawler
	self:Log("SPELL_CAST_START", "ScrapCannon", 300188)
	self:Log("SPELL_CAST_START", "ShockCoil", 300207)
	self:Log("SPELL_AURA_APPLIED", "ShockCoilApplied", 300207)
	self:Death("WeaponizedCrawlerDeath", 150253)
	-- Slime ELemental
	self:Log("SPELL_CAST_START", "SlimeBolt", 300764)
	self:Log("SPELL_CAST_START", "Slimewave", 300777)
	-- Toxic Monstrosity
	self:Log("SPELL_CAST_START", "Consume", 300687)
	self:Log("SPELL_CAST_SUCCESS", "ConsumeSuccess", 300687)
	self:Death("ToxicMonstrosityDeath", 150168, 154758, 154744) -- Different mob ids with the same name and spells
	-- Toxic Lurker
	self:Log("SPELL_CAST_START", "SuffocatingSmog", 300650)
	self:Log("SPELL_AURA_APPLIED", "SuffocatingSmogApplied", 300650)
	-- Pistonhead Mechanic
	self:Log("SPELL_CAST_START", "Overclock", 299588)
	self:Log("SPELL_AURA_APPLIED", "PistonheadMechanicOverclockApplied", 299588)
	self:Log("SPELL_CAST_START", "Repair", 300087)
	-- Scraphound
	self:Log("SPELL_CAST_START", "BORK", 299475)
	-- Mechagon Renormalizer
	self:Log("SPELL_CAST_START", "Shrink", 284219)
	self:Log("SPELL_AURA_APPLIED", "ShrinkApplied", 284219)
	-- Mechagon Cavalry
	self:Log("SPELL_CAST_START", "RapidFire", 301667)
	self:Log("SPELL_CAST_START", "Charge", 301681)
	-- Mechagon Trooper
	self:Log("SPELL_CAST_START", "Nanoslicer", 299502)
	self:Log("SPELL_AURA_APPLIED", "NanoslicerApplied", 299502)
	-- Anodized Coilbearer
	self:Log("SPELL_AURA_APPLIED", "CoilbearerDefensiveCountermeasureApplied", 303941)
	-- Bomb Tonk
	self:Log("SPELL_CAST_START", "Detonate", 301088)
	-- Rocket Tonk
	self:Log("SPELL_CAST_SUCCESS", "RocketBarrage", 294103)
	-- Waste Processing Unit
	self:Log("SPELL_CAST_START", "MegaDrill", 294324)
	self:Log("SPELL_CAST_START", "ProcessWaste", 294290)
	-- Living Waste
	self:Log("SPELL_CAST_START", "VolatileWaste", 294349)
	-- Mechagon Tinkerer
	self:Log("SPELL_CAST_START", "GigaWallop", 293827)
	-- Anti-Personnel Squirrel
	self:Log("SPELL_CAST_START", "AntiPersonnelSquirrel", 293861)
	-- Defense Bot Mk III
	self:Log("SPELL_AURA_APPLIED", "ArcingZapApplied", 294195)
	self:Log("SPELL_AURA_APPLIED", "DefenseBotDefensiveCountermeasureApplied", 297133)
	self:Log("SPELL_CAST_START", "ShortOut", 297128)
	self:Log("SPELL_CAST_SUCCESS", "ShortOutSuccess", 297128)
	-- Blastatron X-80
	self:Log("SPELL_CAST_SUCCESS", "LaunchHighExplosiveRockets", 294015)
	self:Log("SPELL_CAST_START", "SonicPulse", 293986)
	self:Log("SPELL_CAST_SUCCESS", "CapacitorDischarge", 295169)
	self:Death("BlastatronDeath", 151476)
	-- Mechagon Mechanic
	self:Log("SPELL_CAST_START", "TuneUp", 293729)
	self:Log("SPELL_AURA_APPLIED", "MechagonMechanicOverclockApplied", 293930)
	-- Workshop Defender
	self:Log("SPELL_AURA_APPLIED", "ChainbladeApplied", 293670)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ChainbladeApplied", 293670)
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- for Shield Generator
	-- Junkyard D.0.G.
	self:Log("SPELL_AURA_APPLIED", "FlamingRefuseApplied", 294180)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if castGUID == prev then return end
		prev = castGUID
		if spellId == 293683 then -- Workshop Defender, Shield Generator
			self:Message(spellId, "green")
			self:PlaySound(spellId, "info")
		end
	end
end

-- Scrapbone Shaman

function mod:GraspingHex(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:Stoneskin(args)
	if self:Interrupter() then
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:StoneskinApplied(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Scrapbone Grinder

function mod:Enrage(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:EnrageApplied(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Scrapbone Bully

function mod:Shockwave(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Saurolisk Bonenipper

function mod:RippingSlashApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Malfunctioning Scrapbot

function mod:MalfunctioningExhaust(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:MalfunctioningGyroScrap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:SelfDestructProtocol(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Heavy Scrapbot

function mod:HeavyExhaust(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:HeavyGyroScrap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:RepairProtocol(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Pistonhead Blaster

function mod:ScrapGrenade(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

-- Pistonhead Scrapper

function mod:SledgehammerApplied(args)
	self:StackMessageOld(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

-- Weaponized Crawler

do
	local function printTarget(self, name, guid)
		self:TargetMessage(300188, "red", name)
		self:PlaySound(300188, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(300188, nil, nil, "Scrap Cannon")
			self:Flash(300188)
		end
	end

	function mod:ScrapCannon(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 12.1)
	end
end

function mod:ShockCoil(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 19.4)
end

function mod:ShockCoilApplied(args)
	self:CastBar(args.spellId, 6)
end

function mod:WeaponizedCrawlerDeath(args)
	self:StopBar(300188) -- Scrap Cannon
	self:StopBar(300207) -- Shock Coil
	self:StopBar(CL.cast:format(self:SpellName(300207))) -- Shock Coil
end

-- Slime Elemental

do
	local prev = 0
	function mod:SlimeBolt(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:Slimewave(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Toxic Monstrosity

function mod:Consume(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 19.5)
end

function mod:ConsumeSuccess(args)
	self:CastBar(args.spellId, 6)
end

function mod:ToxicMonstrosityDeath(args)
	self:StopBar(300687)
end

-- Toxic Lurker

function mod:SuffocatingSmog(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:SuffocatingSmogApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

-- Pistonhead Mechanic

function mod:Overclock(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:PistonheadMechanicOverclockApplied(args)
		local t = args.time
		if self:Dispeller("magic", true, args.spellId) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:Repair(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Scraphound

function mod:BORK(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Mechagon Renormalizer

function mod:Shrink(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:ShrinkApplied(args)
	local isOnMe = self:Me(args.destGUID)
	if self:Dispeller("magic", nil, args.spellId) or isOnMe then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
		if isOnMe then
			self:Say(args.spellId, nil, nil, "Shrink")
		end
	end
end

-- Mechagon Cavalry

function mod:RapidFire(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Charge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Mechagon Trooper

function mod:Nanoslicer(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:NanoslicerApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

-- Anodized Coilbearer

function mod:CoilbearerDefensiveCountermeasureApplied(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Bomb Tonk

function mod:Detonate(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

-- Rocket Tonk

function mod:RocketBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 5)
end

-- Waste Processing Unit

function mod:MegaDrill(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ProcessWaste(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

-- Living Waste

do
	local prev = 0
	function mod:VolatileWaste(args)
		local t = args.time
		if t-prev > 5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Mechagon Tinkerer

do
	local prev = 0
	function mod:GigaWallop(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Anti-Personnel Squirrel

function mod:AntiPersonnelSquirrel(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if not unit or self:UnitWithinRange(unit, 10) then
		-- Display mesage without "near YOU" if the unit is not found
		self:Message(args.spellId, "yellow", unit and CL.near:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Defense Bot Mk III

do
	local playerList = mod:NewTargetList()
	function mod:ArcingZapApplied(args)
		if self:Dispeller("magic", nil, args.spellId) then
			self:PlaySound(args.spellId, "alert", nil, playerList)
			self:TargetsMessageOld(args.spellId, "yellow", playerList, 3) -- Three bots that can all cast at the same time
		end
	end
end

function mod:DefenseBotDefensiveCountermeasureApplied(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:ShortOut(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ShortOutSuccess(args)
	self:CastBar(args.spellId, 3)
end

-- Blastatron X-80

function mod:LaunchHighExplosiveRockets(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:SonicPulse(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:CapacitorDischarge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 4, CL.count:format(args.spellName, 1))
	self:Bar(args.spellId, 8, CL.count:format(args.spellName, 2))
	self:Bar(args.spellId, 12, CL.count:format(args.spellName, 3))
end

function mod:BlastatronDeath(args)
	local capacitorDischarge = self:SpellName(295169)
	self:StopBar(CL.count:format(capacitorDischarge, 1))
	self:StopBar(CL.count:format(capacitorDischarge, 2))
	self:StopBar(CL.count:format(capacitorDischarge, 3))
end

-- Mechagon Mechanic

function mod:TuneUp(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:MechagonMechanicOverclockApplied(args)
		local t = args.time
		if self:Dispeller("enrage", true, args.spellId) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Workshop Defender

function mod:ChainbladeApplied(args)
	self:StackMessageOld(args.spellId, args.destName, args.amount, "red")
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

-- Junkyard D.0.G.

function mod:FlamingRefuseApplied(args)
	if self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
