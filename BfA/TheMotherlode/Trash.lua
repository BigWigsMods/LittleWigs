local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The MOTHERLODE!! Trash", 1594)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	130436, -- Off-Duty Laborer
	136470, -- Refreshment Vendor
	130488, -- Mech Jockey
	130485, -- Mechanized Peacekeeper (activated by Mech Jockey)
	136139, -- Mechanized Peacekeeper
	130435, -- Addled Thug
	134232, -- Hired Assassin
	136643, -- Azerite Extractor
	130661, -- Venture Co. Earthshaper
	130653, -- Wanton Sapper
	130635, -- Stonefury
	134012, -- Taskmaster Askari
	136934, -- Weapons Tester
	133430, -- Venture Co. Mastermind
	133432, -- Venture Co. Alchemist
	133345, -- Feckless Assistant XXX removed in 11.1
	133593, -- Expert Technician XXX removed in 11.1
	133463, -- Venture Co. War Machine
	133482, -- Crawler Mine (in the ground)
	235631, -- Crawler Mine (summoned by Venture Co. War Machine)
	137029 -- Ordnance Specialist
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.refreshment_vendor = "Refreshment Vendor"
	L.mech_jockey = "Mech Jockey"
	L.mechanized_peacekeeper = "Mechanized Peacekeeper"
	L.addled_thug = "Addled Thug"
	L.hired_assassin = "Hired Assassin"
	L.azerite_extractor = "Azerite Extractor"
	L.venture_co_earthshaper = "Venture Co. Earthshaper"
	L.wanton_sapper = "Wanton Sapper"
	L.stonefury = "Stonefury"
	L.taskmaster_askari = "Taskmaster Askari"
	L.weapons_tester = "Weapons Tester"
	L.venture_co_mastermind = "Venture Co. Mastermind"
	L.venture_co_alchemist = "Venture Co. Alchemist"
	L.assistant = "Feckless Assistant" -- XXX removed in 11.1
	L.technician = "Expert Technician" -- XXX removed in 11.1
	L.venture_co_war_machine = "Venture Co. War Machine"
	L.crawler_mine = "Crawler Mine"
	L.ordnance_specialist = "Ordnance Specialist"
end

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotOne then
	function mod:GetOptions()
		return {
			-- Refreshment Vendor
			{280604, "DISPEL", "NAMEPLATE"}, -- Iced Spritzer
			-- Mech Jockey
			267433, -- Activate Mech
			-- Mechanized Peacekeeper
			{263628, "NAMEPLATE"}, -- Charged Shield
			{472041, "NAMEPLATE"}, -- Tear Gas
			-- Addled Thug
			{262092, "DISPEL", "NAMEPLATE"}, -- Inhale Vapors
			{1217279, "NAMEPLATE"}, -- Uppercut
			-- Hired Assassin
			{269302, "NAMEPLATE"}, -- Toxic Blades
			{267354, "NAMEPLATE"}, -- Fan of Knives
			-- Azerite Extractor
			{473168, "NAMEPLATE"}, -- Rapid Extraction
			{1215411, "TANK", "NAMEPLATE"}, -- Puncture
			-- Venture Co. Earthshaper
			{263202, "NAMEPLATE"}, -- Rock Lance
			-- Wanton Sapper
			{268362, "NAMEPLATE"}, -- Mining Charge
			269313, -- Final Blast
			268712, -- Bag of Bombs
			-- Stonefury
			{268702, "NAMEPLATE"}, -- Furious Quake
			-- Taskmaster Askari
			{1214754, "NAMEPLATE"}, -- Massive Slam
			{1213139, "DISPEL", "NAMEPLATE"}, -- Overtime!
			-- Weapons Tester
			{268846, "NAMEPLATE"}, -- Echo Blade
			-- Venture Co. Mastermind
			{473304, "NAMEPLATE"}, -- Brainstorm
			-- Venture Co. Alchemist
			{268797, "DISPEL", "NAMEPLATE"}, -- Transmute: Enemy to Goo
			-- Venture Co. War Machine
			{269429, "TANK", "NAMEPLATE"}, -- Charged Shot
			{262383, "NAMEPLATE"}, -- Deploy Crawler Mine
			-- Crawler Mine
			{262377, "ME_ONLY"}, -- Seek and Destroy
			-- Ordnance Specialist
			{269090, "NAMEPLATE"}, -- Artillery Barrage
		}, {
			[280604] = L.refreshment_vendor,
			[267433] = L.mech_jockey,
			[263628] = L.mechanized_peacekeeper,
			[262092] = L.addled_thug,
			[269302] = L.hired_assassin,
			[473168] = L.azerite_extractor,
			[263202] = L.venture_co_earthshaper,
			[268362] = L.wanton_sapper,
			[268702] = L.stonefury,
			[1214754] = L.taskmaster_askari,
			[268846] = L.weapons_tester,
			[473304] = L.venture_co_mastermind,
			[268797] = L.venture_co_alchemist,
			[269429] = L.venture_co_war_machine,
			[262377] = L.crawler_mine,
			[269090] = L.ordnance_specialist,
		}
	end
