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
	L.venture_co_war_machine = "Venture Co. War Machine"
	L.crawler_mine = "Crawler Mine"
	L.ordnance_specialist = "Ordnance Specialist"

	L["1217279_desc"] = 1217280 -- Uppercut, 1217279 has no description
	L["1214751_desc"] = 1214752 -- Brutal Charge, 1214752 has a better description
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Refreshment Vendor
		{280604, "DISPEL", "NAMEPLATE"}, -- Iced Spritzer
		-- Mech Jockey
		267433, -- Activate Mech
		{267980, "NAMEPLATE", "OFF"}, -- Grease Gun
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
		{263215, "NAMEPLATE"}, -- Tectonic Barrier
		-- Taskmaster Askari
		{1214754, "NAMEPLATE"}, -- Massive Slam
		{1213139, "DISPEL", "NAMEPLATE"}, -- Overtime!
		{1214751, "ME_ONLY", "NAMEPLATE"}, -- Brutal Charge
		-- Weapons Tester
		{268846, "NAMEPLATE"}, -- Echo Blade
		-- Venture Co. Mastermind
		{473304, "NAMEPLATE"}, -- Brainstorm
		{262794, "ME_ONLY"}, -- Mind Lash
		-- Venture Co. Alchemist
		{268797, "DISPEL", "NAMEPLATE"}, -- Transmute: Enemy to Goo
		-- Venture Co. War Machine
		{269429, "NAMEPLATE"}, -- Charged Shot
		{262383, "NAMEPLATE"}, -- Deploy Crawler Mine
		-- Crawler Mine
		{262377, "ME_ONLY", "NAMEPLATE"}, -- Seek and Destroy
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
	}, {
		[262377] = CL.fixate, -- Seek and Destroy (Fixate)
	}
end

