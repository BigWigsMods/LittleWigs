local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Operation: Mechagon Trash", 2097)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	------ Junkyard ------
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
	------ Workshop ------
	151657, -- Bomb Tonk
	151659, -- Rocket Tonk
	144293, -- Waste Processing Unit
	236033, -- Metal Gunk
	144301, -- Living Waste
	151773, -- Junkyard D.0.G.
	144294, -- Mechagon Tinkerer
	151613, -- Anti-Personnel Squirrel
	144298, -- Defense Bot Mk III
	151649, -- Defense Bot MK I
	151476, -- Blastatron X-80
	144295, -- Mechagon Mechanic
	144299, -- Workshop Defender
	144296 -- Spider Tank
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	------ Junkyard ------
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
	------ Workshop ------
	L.bomb_tonk = "Bomb Tonk"
	L.rocket_tonk = "Rocket Tonk"
	L.waste_processing_unit = "Waste Processing Unit"
	L.metal_gunk = "Metal Gunk"
	L.living_waste = "Living Waste" -- XXX remove when 11.1 is live
	L.junkyard_d0g = "Junkyard D.0.G."
	L.mechagon_tinkerer = "Mechagon Tinkerer"
	L.anti_personnel_squirrel = "Anti-Personnel Squirrel"
	L.defense_bot_mk_iii = "Defense Bot Mk III"
	L.blastatron_x80 = "Blastatron X-80"
	L.mechagon_mechanic = "Mechagon Mechanic"
	L.workshop_defender = "Workshop Defender"
end

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotOne then
	function mod:GetOptions()
		return {
			------ Junkyard ------
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
			{300188, "SAY", "NAMEPLATE"}, -- Scrap Cannon
			{300207, "CASTBAR", "NAMEPLATE"}, -- Shock Coil
			-- Slime Elemental
			300764, -- Slimebolt
			300777, -- Slimewave
			-- Toxic Monstrosity
			{300687, "CASTBAR", "NAMEPLATE"}, -- Consume
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
			------ Workshop ------
			-- Bomb Tonk
			{301088, "NAMEPLATE"}, -- Detonate
			-- Rocket Tonk
			{294103, "NAMEPLATE"}, -- Rocket Barrage
			-- Waste Processing Unit
			{1215409, "NAMEPLATE"}, -- Mega Drill
			{1215411, "TANK_HEALER", "NAMEPLATE"}, -- Puncture
			-- Metal Gunk
			{1215412, "HEALER", "NAMEPLATE"}, -- Corrosive Gunk
			-- Junkyard D.0.G.
			{1217819, "NAMEPLATE"}, -- Fiery Jaws
			-- Mechagon Tinkerer
			{293827, "OFF"}, -- Giga-Wallop
			-- Anti-Personnel Squirrel
			293861, -- Anti-Personnel Squirrel
			-- Defense Bot Mk III
			{294195, "DISPEL", "NAMEPLATE"}, -- Arcing Zap
			{297133, "DISPEL"}, -- Defensive Countermeasure
			{297128, "NAMEPLATE"}, -- Short Out
			-- Blastatron X-80
			{293986, "NAMEPLATE"}, -- Sonic Pulse
			{295169, "NAMEPLATE"}, -- Capacitor Discharge
			-- Mechagon Mechanic
			{293729, "NAMEPLATE"}, -- Tune Up
			{293930, "DISPEL", "NAMEPLATE"}, -- Overclock
			-- Workshop Defender
			{293670, "TANK_HEALER", "NAMEPLATE"}, -- Chainblade
			{293683, "NAMEPLATE"}, -- Shield Generator
		}, {
			------ Junkyard ------
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
			------ Workshop ------
			[301088] = L.bomb_tonk,
			[294103] = L.rocket_tonk,
			[1215409] = L.waste_processing_unit,
			[1215412] = L.metal_gunk,
			[1217819] = L.junkyard_d0g,
			[293827] = L.mechagon_tinkerer,
			[293861] = L.anti_personnel_squirrel,
			[294195] = L.defense_bot_mk_iii,
			[293986] = L.blastatron_x80,
			[293729] = L.mechagon_mechanic,
			[293670] = L.workshop_defender,
		}
	end