else -- XXX remove block below when 11.1 is live
	function mod:GetOptions()
		return {
			-- Refreshment Vendor
			{280604, "DISPEL", "NAMEPLATE"}, -- Iced Spritzer
			280605, -- Brain Freeze
			268129, -- Kaja'Cola Refresher
			-- Mech Jockey
			267433, -- Activate Mech
			281621, -- Concussion Charge
			-- Mechanized Peacekeeper
			{263628, "NAMEPLATE"}, -- Charged Shield
			-- Addled Thug
			{262092, "DISPEL", "NAMEPLATE"}, -- Inhale Vapors
			-- Hired Assassin
			{269302, "NAMEPLATE"}, -- Toxic Blades
			{267354, "NAMEPLATE"}, -- Fan of Knives
			-- Azerite Extractor
			{268415, "TANK"}, -- Power Through
			-- Venture Co. Earthshaper
			{263202, "NAMEPLATE"}, -- Rock Lance
			268709, -- Earth Shield
			-- Wanton Sapper
			{268362, "NAMEPLATE"}, -- Mining Charge
			269313, -- Final Blast
			268712, -- Bag of Bombs
			-- Stonefury
			{268702, "NAMEPLATE"}, -- Furious Quake
			263215, -- Tectonic Barrier
			-- Taskmaster Askari
			{263601, "TANK"}, -- Desperate Measures
			-- Weapons Tester
			{268846, "NAMEPLATE"}, -- Echo Blade
			268865, -- Force Cannon
			-- Venture Co. Mastermind
			262947, -- Azerite Injection
			-- Venture Co. Alchemist
			{268797, "DISPEL", "NAMEPLATE"}, -- Transmute: Enemy to Goo
			-- Feckless Assistant
			263066, -- Transfiguration Serum
			263103, -- Blowtorch
			-- Expert Technician
			262540, -- Overcharge
			262554, -- Repair
			-- Venture Co. War Machine
			{269429, "TANK", "NAMEPLATE"}, -- Charged Shot
			{262383, "NAMEPLATE"}, -- Deploy Crawler Mine
			-- Crawler Mine
			{262377, "ME_ONLY"}, -- Seek and Destroy
			-- Ordnance Specialist
			{269090, "NAMEPLATE"}, -- Artillery Barrage
		}, {
			[280604] = L.refreshment_vendor,
			[267433] = L.mech_jockey,
			[263628] = L.mechanized_peacekeeper,
			[262092] = L.addled_thug,
			[269302] = L.hired_assassin,
			[268415] = L.azerite_extractor,
			[263202] = L.venture_co_earthshaper,
			[268362] = L.wanton_sapper,
			[268702] = L.stonefury,
			[263601] = L.taskmaster_askari,
			[268846] = L.weapons_tester,
			[262947] = L.venture_co_mastermind,
			[268797] = L.venture_co_alchemist,
			[263066] = L.assistant,
			[262540] = L.technician,
			[269429] = L.venture_co_war_machine,
			[262377] = L.crawler_mine,
			[269090] = L.ordnance_specialist,
		}
	end
end