function mod:OnBossEnable()
	-- Warmup
	self:Log("SPELL_CAST_START", "PonyUp", 267546)

	-- Refreshment Vendor
	self:RegisterEngageMob("RefreshmentVendorEngaged", 136470)
	self:Log("SPELL_CAST_START", "IcedSpritzer", 280604)
	self:Log("SPELL_INTERRUPT", "IcedSpritzerInterrupt", 280604)
	self:Log("SPELL_CAST_SUCCESS", "IcedSpritzerSuccess", 280604)
	self:Log("SPELL_AURA_APPLIED", "IcedSpritzerApplied", 280604)
	self:Death("RefreshmentVendorDeath", 136470)

	-- Mech Jockey
	self:Log("SPELL_CAST_START", "ActivateMech", 267433) --  Heroic and Mythic only
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Grease Gun

	-- Mechanized Peacekeeper
	self:RegisterEngageMob("MechanizedPeacekeeperEngaged", 130485, 136139) -- Mech Jockey summon, regular
	self:Log("SPELL_CAST_START", "ChargedShield", 263628)
	self:Log("SPELL_CAST_START", "TearGas", 472041) -- Heroic and Mythic only
	self:Log("SPELL_PERIODIC_DAMAGE", "TearGasDamage", 1217283) -- Heroic and Mythic only
	self:Log("SPELL_PERIODIC_MISSED", "TearGasDamage", 1217283) -- Heroic and Mythic only
	self:Death("MechanizedPeacekeeperDeath", 130485, 136139) -- Mech Jockey summon, regular

	-- Addled Thug
	self:RegisterEngageMob("AddledThugEngaged", 130435)
	self:Log("SPELL_CAST_SUCCESS", "InhaleVapors", 262092)
	self:Log("SPELL_AURA_APPLIED", "InhaleVaporsApplied", 262092)
	self:Log("SPELL_CAST_START", "Uppercut", 1217279)
	self:Death("AddledThugDeath", 130435)

	-- Hired Assassin
	self:RegisterEngageMob("HiredAssassinEngaged", 134232)
	self:Log("SPELL_CAST_START", "ToxicBlades", 269302)
	self:Log("SPELL_INTERRUPT", "ToxicBladesInterrupt", 269302)
	self:Log("SPELL_CAST_SUCCESS", "ToxicBladesSuccess", 269302)
	self:Log("SPELL_CAST_SUCCESS", "FanOfKnives", 267354)
	self:Death("HiredAssassinDeath", 134232)

	-- Azerite Extractor
	self:RegisterEngageMob("AzeriteExtractorEngaged", 136643)
	self:Log("SPELL_CAST_START", "RapidExtraction", 473168)
	self:Log("SPELL_CAST_START", "Puncture", 1215411)
	self:Death("AzeriteExtractorDeath", 136643)

	-- Venture Co. Earthshaper
	self:RegisterEngageMob("VentureCoEarthshaperEngaged", 130661)
	self:Log("SPELL_CAST_START", "RockLance", 263202)
	self:Log("SPELL_INTERRUPT", "RockLanceInterrupt", 263202)
	self:Log("SPELL_CAST_SUCCESS", "RockLanceSuccess", 263202)
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
	self:Log("SPELL_CAST_START", "TectonicBarrier", 263215) -- Heroic and Mythic only
	self:Log("SPELL_INTERRUPT", "TectonicBarrierInterrupt", 263215) -- Heroic and Mythic only
	self:Log("SPELL_CAST_SUCCESS", "TectonicBarrierSuccess", 263215) -- Heroic and Mythic only
	self:Death("StonefuryDeath", 130635)

	-- Taskmaster Askari
	self:RegisterEngageMob("TaskmasterAskariEngaged", 134012)
	self:Log("SPELL_CAST_START", "MassiveSlam", 1214754)
	self:Log("SPELL_CAST_SUCCESS", "Overtime", 1213139)
	self:Log("SPELL_AURA_APPLIED", "OvertimeApplied", 1213139)
	self:Log("SPELL_AURA_APPLIED_DOSE", "OvertimeApplied", 1213139)
	self:Log("SPELL_CAST_SUCCESS", "BrutalCharge", 1214751)
	self:Death("TaskmasterAskariDeath", 134012)

	-- Weapons Tester
	self:RegisterEngageMob("WeaponsTesterEngaged", 136934)
	self:Log("SPELL_CAST_START", "EchoBlade", 268846)
	self:Log("SPELL_CAST_SUCCESS", "EchoBladeSuccess", 268846)
	self:Death("WeaponsTesterDeath", 136934)

	-- Venture Co. Mastermind
	self:RegisterEngageMob("VentureCoMastermindEngaged", 133430)
	self:Log("SPELL_CAST_SUCCESS", "Brainstorm", 473304)
	self:Log("SPELL_CAST_START", "MindLash", 262794)
	self:Death("VentureCoMastermindDeath", 133430)

	-- Venture Co. Alchemist
	self:RegisterEngageMob("VentureCoAlchemistEngaged", 133432)
	self:Log("SPELL_CAST_START", "TransmuteEnemyToGoo", 268797)
	self:Log("SPELL_INTERRUPT", "TransmuteEnemyToGooInterrupt", 268797)
	self:Log("SPELL_CAST_SUCCESS", "TransmuteEnemyToGooSuccess", 268797)
	self:Log("SPELL_AURA_APPLIED", "TransmuteEnemyToGooApplied", 268797)
	self:Death("VentureCoAlchemistDeath", 133432)

	-- Venture Co. War Machine
	self:RegisterEngageMob("VentureCoWarMachineEngaged", 133463)
	self:Log("SPELL_CAST_START", "ChargedShot", 269429)
	self:Log("SPELL_CAST_START", "DeployCrawlerMine", 262383)
	self:Death("VentureCoWarMachineDeath", 133463)

	-- Crawler Mine
	self:Log("SPELL_AURA_APPLIED", "SeekAndDestroyApplied", 262377)
	self:Log("SPELL_AURA_REMOVED", "SeekAndDestroyRemoved", 262377)

	-- Ordnance Specialist
	self:RegisterEngageMob("OrdnanceSpecialistEngaged", 137029)
	self:Log("SPELL_CAST_SUCCESS", "ArtilleryBarrage", 269090)
	self:Death("OrdnanceSpecialistDeath", 137029)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

do
	local prev = 0
	function mod:PonyUp(args)
		-- cast twice as part of Coin-Operated Crowd Pummeler's warmup RP
		if args.time - prev > 30 then
			prev = args.time
			local crowdPummelerModule = BigWigs:GetBossModule("Coin-Operated Crowd Pummeler", true)
			if crowdPummelerModule then
				crowdPummelerModule:Enable()
				crowdPummelerModule:Warmup()
			end
		end
	end
end

-- Refreshment Vendor

function mod:RefreshmentVendorEngaged(guid)
	self:Nameplate(280604, 8.3, guid) -- Iced Spritzer
end