else -- XXX remove this block when 11.1 is live
	function mod:GetOptions()
		return {
			------ Junkyard ------
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
			{300188, "SAY", "NAMEPLATE"}, -- Scrap Cannon
			{300207, "CASTBAR", "NAMEPLATE"}, -- Shock Coil
			-- Slime Elemental
			300764, -- Slimebolt
			300777, -- Slimewave
			-- Toxic Monstrosity
			{300687, "CASTBAR", "NAMEPLATE"}, -- Consume
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
			------ Workshop ------
			-- Bomb Tonk
			{301088, "NAMEPLATE"}, -- Detonate
			-- Rocket Tonk
			{294103, "NAMEPLATE"}, -- Rocket Barrage
			-- Waste Processing Unit
			294324, -- Mega Drill
			294290, -- Process Waste
			-- Living Waste
			294349, -- Volatile Waste
			-- Junkyard D.0.G.
			{294180, "DISPEL"}, -- Flaming Refuse
			-- Mechagon Tinkerer
			{293827, "OFF"}, -- Giga-Wallop
			-- Anti-Personnel Squirrel
			293861, -- Anti-Personnel Squirrel
			-- Defense Bot Mk III
			{294195, "DISPEL", "NAMEPLATE"}, -- Arcing Zap
			{297133, "DISPEL"}, -- Defensive Countermeasure
			{297128, "NAMEPLATE"}, -- Short Out
			-- Blastatron X-80
			294015, -- Launch High-Explosive Rockets
			{293986, "NAMEPLATE"}, -- Sonic Pulse
			{295169, "NAMEPLATE"}, -- Capacitor Discharge
			-- Mechagon Mechanic
			{293729, "NAMEPLATE"}, -- Tune Up
			{293930, "DISPEL", "NAMEPLATE"}, -- Overclock
			-- Workshop Defender
			{293670, "TANK_HEALER", "NAMEPLATE"}, -- Chainblade
			{293683, "NAMEPLATE"}, -- Shield Generator
		}, {
			------ Junkyard ------
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
			------ Workshop ------
			[301088] = L.bomb_tonk,
			[294103] = L.rocket_tonk,
			[294324] = L.waste_processing_unit,
			[294349] = L.living_waste,
			[294180] = L.junkyard_d0g,
			[293827] = L.mechagon_tinkerer,
			[293861] = L.anti_personnel_squirrel,
			[294195] = L.defense_bot_mk_iii,
			[294015] = L.blastatron_x80,
			[293729] = L.mechagon_mechanic,
			[293670] = L.workshop_defender,
		}
	end
end