function mod:OnBossEnable()
	-- Refreshment Vendor
	if isElevenDotOne then
		self:RegisterEngageMob("RefreshmentVendorEngaged", 136470)
	end
	self:Log("SPELL_CAST_START", "IcedSpritzer", 280604)
	if isElevenDotOne then
		self:Log("SPELL_INTERRUPT", "IcedSpritzerInterrupt", 280604)
		self:Log("SPELL_CAST_SUCCESS", "IcedSpritzerSuccess", 280604)
		self:Log("SPELL_AURA_APPLIED", "IcedSpritzerApplied", 280604)
		self:Death("RefreshmentVendorDeath", 136470)
	else -- XXX remove in 11.1
		self:Log("SPELL_CAST_START", "KajaColaRefresher", 268129) -- XXX removed in 11.1
		self:Log("SPELL_AURA_APPLIED", "BrainFreezeApplied", 280605) -- XXX removed in 11.1
	end

	-- Mech Jockey
	--self:RegisterEngageMob("MechJockeyEngaged", 130488)
	self:Log("SPELL_CAST_START", "ActivateMech", 267433)
	self:Log("SPELL_CAST_SUCCESS", "ActivateMechSuccess", 267433)
	if not isElevenDotOne then
		self:Log("SPELL_CAST_START", "ConcussionCharge", 281621) -- XXX removed in 11.1
	end
	--self:Death("MechJockeyDeath", 130488)

	-- Mechanized Peacekeeper
	self:RegisterEngageMob("MechanizedPeacekeeperEngaged", 130485, 136139) -- Mech Jockey summon, regular
	self:Log("SPELL_CAST_START", "ChargedShield", 263628)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "TearGas", 472041)
		self:Log("SPELL_PERIODIC_DAMAGE", "TearGasDamage", 1217283)
		self:Log("SPELL_PERIODIC_MISSED", "TearGasDamage", 1217283)
	end
	self:Death("MechanizedPeacekeeperDeath", 130485, 136139) -- Mech Jockey summon, regular

	-- Addled Thug
	self:RegisterEngageMob("AddledThugEngaged", 130435)
	if not isElevenDotOne then
		self:Log("SPELL_CAST_START", "InhaleVaporsStart", 262092) -- XXX not interruptible in 11.1, remove
	end
	self:Log("SPELL_CAST_SUCCESS", "InhaleVapors", 262092)
	self:Log("SPELL_AURA_APPLIED", "InhaleVaporsApplied", 262092)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "Uppercut", 1217279)
	end
	self:Death("AddledThugDeath", 130435)

	-- Hired Assassin
	self:RegisterEngageMob("HiredAssassinEngaged", 134232)
	self:Log("SPELL_CAST_START", "ToxicBlades", 269302)
	self:Log("SPELL_CAST_SUCCESS", "FanOfKnives", 267354)
	self:Death("HiredAssassinDeath", 134232)

	-- Azerite Extractor
	if isElevenDotOne then
		self:RegisterEngageMob("AzeriteExtractorEngaged", 136643)
		self:Log("SPELL_CAST_START", "RapidExtraction", 473168)
		self:Log("SPELL_CAST_START", "Puncture", 1215411)
		self:Death("AzeriteExtractorDeath", 136643)
	else -- XXX remove block in 11.1
		self:Log("SPELL_CAST_SUCCESS", "PowerThrough", 268415) -- XXX removed in 11.1
	end

	-- Venture Co. Earthshaper
	self:RegisterEngageMob("VentureCoEarthshaperEngaged", 130661)
	self:Log("SPELL_CAST_START", "RockLance", 263202)
	self:Log("SPELL_INTERRUPT", "RockLanceInterrupt", 263202)
	self:Log("SPELL_CAST_SUCCESS", "RockLanceSuccess", 263202)
	self:Log("SPELL_CAST_START", "EarthShield", 268709) -- XXX removed in 11.1
	self:Log("SPELL_AURA_APPLIED", "EarthShieldApplied", 268709) -- XXX removed in 11.1
	self:Death("VentureCoEarthshaperDeath", 130661)

	-- Wanton Sapper
	self:RegisterEngageMob("WantonSapperEngaged", 130653)
	self:Log("SPELL_CAST_START", "FinalBlast", 269313)
	self:Log("SPELL_CAST_SUCCESS", "MiningCharge", 268362)
	self:Log("SPELL_AURA_REMOVED", "BagOfBombsRemoved", 268712)
	self:Death("WantonSapperDeath", 130653)

	-- Stonefury
	self:RegisterEngageMob("StonefuryEngaged", 130635)
	self:Log("SPELL_CAST_START", "FuriousQuake", 268702)
	self:Log("SPELL_INTERRUPT", "FuriousQuakeInterrupt", 268702)
	self:Log("SPELL_CAST_SUCCESS", "FuriousQuakeSuccess", 268702)
	self:Log("SPELL_CAST_START", "TectonicBarrier", 263215) -- XXX removed in 11.1
	self:Log("SPELL_AURA_APPLIED", "TectonicBarrierApplied", 263215) -- XXX removed in 11.1
	self:Death("StonefuryDeath", 130635)

	-- Taskmaster Askari
	if isElevenDotOne then
		self:RegisterEngageMob("TaskmasterAskariEngaged", 134012)
		self:Log("SPELL_CAST_START", "MassiveSlam", 1214754)
		self:Log("SPELL_CAST_SUCCESS", "Overtime", 1213139)
		self:Log("SPELL_AURA_APPLIED", "OvertimeApplied", 1213139)
		self:Log("SPELL_AURA_APPLIED_DOSE", "OvertimeApplied", 1213139)
		self:Death("TaskmasterAskariDeath", 134012)
	else -- XXX remove in 11.1
		self:Log("SPELL_AURA_APPLIED", "DesperateMeasuresApplied", 263601) -- XXX removed in 11.1
	end

	-- Weapons Tester
	self:RegisterEngageMob("WeaponsTesterEngaged", 136934)
	self:Log("SPELL_CAST_START", "EchoBlade", 268846)
	self:Log("SPELL_CAST_START", "ForceCannon", 268865) -- XXX not cast in combat in 11.1
	self:Death("WeaponsTesterDeath", 136934)

	-- Venture Co. Mastermind
	if isElevenDotOne then
		self:RegisterEngageMob("VentureCoMastermindEngaged", 133430)
		self:Log("SPELL_CAST_SUCCESS", "Brainstorm", 473304)
		self:Death("VentureCoMastermindDeath", 133430)
	end
	self:Log("SPELL_AURA_APPLIED", "AzeriteInjectionApplied", 262947) -- XXX removed in 11.1

	-- Venture Co. Alchemist
	self:RegisterEngageMob("VentureCoAlchemistEngaged", 133432)
	self:Log("SPELL_CAST_START", "TransmuteEnemyToGoo", 268797)
	self:Log("SPELL_AURA_APPLIED", "TransmuteEnemyToGooApplied", 268797)
	self:Death("VentureCoAlchemistDeath", 133432)

	-- Feckless Assistant
	self:Log("SPELL_CAST_START", "TransfigurationSerum", 263066) -- XXX removed in 11.1
	self:Log("SPELL_CAST_START", "Blowtorch", 263103) -- XXX removed in 11.1

	-- Expert Technician
	self:Log("SPELL_CAST_START", "Overcharge", 262540) -- XXX removed in 11.1
	self:Log("SPELL_AURA_APPLIED", "OverchargeApplied", 262540) -- XXX removed in 11.1
	self:Log("SPELL_CAST_START", "Repair", 262554) -- XXX removed in 11.1

	-- Venture Co. War Machine
	self:RegisterEngageMob("VentureCoWarMachineEngaged", 133463)
	self:Log("SPELL_CAST_START", "ChargedShot", 269429)
	self:Log("SPELL_CAST_START", "DeployCrawlerMine", 262383)
	self:Death("VentureCoWarMachineDeath", 133463)

	-- Crawler Mine
	self:Log("SPELL_AURA_APPLIED", "SeekAndDestroyApplied", 262377)

	-- Ordnance Specialist
	self:RegisterEngageMob("OrdnanceSpecialistEngaged", 137029)
	self:Log("SPELL_CAST_START", "ArtilleryBarrage", 269090)
	self:Death("OrdnanceSpecialistDeath", 137029)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Refreshment Vendor