do
	local prev = 0
	function mod:IcedSpritzer(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
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

function mod:RefreshmentVendorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mech Jockey

do
	local prev = 0
	function mod:ActivateMech(args) -- Heroic and Mythic only
		-- if there is no Mech to activate nearby, this will not be cast
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local prev = 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if spellId == 267980 then -- Grease Gun
			local sourceGUID = self:UnitGUID(unit)
			if sourceGUID then
				self:Nameplate(spellId, 4.8, sourceGUID)
			end
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:Message(spellId, "yellow")
				self:PlaySound(spellId, "info")
			end
		end
	end
end

-- Mechanized Peacekeeper

function mod:MechanizedPeacekeeperEngaged(guid)
	if self:Normal() then
		self:Nameplate(263628, 2.2, guid) -- Charged Shield
	else -- Heroic, Mythic
		self:Nameplate(472041, 9.2, guid) -- Tear Gas
		self:Nameplate(263628, 16.5, guid) -- Charged Shield
	end
end

function mod:ChargedShield(args)
	self:Message(args.spellId, "purple")
	if self:Normal() then
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	else -- Heroic, Mythic
		self:Nameplate(args.spellId, 26.3, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:TearGas(args) -- Heroic and Mythic only
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 19.4, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:TearGasDamage(args) -- Heroic and Mythic only
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
	self:Nameplate(1217279, 15.7, guid) -- Uppercut
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
	local function printTarget(self, name)
		self:TargetMessage(1217279, "yellow", name)
		self:PlaySound(1217279, "alarm", nil, name)
	end

	function mod:Uppercut(args)
		self:Nameplate(args.spellId, 21.9, args.sourceGUID)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
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
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:ToxicBladesInterrupt(args)
	self:Nameplate(269302, 24.2, args.destGUID)
end

function mod:ToxicBladesSuccess(args)
	self:Nameplate(args.spellId, 24.2, args.sourceGUID)
end

do
	local prev = 0
	function mod:FanOfKnives(args)
		self:Nameplate(args.spellId, 20.3, args.sourceGUID)
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
	self:Nameplate(1215411, 9.1, guid) -- Puncture
	self:Nameplate(473168, 14.8, guid) -- Rapid Extraction
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

function mod:AzeriteExtractorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Earthshaper

function mod:VentureCoEarthshaperEngaged(guid)
	self:Nameplate(263202, 8.3, guid) -- Rock Lance
end

do
	local prev = 0
	function mod:RockLance(args)
		if self:Normal() then
			-- cooldown on cast start in Normal only
			self:Nameplate(args.spellId, 24.2, args.sourceGUID)
		else -- Heroic, Mythic
			self:Nameplate(args.spellId, 0, args.sourceGUID)
		end
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:RockLanceInterrupt(args)
	if not self:Normal() then
		self:Nameplate(263202, 4.3, args.destGUID)
	end
end

function mod:RockLanceSuccess(args)
	if not self:Normal() then
		self:Nameplate(args.spellId, 4.3, args.sourceGUID)
	end
end

function mod:VentureCoEarthshaperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Wanton Sapper

function mod:WantonSapperEngaged(guid)
	self:Nameplate(268362, 3.8, guid) -- Mining Charge
end

do
	local prev = 0
	function mod:MiningCharge(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) then
			self:Nameplate(args.spellId, 15.4, args.sourceGUID)
			if args.time - prev > 2 then
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
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local prev = 0
	function mod:BagOfBombsRemoved(args)
		if args.time - prev > 2 then
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
	if self:Normal() then
		self:Nameplate(268702, 5.2, guid) -- Furious Quake
	else -- Heroic, Mythic
		self:Nameplate(263215, 4.7, guid) -- Tectonic Barrier
		self:Nameplate(268702, 9.5, guid) -- Furious Quake
	end
end

do
	local prev = 0
	function mod:FuriousQuake(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:FuriousQuakeInterrupt(args)
	if self:Normal() then
		self:Nameplate(268702, 17.7, args.destGUID)
	else -- Heroic, Mythic
		self:Nameplate(268702, 24.8, args.destGUID)
	end
end

function mod:FuriousQuakeSuccess(args)
	if self:Normal() then
		self:Nameplate(args.spellId, 17.7, args.sourceGUID)
	else -- Heroic, Mythic
		self:Nameplate(args.spellId, 24.8, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:TectonicBarrier(args) -- Heroic and Mythic only
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:TectonicBarrierInterrupt(args) -- Heroic and Mythic only
	self:Nameplate(263215, 20.5, args.destGUID)
end

function mod:TectonicBarrierSuccess(args) -- Heroic and Mythic only
	self:Nameplate(args.spellId, 20.5, args.sourceGUID)
end

function mod:StonefuryDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Taskmaster Askari

do
	local timer

	function mod:TaskmasterAskariEngaged(guid)
		if self:Dispeller("enrage", true, 1213139) then
			self:CDBar(1213139, 7.8) -- Overtime!
			self:Nameplate(1213139, 7.8, guid) -- Overtime!
		end
		self:CDBar(1214751, 10.7) -- Brutal Charge
		self:Nameplate(1214751, 10.7, guid) -- Brutal Charge
		self:CDBar(1214754, 11.5) -- Massive Slam
		self:Nameplate(1214754, 11.5, guid) -- Massive Slam
		timer = self:ScheduleTimer("TaskmasterAskariDeath", 20, nil, guid)
	end

	function mod:MassiveSlam(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 18.2)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		timer = self:ScheduleTimer("TaskmasterAskariDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:Overtime(args)
		if timer then
			self:CancelTimer(timer)
		end
		if self:Dispeller("enrage", true, args.spellId) then
			self:CDBar(args.spellId, 14.6)
			self:Nameplate(args.spellId, 14.6, args.sourceGUID)
		end
		timer = self:ScheduleTimer("TaskmasterAskariDeath", 30, nil, args.sourceGUID)
	end

	function mod:OvertimeApplied(args)
		-- caps at 10 stacks
		local amount = args.amount or 1
		if (amount % 2 == 1 or amount == 10) and self:Dispeller("enrage", true, args.spellId) and self:MobId(args.destGUID) == 134012 then -- Taskmaster Askari
			self:Message(args.spellId, "yellow", CL.stack:format(amount, args.spellName, args.destName))
			self:PlaySound(args.spellId, "info")
		end
	end

	function mod:BrutalCharge(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:TargetMessage(args.spellId, "red", args.destName)
		self:CDBar(args.spellId, 18.2)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		timer = self:ScheduleTimer("TaskmasterAskariDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end

	function mod:TaskmasterAskariDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1213139) -- Overtime!
		self:StopBar(1214751) -- Brutal Charge
		self:StopBar(1214754) -- Massive Slam
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Weapons Tester

function mod:WeaponsTesterEngaged(guid)
	self:Nameplate(268846, 4.6, guid) -- Echo Blade
end

do
	local prev = 0
	function mod:EchoBlade(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:EchoBladeSuccess(args)
	self:Nameplate(args.spellId, 16.5, args.sourceGUID)
end

function mod:WeaponsTesterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Mastermind

function mod:VentureCoMastermindEngaged(guid)
	self:Nameplate(473304, 11.2, guid) -- Brainstorm
end

function mod:Brainstorm(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 16.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, name)
		self:TargetMessage(262794, "yellow", name)
		self:PlaySound(262794, "info", nil, name)
	end

	function mod:MindLash(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
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
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:TransmuteEnemyToGooInterrupt(args)
	self:Nameplate(268797, 24.2, args.destGUID)
end

function mod:TransmuteEnemyToGooSuccess(args)
	self:Nameplate(args.spellId, 24.2, args.sourceGUID)
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

-- Venture Co. War Machine

function mod:VentureCoWarMachineEngaged(guid)
	self:Nameplate(269429, 6.8, guid) -- Charged Shot
	self:Nameplate(262383, 17.8, guid) -- Deploy Crawler Mine
end

do
	local prev = 0
	function mod:ChargedShot(args)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:DeployCrawlerMine(args)
		self:Nameplate(args.spellId, 35.3, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:VentureCoWarMachineDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Crawler Mine

do
	local prev = 0
	function mod:SeekAndDestroyApplied(args)
		self:TargetMessage(args.spellId, "yellow", args.destName)
		if self:Me(args.destGUID) then
			self:Nameplate(args.spellId, 60, args.sourceGUID, CL.fixate)
			if args.time - prev > 2 then
				prev = args.time
				self:PlaySound(args.spellId, "info")
			end
		end
	end
end

function mod:SeekAndDestroyRemoved(args)
	if self:Me(args.destGUID) then
		self:StopNameplate(args.spellId, args.sourceGUID, CL.fixate)
	end
end

-- Ordnance Specialist

function mod:OrdnanceSpecialistEngaged(guid)
	self:Nameplate(269090, 0.7, guid) -- Artillery Barrage
end

do
	local prev = 0
	function mod:ArtilleryBarrage(args)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:OrdnanceSpecialistDeath(args)
	self:ClearNameplate(args.destGUID)
end