function mod:OnBossEnable()
	------ Junkyard ------

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

	-- Slime Elemental
	self:Log("SPELL_CAST_START", "SlimeBolt", 300764)
	self:Log("SPELL_CAST_START", "Slimewave", 300777)

	-- Toxic Monstrosity
	self:Log("SPELL_CAST_START", "Consume", 300687)
	self:Log("SPELL_CAST_SUCCESS", "ConsumeSuccess", 300687)
	self:Death("ToxicMonstrosityDeath", 150168, 154758, 154744)

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

	------ Workshop ------

	-- Bomb Tonk
	self:RegisterEngageMob("BombTonkEngaged", 151657)
	self:Log("SPELL_CAST_START", "Detonate", 301088)
	self:Log("SPELL_INTERRUPT", "DetonateInterrupt", 301088)
	self:Death("BombTonkDeath", 151657)

	-- Rocket Tonk
	self:RegisterEngageMob("RocketTonkEngaged", 151659)
	self:Log("SPELL_CAST_SUCCESS", "RocketBarrage", 294103)
	self:Death("RocketTonkDeath", 151659)

	-- Waste Processing Unit
	if isElevenDotOne then
		self:RegisterEngageMob("WasteProcessingUnitEngaged", 144293)
		self:Log("SPELL_CAST_START", "MegaDrill", 1215409)
		self:Log("SPELL_CAST_START", "Puncture", 1215411)
		self:Death("WasteProcessingUnitDeath", 144293)
	else
		self:Log("SPELL_CAST_START", "MegaDrillOld", 294324) -- XXX removed in 11.1
		self:Log("SPELL_CAST_START", "ProcessWaste", 294290) -- XXX removed in 11.1
	end

	if isElevenDotOne then
		-- Metal Gunk
		self:RegisterEngageMob("MetalGunkEngaged", 236033)
		self:Log("SPELL_CAST_SUCCESS", "CorrosiveGunk", 1215412)
		self:Death("MetalGunkDeath", 236033)
	else
		-- Living Waste
		self:Log("SPELL_CAST_START", "VolatileWaste", 294349) -- XXX removed in 11.1
	end

	-- Junkyard D.0.G.
	if isElevenDotOne then
		self:RegisterEngageMob("JunkyardD0GEngaged", 151773)
		self:Log("SPELL_CAST_START", "FieryJaws", 1217819)
		self:Log("SPELL_CAST_SUCCESS", "FieryJawsSuccess", 1217819)
		self:Death("JunkyardD0GDeath", 151773)
	else
		self:Log("SPELL_AURA_APPLIED", "FlamingRefuseApplied", 294180) -- XXX removed in 11.1
	end

	-- Mechagon Tinkerer
	-- TODO Activate Anti-Personnel Squirrel-293854
	self:Log("SPELL_CAST_START", "GigaWallop", 293827)

	-- Anti-Personnel Squirrel
	self:Log("SPELL_CAST_START", "AntiPersonnelSquirrel", 293861)

	-- Defense Bot Mk III / Defense Bot Mk I
	self:RegisterEngageMob("DefenseBotMkIIIEngaged", 144298)
	self:RegisterEngageMob("DefenseBotMkIEngaged", 151649)
	self:Log("SPELL_CAST_SUCCESS", "ArcingZap", 294195)
	self:Log("SPELL_AURA_APPLIED", "ArcingZapApplied", 294195)
	self:Log("SPELL_AURA_APPLIED", "DefenseBotDefensiveCountermeasureApplied", 297133)
	self:Log("SPELL_CAST_START", "ShortOut", 297128)
	self:Death("DefenseBotDeath", 144298, 151649) -- Mk III, Mk I

	-- Blastatron X-80 / Spider Tank
	self:RegisterEngageMob("BlastatronX80Engaged", 151476)
	self:RegisterEngageMob("SpiderTankEngaged", 144296)
	if not isElevenDotOne then
		self:Log("SPELL_CAST_SUCCESS", "LaunchHighExplosiveRockets", 294015) -- XXX passive aura in 11.1, remove
	end
	self:Log("SPELL_CAST_START", "SonicPulse", 293986)
	self:Log("SPELL_CAST_SUCCESS", "CapacitorDischarge", 295169)
	self:Death("BlastatronX80Death", 151476)
	self:Death("SpiderTankDeath", 144296)

	-- Mechagon Mechanic
	self:RegisterEngageMob("MechagonMechanicEngaged", 144295)
	self:Log("SPELL_CAST_START", "TuneUp", 293729)
	self:Log("SPELL_CAST_SUCCESS", "MechagonMechanicOverclock", 293930)
	self:Log("SPELL_AURA_APPLIED", "MechagonMechanicOverclockApplied", 293930)
	self:Death("MechagonMechanicDeath", 144295)

	-- Workshop Defender
	self:RegisterEngageMob("WorkshopDefenderEngaged", 144299)
	self:Log("SPELL_CAST_SUCCESS", "Chainblade", 293670)
	self:Log("SPELL_AURA_APPLIED", "ChainbladeApplied", 293670)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ChainbladeApplied", 293670)
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Shield Generator
	self:Death("WorkshopDefenderDeath", 144299)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