function mod:RefreshmentVendorEngaged(guid)
	self:Nameplate(280604, 9.3, guid) -- Iced Spritzer
end

do
	local prev = 0
	function mod:IcedSpritzer(args)
		if isElevenDotOne then
			self:Nameplate(args.spellId, 0, args.sourceGUID)
		end
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:IcedSpritzerInterrupt(args)
	self:Nameplate(280604, 24.9, args.destGUID)
end

function mod:IcedSpritzerSuccess(args)
	self:Nameplate(args.spellId, 24.9, args.sourceGUID)
end

function mod:IcedSpritzerApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:BrainFreezeApplied(args) -- XXX removed in 11.1
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:KajaColaRefresher(args) -- XXX removed in 11.1
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:RefreshmentVendorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mech Jockey

--function mod:MechJockeyEngaged(guid)
	-- if there is no Mech to activate nearby, this NPC does nothing
	--self:Nameplate(267433, 10.7, guid) -- Activate Mech
--end

do
	local prev = 0
	function mod:ActivateMech(args)
		--self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:ActivateMechSuccess(args)
	-- becomes untargetable while piloting the Mechanized Peacekeeper
	self:ClearNameplate(args.sourceGUID)
end

function mod:ConcussionCharge(args) -- XXX removed in 11.1
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

--function mod:MechJockeyDeath(args)
	--self:ClearNameplate(args.destGUID)
--end

-- Mechanized Peacekeeper

function mod:MechanizedPeacekeeperEngaged(guid)
	-- TODO Heroic in 11.1 follows which set of timers?
	if isElevenDotOne and self:Mythic() then
		self:Nameplate(472041, 9.2, guid) -- Tear Gas
		self:Nameplate(263628, 16.5, guid) -- Charged Shield
	else -- Normal
		self:Nameplate(263628, 2.2, guid) -- Charged Shield
	end
end

function mod:ChargedShield(args)
	self:Message(args.spellId, "purple")
	-- TODO Heroic in 11.1 follows which set of timers?
	if self:Mythic() then
		self:Nameplate(args.spellId, 26.3, args.sourceGUID)
	else -- Normal
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:TearGas(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 19.4, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:TearGasDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(472041, "underyou")
			self:PlaySound(472041, "underyou")
		end
	end
end

function mod:MechanizedPeacekeeperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Addled Thug

function mod:AddledThugEngaged(guid)
	if self:Dispeller("enrage", true, 262092) then
		self:Nameplate(262092, 9.0, guid) -- Inhale Vapors
	end
	if isElevenDotOne then
		self:Nameplate(1217279, 15.7, guid) -- Uppercut
	end
end

function mod:InhaleVaporsStart(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:InhaleVapors(args)
	if self:Dispeller("enrage", true, args.spellId) then
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) then
			self:Nameplate(args.spellId, 21.9, args.sourceGUID)
		end
	end
end

function mod:InhaleVaporsApplied(args)
	if self:Dispeller("enrage", true, args.spellId) then
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) then
			self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:Uppercut(args)
		self:Nameplate(args.spellId, 21.9, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:AddledThugDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Hired Assassin

function mod:HiredAssassinEngaged(guid)
	self:Nameplate(269302, 8.1, guid) -- Toxic Blades
	self:Nameplate(267354, 13.0, guid) -- Fan of Knives
end

do
	local prev = 0
	function mod:ToxicBlades(args)
		self:Nameplate(args.spellId, 20.6, args.sourceGUID) -- cooldown on cast start
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local prev = 0
	function mod:FanOfKnives(args)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:HiredAssassinDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Azerite Extractor

function mod:AzeriteExtractorEngaged(guid)
	self:Nameplate(1215411, 9.6, guid) -- Puncture
	self:Nameplate(473168, 15.4, guid) -- Rapid Extraction
end

function mod:RapidExtraction(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 26.7, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:Puncture(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 22.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:PowerThrough(args) -- XXX removed in 11.1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

function mod:AzeriteExtractorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Earthshaper

function mod:VentureCoEarthshaperEngaged(guid)
	self:Nameplate(263202, 8.8, guid) -- Rock Lance
end

do
	local prev = 0
	function mod:RockLance(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:RockLanceInterrupt(args)
	self:Nameplate(263202, 24.3, args.destGUID)
end

function mod:RockLanceSuccess(args)
	self:Nameplate(args.spellId, 24.3, args.sourceGUID)
end

do
	local prev = 0
	function mod:EarthShield(args) -- XXX removed in 11.1
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:EarthShieldApplied(args) -- XXX removed in 11.1
		local t = args.time
		if t-prev > 1.5 and not self:Player(args.destFlags) and self:Dispeller("magic", true) then
			prev = t
			self:Message(args.spellId, "yellow", CL.other:format(args.spellName, args.destName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:VentureCoEarthshaperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Wanton Sapper

function mod:WantonSapperEngaged(guid)
	self:Nameplate(268362, 4.8, guid) -- Mining Charge
end

do
	local prev = 0
	function mod:MiningCharge(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) then
			self:Nameplate(args.spellId, 15.8, args.sourceGUID)
			if args.time - prev > 1.5 then
				prev = args.time
				self:Message(args.spellId, "orange")
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

do
	local prev = 0
	function mod:FinalBlast(args)
		-- cast once at low health
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local prev = 0
	function mod:BagOfBombsRemoved(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:WantonSapperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Stonefury

function mod:StonefuryEngaged(guid)
	self:Nameplate(268702, 5.9, guid) -- Furious Quake
end

function mod:FuriousQuake(args)
	-- TODO might not RP fight anymore in 11.1, but still does in 11.0.7
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:FuriousQuakeInterrupt(args)
	self:Nameplate(268702, 16.9, args.destGUID)
end

function mod:FuriousQuakeSuccess(args)
	self:Nameplate(args.spellId, 16.9, args.sourceGUID)
end

do
	local prev = 0
	function mod:TectonicBarrier(args) -- XXX removed
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning", "interrupt")
		end
	end
end

function mod:TectonicBarrierApplied(args) -- XXX removed
	if not self:Player(args.destFlags) then
		self:Message(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:StonefuryDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Taskmaster Askari

function mod:TaskmasterAskariEngaged(guid)
	self:Nameplate(1214754, 3.8, guid) -- Massive Slam
	if self:Dispeller("enrage", true, 1213139) then
		self:Nameplate(1213139, 9.8, guid) -- Overtime!
	end
end

function mod:MassiveSlam(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Overtime(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Nameplate(args.spellId, 17.8, args.sourceGUID)
	end
end

function mod:OvertimeApplied(args)
	if self:Dispeller("enrage", true, args.spellId) and self:MobId(args.destGUID) == 134012 then -- Taskmaster Askari
		local amount = args.amount or 1
		if amount % 2 == 1 or amount == 10 then -- caps at 10
			self:Message(args.spellId, "yellow", CL.stack:format(amount, args.spellName, args.destName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:DesperateMeasuresApplied(args) -- XXX removed
	if not self:Player(args.destFlags) then
		self:Message(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:TaskmasterAskariDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Weapons Tester

function mod:WeaponsTesterEngaged(guid)
	self:Nameplate(268846, 4.6, guid) -- Echo Blade
end

function mod:EchoBlade(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ForceCannon(args) -- XXX no longer cast in combat, remove
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:WeaponsTesterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Mastermind

function mod:VentureCoMastermindEngaged(guid)
	self:Nameplate(473304, 16.0, guid) -- Brainstorm
end

function mod:Brainstorm(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:AzeriteInjectionApplied(args) -- XXX removed in 11.1
	if not self:Player(args.destFlags) then
		self:Message(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:VentureCoMastermindDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Alchemist

function mod:VentureCoAlchemistEngaged(guid)
	if not self:Solo() then
		self:Nameplate(268797, 7.0, guid) -- Transmute: Enemy to Goo
	end
end

do
	local prev = 0
	function mod:TransmuteEnemyToGoo(args)
		-- not cast if solo, and not cast if only tanks and healers are in range
		self:Nameplate(args.spellId, 20.6, args.sourceGUID) -- cooldown on cast start
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:TransmuteEnemyToGooApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:VentureCoAlchemistDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Feckless Assistant

function mod:TransfigurationSerum(args) -- XXX removed in 11.1
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

function mod:Blowtorch(args) -- XXX removed in 11.1
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

-- Expert Technician

function mod:Overcharge(args) -- XXX removed in 11.1
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

function mod:Repair(args) -- XXX removed in 11.1
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

function mod:OverchargeApplied(args) -- XXX removed in 11.1
	if not self:Player(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Venture Co. War Machine

function mod:VentureCoWarMachineEngaged(guid)
	self:Nameplate(262383, 6.8, guid) -- Deploy Crawler Mine
	self:Nameplate(269429, 7.0, guid) -- Charged Shot
end

function mod:ChargedShot(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:DeployCrawlerMine(args)
	self:Message(args.spellId, "cyan")
	self:Nameplate(args.spellId, 28.0, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:VentureCoWarMachineDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Crawler Mine

function mod:SeekAndDestroyApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

-- Ordnance Specialist

function mod:OrdnanceSpecialistEngaged(guid)
	self:Nameplate(269090, 0.9, guid) -- Artillery Barrage
end

function mod:ArtilleryBarrage(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:OrdnanceSpecialistDeath(args)
	self:ClearNameplate(args.destGUID)
end