------ Junkyard ------

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
		if t - prev > 1.5 then
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
		if self:Me(guid) then
			self:Say(300188, nil, nil, "Scrap Cannon")
		end
		self:PlaySound(300188, "alarm", nil, name)
	end

	function mod:ScrapCannon(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	end
end

function mod:ShockCoil(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 19.4, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:ShockCoilApplied(args)
	self:CastBar(args.spellId, 6)
end

function mod:WeaponizedCrawlerDeath(args)
	self:ClearNameplate(args.destGUID)
	self:StopBar(CL.cast:format(self:SpellName(300207))) -- Shock Coil
end

-- Slime Elemental

do
	local prev = 0
	function mod:SlimeBolt(args)
		local t = args.time
		if t - prev > 1.5 then
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
	self:Nameplate(args.spellId, 19.5, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ConsumeSuccess(args)
	self:CastBar(args.spellId, 6)
end

function mod:ToxicMonstrosityDeath(args)
	self:StopBar(CL.cast:format(self:SpellName(300687))) -- Consume
	self:ClearNameplate(args.destGUID)
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
		if self:Dispeller("magic", true, args.spellId) and t - prev > 1.5 then
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
	if isOnMe or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		if isOnMe then
			self:Say(args.spellId, nil, nil, "Shrink")
		end
		self:PlaySound(args.spellId, "info", nil, args.destName)
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

------ Workshop ------

-- Bomb Tonk

function mod:BombTonkEngaged(guid)
	self:Nameplate(301088, 2.3, guid) -- Detonate
end

function mod:Detonate(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:DetonateInterrupt(args)
	self:Nameplate(301088, 15.6, args.destGUID)
end

function mod:BombTonkDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Rocket Tonk

function mod:RocketTonkEngaged(guid)
	self:Nameplate(294103, 2.3, guid) -- Rocket Barrage
end

do
	local prev = 0
	function mod:RocketBarrage(args)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:RocketTonkDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Waste Processing Unit

function mod:WasteProcessingUnitEngaged(guid)
	self:Nameplate(1215411, 2.9, guid) -- Puncture
	self:Nameplate(1215409, 7.2, guid) -- Mega Drill
end

function mod:MegaDrill(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 18.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Puncture(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:MegaDrillOld(args) -- XXX removed in 11.1
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ProcessWaste(args) -- XXX removed in 11.1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "info")
end

function mod:WasteProcessingUnitDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Metal Gunk

function mod:MetalGunkEngaged(guid)
	self:Nameplate(1215412, 10.8, guid) -- Corrosive Gunk
end

do
	local prev = 0
	function mod:CorrosiveGunk(args)
		self:Nameplate(args.spellId, 19.4, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:MetalGunkDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Living Waste

do
	local prev = 0
	function mod:VolatileWaste(args) -- XXX removed in 11.1
		if args.time - prev > 5 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Junkyard D.0.G.

function mod:JunkyardD0GEngaged(guid)
	self:Nameplate(1217819, 5.0, guid) -- Fiery Jaws
end

do
	local prev = 0
	function mod:FieryJaws(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:FieryJawsSuccess(args)
	self:Nameplate(args.spellId, 10.1, args.sourceGUID)
end

function mod:FlamingRefuseApplied(args) -- XXX removed in 11.1
	if self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:JunkyardD0GDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mechagon Tinkerer

do
	local prev = 0
	function mod:GigaWallop(args)
		-- no cooldown on this cast
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end


-- Anti-Personnel Squirrel

function mod:AntiPersonnelSquirrel(args)
	if self:Friendly(args.sourceFlags) then -- can be summoned by a Priest mind-controlling a Mechagon Tinkerer
		self:Message(args.spellId, "green")
	else
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Defense Bot Mk III

function mod:DefenseBotMkIIIEngaged(guid)
	-- Defensive Countermeasure cast at low HP
	self:Nameplate(294195, 4.6, guid) -- Arcing Zap
	self:Nameplate(297128, 10.8, guid) -- Short Out
end

function mod:DefenseBotMkIEngaged(guid)
	self:Nameplate(294195, 4.6, guid) -- Arcing Zap
end

function mod:ArcingZap(args)
	self:Nameplate(args.spellId, 16.0, args.sourceGUID)
end

do
	local playerList = {}
	local prev = 0
	function mod:ArcingZapApplied(args)
		if self:Dispeller("magic", nil, args.spellId) then
			if args.time - prev > .5 then -- throttle alerts to .5s intervals
				prev = args.time
				playerList = {}
			end
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "yellow", playerList, 3, nil, nil, .5) -- three bots that can all cast at the same time
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end

function mod:DefenseBotDefensiveCountermeasureApplied(args)
	-- just cast once at 30% HP
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:ShortOut(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 26.7, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:DefenseBotDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Blastatron X-80 / Spider Tank

function mod:BlastatronX80Engaged(guid)
	self:Nameplate(293986, 2.1, guid) -- Sonic Pulse
	self:Nameplate(295169, 17.9, guid) -- Capacitor Discharge
end

function mod:SpiderTankEngaged(guid)
	self:Nameplate(293986, 5.7, guid) -- Sonic Pulse
end

function mod:LaunchHighExplosiveRockets(args) -- XXX passive aura in 11.1, remove
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

function mod:SonicPulse(args)
	self:Message(args.spellId, "red")
	if self:MobId(args.sourceGUID) == 151476 then -- Blastatron X-80
		self:Nameplate(args.spellId, 5.2, args.sourceGUID)
	else -- 144296, Spider Tank
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:CapacitorDischarge(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 27.9, args.sourceGUID)
	self:Bar(args.spellId, 4, CL.count:format(args.spellName, 1))
	self:Bar(args.spellId, 8, CL.count:format(args.spellName, 2))
	self:Bar(args.spellId, 12, CL.count:format(args.spellName, 3))
	self:PlaySound(args.spellId, "long")
end

function mod:BlastatronX80Death(args)
	self:ClearNameplate(args.destGUID)
	local capacitorDischarge = self:SpellName(295169)
	self:StopBar(CL.count:format(capacitorDischarge, 1))
	self:StopBar(CL.count:format(capacitorDischarge, 2))
	self:StopBar(CL.count:format(capacitorDischarge, 3))
end

function mod:SpiderTankDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mechagon Mechanic

function mod:MechagonMechanicEngaged(guid)
	self:Nameplate(293729, 8.4, guid) -- Tune Up
	if self:Dispeller("enrage", true, 293930) then
		self:Nameplate(293930, 15.0, guid) -- Overclock
	end
end

function mod:TuneUp(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 20.6, args.sourceGUID) -- TODO confirm CD starts here
	self:PlaySound(args.spellId, "alert")
end

function mod:MechagonMechanicOverclock(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Nameplate(args.spellId, 15.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:MechagonMechanicOverclockApplied(args)
		-- applies to all nearby bots
		if self:Dispeller("enrage", true, args.spellId) and args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:MechagonMechanicDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Workshop Defender

function mod:WorkshopDefenderEngaged(guid)
	self:Nameplate(293683, 3.4, guid) -- Shield Generator
	self:Nameplate(293670, 16.0, guid) -- Chainblade
end

function mod:Chainblade(args)
	self:Nameplate(args.spellId, 16.9, args.sourceGUID)
end

function mod:ChainbladeApplied(args)
	self:StackMessage(args.spellId, "red", args.destName, args.amount, 1)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

do
	local prevCast, prev = nil, 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, castGUID, spellId)
		if spellId == 293683 and castGUID ~= prevCast then -- Shield Generator
			local t = GetTime()
			prevCast = castGUID
			local unitGUID = self:UnitGUID(unit)
			if unitGUID then
				self:Nameplate(spellId, 21.8, unitGUID)
			end
			if t - prev > 3 then
				prev = t
				self:Message(spellId, "green")
				self:PlaySound(spellId, "info")
			end
		end
	end
end

function mod:WorkshopDefenderDeath(args)
	self:ClearNameplate(args.destGUID)
end
