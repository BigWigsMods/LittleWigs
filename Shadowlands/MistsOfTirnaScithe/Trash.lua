--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mists of Tirna Scithe Trash", 2290)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	164929, -- Tirnenn Villager
	164921, -- Drust Harvester
	164920, -- Drust Soulcleaver
	165111, -- Drust Spiteclaw
	164926, -- Drust Boughbreaker
	357703, -- Depleted Anima Seed
	357707, -- Depleted Anima Seed
	163058, -- Mistveil Defender
	171772, -- Mistveil Defender
	173720, -- Mistveil Gorgegullet
	166276, -- Mistveil Guardian
	173655, -- Mistveil Matriarch
	173714, -- Mistveil Nightblossom
	166275, -- Mistveil Shaper
	166301, -- Mistveil Stalker
	166304, -- Mistveil Stinger
	166299, -- Mistveil Tender
	167113, -- Spinemaw Acidgullet
	167111, -- Spinemaw Staghorn
	172312, -- Spinemaw Gorger
	165560, -- Gormling Larva
	167116 -- Spinemaw Reaver
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.tirnenn_villager = "Tirnenn Villager"
	L.drust_harvester = "Drust Harvester"
	L.drust_soulcleaver = "Drust Soulcleaver"
	L.drust_spiteclaw = "Drust Spiteclaw"
	L.drust_boughbreaker = "Drust Boughbreaker"
	L.mistveil_defender = "Mistveil Defender"
	L.mistveil_gorgegullet = "Mistveil Gorgegullet"
	L.mistveil_guardian = "Mistveil Guardian"
	L.mistveil_matriarch = "Mistveil Matriarch"
	L.mistveil_nightblossom = "Mistveil Nightblossom"
	L.mistveil_shaper = "Mistveil Shaper"
	L.mistveil_stalker = "Mistveil Stalker"
	L.mistveil_stinger = "Mistveil Stinger"
	L.mistveil_tender = "Mistveil Tender"
	L.spinemaw_acidgullet = "Spinemaw Acidgullet"
	L.spinemaw_staghorn = "Spinemaw Staghorn"
	L.spinemaw_gorger = "Spinemaw Gorger"
	L.gormling_larva = "Gormling Larva"
	L.spinemaw_reaver = "Spinemaw Reaver"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		-- Tirnenn Villager
		{321968, "NAMEPLATE"}, -- Bewildering Pollen
		{322486, "NAMEPLATE"}, -- Overgrowth
		-- Drust Harvester
		{322938, "NAMEPLATE"}, -- Harvest Essence
		-- Drust Soulcleaver
		{322569, "TANK", "NAMEPLATE"}, -- Hand of Thros
		{322557, "DISPEL", "NAMEPLATE"}, -- Soul Split
		-- Drust Spiteclaw
		322968, -- Dying Breath
		-- Drust Boughbreaker
		324909, -- Furious Thrashing
		{324923, "NAMEPLATE"}, -- Bramble Burst
		-- Mistveil Defender
		{463256, "NAMEPLATE"}, -- Mist Ward
		{463248, "ME_ONLY", "NAMEPLATE"}, -- Expel
		-- Mistveil Gorgegullet
		{340304, "NAMEPLATE"}, -- Poisonous Secretions
		{340305, "NAMEPLATE"}, -- Crushing Leap
		{340300, "NAMEPLATE"}, -- Tongue Lashing
		-- Mistveil Guardian
		{463217, "TANK_HEALER", "NAMEPLATE"}, -- Anima Slash
		-- Mistveil Matriarch
		{340189, "NAMEPLATE"}, -- Pool of Radiance
		{340160, "NAMEPLATE"}, -- Radiant Breath
		{340208, "TANK_HEALER", "NAMEPLATE"}, -- Shred Armor
		-- Mistveil Nightblossom
		{340289, "TANK_HEALER", "NAMEPLATE"}, -- Triple Bite
		{340279, "DISPEL", "NAMEPLATE"}, -- Poisonous Discharge
		-- Mistveil Shaper
		{324776, "NAMEPLATE"}, -- Bramblethorn Coat
		-- Mistveil Stalker
		{325021, "ME_ONLY", "NAMEPLATE"}, -- Mistveil Tear
		-- Mistveil Stinger
		{325224, "SAY", "NAMEPLATE"}, -- Anima Injection
		-- Mistveil Tender
		{324914, "DISPEL", "NAMEPLATE"}, -- Nourish the Forest
		-- Spinemaw Acidgullet
		{325418, "ME_ONLY", "SAY", "NAMEPLATE"}, -- Volatile Acid
		-- Spinemaw Staghorn
		{340544, "NAMEPLATE"}, -- Stimulate Regeneration
		{326046, "DISPEL", "NAMEPLATE"}, -- Stimulate Resistance
		{460092, "NAMEPLATE"}, -- Acid Nova
		-- Spinemaw Gorger
		{326021, "NAMEPLATE"}, -- Acid Globule
		-- Gormling Larva
		326017, -- Decomposing Acid
		-- Spinemaw Reaver
		{326090, "DISPEL", "NAMEPLATE"}, -- Stinging Assault
	}, {
		[autotalk] = CL.general,
		[321968] = L.tirnenn_villager,
		[322938] = L.drust_harvester,
		[322569] = L.drust_soulcleaver,
		[322968] = L.drust_spiteclaw,
		[324909] = L.drust_boughbreaker,
		[463256] = L.mistveil_defender,
		[340304] = L.mistveil_gorgegullet,
		[463217] = L.mistveil_guardian,
		[340189] = L.mistveil_matriarch,
		[340289] = L.mistveil_nightblossom,
		[324776] = L.mistveil_shaper,
		[325021] = L.mistveil_stalker,
		[325224] = L.mistveil_stinger,
		[324914] = L.mistveil_tender,
		[325418] = L.spinemaw_acidgullet,
		[340544] = L.spinemaw_staghorn,
		[326021] = L.spinemaw_gorger,
		[326017] = L.gormling_larva,
		[326090] = L.spinemaw_reaver,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Tirnenn Villager
	self:RegisterEngageMob("TirnennVillagerEngaged", 164929)
	self:Log("SPELL_CAST_START", "BewilderingPollen", 321968)
	self:Log("SPELL_CAST_SUCCESS", "Overgrowth", 322486)
	self:Log("SPELL_AURA_REMOVED", "SoulShackleRemoved", 321952) -- becomes friendly
	self:Death("TirnennVillagerDeath", 164929) -- if you overgear the content

	-- Drust Harvester
	self:RegisterEngageMob("DrustHarvesterEngaged", 164921)
	self:Log("SPELL_CAST_SUCCESS", "HarvestEssence", 322938)
	self:Death("DrustHarvesterDeath", 164921)

	-- Drust Soulcleaver
	self:RegisterEngageMob("DrustSoulcleaverEngaged", 164920)
	self:Log("SPELL_CAST_SUCCESS", "HandOfThros", 322569)
	self:Log("SPELL_AURA_APPLIED", "HandOfThrosApplied", 322569)
	self:Log("SPELL_CAST_START", "SoulSplit", 322557)
	self:Log("SPELL_CAST_SUCCESS", "SoulSplitSuccess", 322557)
	self:Log("SPELL_AURA_APPLIED", "SoulSplitApplied", 322557)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SoulSplitApplied", 322557)
	self:Death("DrustSoulcleaverDeath", 164920)

	-- Drust Spiteclaw
	self:Log("SPELL_CAST_START", "DyingBreath", 322968)

	-- Drust Boughbreaker
	self:RegisterEngageMob("DrustBoughbreakerEngaged", 164926)
	self:Log("SPELL_CAST_START", "FuriousThrashing", 324909)
	self:Log("SPELL_CAST_START", "BrambleBurst", 324923)
	self:Death("DrustBoughbreakerDeath", 164926)

	-- Mistveil Defender
	self:RegisterEngageMob("MistveilDefenderEngaged", 171772, 163058)
	self:Log("SPELL_CAST_START", "MistWard", 463256)
	self:Log("SPELL_PERIODIC_DAMAGE", "MistWardDamage", 463257)
	self:Log("SPELL_PERIODIC_MISSED", "MistWardDamage", 463257)
	self:Log("SPELL_CAST_START", "Expel", 463248)
	self:Death("MistveilDefenderDeath", 171772, 163058)

	-- Mistveil Gorgegullet
	self:RegisterEngageMob("MistveilGorgegulletEngaged", 173720)
	self:Log("SPELL_CAST_START", "PoisonousSecretions", 340304)
	self:Log("SPELL_CAST_SUCCESS", "CrushingLeap", 340305)
	self:Log("SPELL_CAST_START", "TongueLashing", 340300)
	self:Death("MistveilGorgegulletDeath", 173720)

	-- Mistveil Guardian
	self:RegisterEngageMob("MistveilGuardianEngaged", 166276)
	self:Log("SPELL_CAST_START", "AnimaSlash", 463217)
	self:Death("MistveilGuardianDeath", 166276)

	-- Mistveil Matriarch
	self:RegisterEngageMob("MistveilMatriarchEngaged", 173655)
	self:Log("SPELL_CAST_START", "PoolOfRadiance", 340189)
	self:Log("SPELL_CAST_START", "RadiantBreath", 340160)
	self:Log("SPELL_CAST_START", "ShredArmor", 340208)
	self:Death("MistveilMatriarchDeath", 173655)

	-- Mistveil Nightblossom
	self:RegisterEngageMob("MistveilNightblossomEngaged", 173714)
	self:Log("SPELL_CAST_START", "TripleBite", 340289)
	self:Log("SPELL_CAST_SUCCESS", "PoisonousDischarge", 340279)
	self:Log("SPELL_AURA_APPLIED", "PoisonousDischargeApplied", 340283)
	self:Death("MistveilNightblossomDeath", 173714)

	-- Mistveil Shaper
	self:RegisterEngageMob("MistveilShaperEngaged", 166275)
	self:Log("SPELL_CAST_START", "BramblethornCoat", 324776)
	self:Log("SPELL_INTERRUPT", "BramblethornCoatInterrupt", 324776)
	self:Log("SPELL_CAST_SUCCESS", "BramblethornCoatSuccess", 324776)
	self:Death("MistveilShaperDeath", 166275)

	-- Mistveil Stalker
	self:RegisterEngageMob("MistveilStalkerEngaged", 166301)
	self:Log("SPELL_CAST_SUCCESS", "MistveilBite", 324986)
	self:Log("SPELL_AURA_APPLIED", "MistveilTear", 325021)
	self:Death("MistveilStalkerDeath", 166301)

	-- Mistveil Stinger
	self:RegisterEngageMob("MistveilStingerEngaged", 166304)
	self:Log("SPELL_CAST_SUCCESS", "AnimaInjection", 325224)
	self:Log("SPELL_AURA_APPLIED", "AnimaInjectionApplied", 325224)
	self:Death("MistveilStingerDeath", 166304)

	-- Mistveil Tender
	self:RegisterEngageMob("MistveilTenderEngaged", 166299)
	self:Log("SPELL_CAST_START", "NourishTheForest", 324914)
	self:Log("SPELL_INTERRUPT", "NourishTheForestInterrupt", 324914)
	self:Log("SPELL_CAST_SUCCESS", "NourishTheForestSuccess", 324914)
	self:Death("MistveilTenderDeath", 166299)

	-- Spinemaw Acidgullet
	self:RegisterEngageMob("SpinemawAcidgulletEngaged", 167113)
	self:Log("SPELL_CAST_SUCCESS", "VolatileAcidSuccess", 325413)
	self:Log("SPELL_AURA_APPLIED", "VolatileAcidApplied", 325418)
	self:Death("SpinemawAcidgulletDeath", 167113)

	-- Spinemaw Staghorn
	self:RegisterEngageMob("SpinemawStaghornEngaged", 167111)
	self:Log("SPELL_CAST_SUCCESS", "StimulateRegeneration", 340544)
	self:Log("SPELL_CAST_START", "StimulateResistance", 326046)
	self:Log("SPELL_INTERRUPT", "StimulateResistanceInterrupt", 326046)
	self:Log("SPELL_CAST_SUCCESS", "StimulateResistanceSuccess", 326046)
	self:Log("SPELL_CAST_START", "AcidNova", 460092)
	self:Death("SpinemawStaghornDeath", 167111)

	-- Spinemaw Gorger
	self:RegisterEngageMob("SpinemawGorgerEngaged", 172312)
	self:Log("SPELL_CAST_START", "AcidGlobule", 326021)
	self:Log("SPELL_CAST_SUCCESS", "AcidGlobuleSuccess", 326021)
	self:Death("SpinemawGorgerDeath", 172312)

	-- Gormling Larva
	self:Log("SPELL_PERIODIC_DAMAGE", "DecomposingAcidDamage", 326017)
	self:Log("SPELL_PERIODIC_MISSED", "DecomposingAcidDamage", 326017)

	-- Spinemaw Reaver
	self:RegisterEngageMob("SpinemawReaverEngaged", 167116)
	self:Log("SPELL_CAST_SUCCESS", "StingingAssault", 326090)
	self:Log("SPELL_AURA_APPLIED", "DebilitatingPoisonApplied", 326092)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DebilitatingPoisonApplied", 326092)
	self:Death("SpinemawReaverDeath", 167116)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(52979) then -- Depleted Anima Seed after first boss
			-- 52979:Activate Seed (Allows players to resurrect at this location upon dying.)
			self:SelectGossipID(52979)
		elseif self:GetGossipID(52980) then -- Depleted Anima Seed after second boss
			-- 52980:Activate Seed (Allows players to resurrect at this location upon dying.)
			self:SelectGossipID(52980)
		end
	end
end

-- Tirnenn Villager

function mod:TirnennVillagerEngaged(guid)
	self:Nameplate(321968, 7.1, guid) -- Bewildering Pollen
	self:Nameplate(322486, 12.5, guid) -- Overgrowth
end

function mod:BewilderingPollen(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 15.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, name)
		self:TargetMessage(322486, "yellow", name)
		self:PlaySound(322486, "alert", nil, name)
	end

	function mod:Overgrowth(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Nameplate(args.spellId, 15.8, args.sourceGUID)
	end
end

function mod:SoulShackleRemoved(args)
	self:ClearNameplate(args.destGUID)
end

function mod:TirnennVillagerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Drust Harvester

function mod:DrustHarvesterEngaged(guid)
	self:Nameplate(322938, 0.9, guid) -- Harvest Essence
end

function mod:HarvestEssence(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 15.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:DrustHarvesterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Drust Soulcleaver

function mod:DrustSoulcleaverEngaged(guid)
	self:Nameplate(322557, 5.0, guid) -- Soul Split
	self:Nameplate(322569, 8.2, guid) -- Hand of Thros
end

function mod:HandOfThros(args)
	if self:MobId(args.sourceGUID) == 172991 then
		-- this version of the mob only RP fights and cannot be engaged by players
		return
	end
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

do
	local prev = 0
	function mod:HandOfThrosApplied(args)
		if self:MobId(args.sourceGUID) == 172991 then
			-- this version of the mob only RP fights and cannot be engaged by players
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			local unit = self:UnitTokenFromGUID(args.destGUID)
			if unit and UnitAffectingCombat(unit) then
				prev = t
				self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

do
	local prev = 0
	function mod:SoulSplit(args)
		if self:MobId(args.sourceGUID) == 172991 then
			-- this version of the mob only RP fights and cannot be engaged by players
			return
		end
		local t = args.time
		if t - prev > 1.5 and self:Tank() then
			local unit = self:UnitTokenFromGUID(args.sourceGUID)
			if unit and UnitAffectingCombat(unit) then
				prev = t
				self:Message(args.spellId, "purple")
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

function mod:SoulSplitSuccess(args)
	if self:MobId(args.sourceGUID) == 172991 then
		-- this version of the mob only RP fights and cannot be engaged by players
		return
	end
	self:Nameplate(args.spellId, 14.0, args.sourceGUID)
end

do
	local prev = 0
	function mod:SoulSplitApplied(args)
		-- Some mobs fight each other before being engaged by players.
		-- Only show messages when the target is a player controlled unit.
		local t = args.time
		if t - prev > 1.5 and self:Dispeller("magic", nil, args.spellId) and self:Player(args.destFlags) then
			prev = t
			self:StackMessage(args.spellId, "yellow", args.destName, args.amount, 1)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end

function mod:DrustSoulcleaverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Drust Spiteclaw

do
	local prev = 0
	function mod:DyingBreath(args)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Drust Boughbreaker

function mod:DrustBoughbreakerEngaged(guid)
	self:Nameplate(324923, 7.3, guid) -- Bramble Burst
end

function mod:FuriousThrashing(args)
	self:Message(args.spellId, "yellow", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:BrambleBurst(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 14.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:DrustBoughbreakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mistveil Defender

function mod:MistveilDefenderEngaged(guid)
	self:Nameplate(463248, 3.9, guid) -- Expel
	self:Nameplate(463256, 12.0, guid) -- Mist Ward
end

function mod:MistWard(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 25.5, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:MistWardDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(463256, "underyou")
			self:PlaySound(463256, "underyou")
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(463248, "red", name)
		self:PlaySound(463248, "alert", nil, name)
	end

	function mod:Expel(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

function mod:MistveilDefenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mistveil Gorgegullet

do
	local timer

	function mod:MistveilGorgegulletEngaged(guid)
		self:CDBar(340300, 3.2) -- Tongue Lashing
		self:Nameplate(340300, 3.2, guid) -- Tongue Lashing
		self:CDBar(340305, 11.5) -- Crushing Leap
		self:Nameplate(340305, 11.5, guid) -- Crushing Leap
		self:CDBar(340304, 22.6) -- Poisonous Secretions
		self:Nameplate(340304, 22.6, guid) -- Poisonous Secretions
		timer = self:ScheduleTimer("MistveilGorgegulletDeath", 30)
	end

	function mod:PoisonousSecretions(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 24.3)
		self:Nameplate(args.spellId, 24.3, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("MistveilGorgegulletDeath", 30)
	end

	function mod:CrushingLeap(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("MistveilGorgegulletDeath", 30)
	end

	function mod:TongueLashing(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 8.5)
		self:Nameplate(args.spellId, 8.5, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("MistveilGorgegulletDeath", 30)
	end

	function mod:MistveilGorgegulletDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(340304) -- Poisonous Secretions
		self:StopBar(340305) -- Crushing Leap
		self:StopBar(340300) -- Tongue Lashing
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Mistveil Guardian

function mod:MistveilGuardianEngaged(guid)
	self:Nameplate(463217, 4.8, guid) -- Anima Slash
end

function mod:AnimaSlash(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 14.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:MistveilGuardianDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mistveil Matriarch

do
	local timer

	function mod:MistveilMatriarchEngaged(guid)
		self:CDBar(340208, 4.9) -- Shred Armor
		self:Nameplate(340208, 4.9, guid) -- Shred Armor
		self:CDBar(340160, 11.8) -- Radiant Breath
		self:Nameplate(340160, 11.8, guid) -- Radiant Breath
		self:CDBar(340189, 21.4) -- Pool of Radiance
		self:Nameplate(340189, 21.4, guid) -- Pool of Radiance
		timer = self:ScheduleTimer("MistveilMatriarchDeath", 30)
	end

	function mod:PoolOfRadiance(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:CDBar(args.spellId, 27.9)
		self:Nameplate(args.spellId, 27.9, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
		timer = self:ScheduleTimer("MistveilMatriarchDeath", 30)
	end

	function mod:RadiantBreath(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("MistveilMatriarchDeath", 30)
	end

	function mod:ShredArmor(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 13.4)
		self:Nameplate(args.spellId, 13.4, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("MistveilMatriarchDeath", 30)
	end

	function mod:MistveilMatriarchDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(340189) -- Pool of Radiance
		self:StopBar(340160) -- Radiant Breath
		self:StopBar(340208) -- Shred Armor
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Mistveil Nightblossom

do
	local timer

	function mod:MistveilNightblossomEngaged(guid)
		self:CDBar(340289, 7.1) -- Triple Bite
		self:Nameplate(340289, 7.1, guid) -- Triple Bite
		self:CDBar(340279, 16.9) -- Poisonous Discharge
		self:Nameplate(340279, 16.9, guid) -- Poisonous Discharge
		timer = self:ScheduleTimer("MistveilNightblossomDeath", 30)
	end

	function mod:TripleBite(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("MistveilNightblossomDeath", 30)
	end

	do
		local playerList = {}

		function mod:PoisonousDischarge(args)
			playerList = {}
			if timer then
				self:CancelTimer(timer)
			end
			self:Message(args.spellId, "orange")
			self:CDBar(args.spellId, 19.4)
			self:Nameplate(args.spellId, 19.4, args.sourceGUID)
			self:PlaySound(args.spellId, "alarm")
			timer = self:ScheduleTimer("MistveilNightblossomDeath", 30)
		end

		function mod:PoisonousDischargeApplied(args)
			if self:Dispeller("poison", nil, 340279) then
				playerList[#playerList + 1] = args.destName
				self:TargetsMessage(340279, "yellow", playerList, 5)
				self:PlaySound(340279, "info", nil, playerList)
			end
		end
	end

	function mod:MistveilNightblossomDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(340289) -- Triple Bite
		self:StopBar(340279) -- Poisonous Discharge
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Mistveil Shaper

function mod:MistveilShaperEngaged(guid)
	self:Nameplate(324776, 7.9, guid) -- Bramblethorn Coat
end

function mod:BramblethornCoat(args)
	-- this is only cast if the Mistveil Shaper is being meleed
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:BramblethornCoatInterrupt(args)
	self:Nameplate(324776, 22.3, args.destGUID)
end

function mod:BramblethornCoatSuccess(args)
	self:Nameplate(args.spellId, 22.3, args.sourceGUID)
end

function mod:MistveilShaperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mistveil Stalker

function mod:MistveilStalkerEngaged(guid)
	self:Nameplate(325021, 7.4, guid) -- Mistveil Tear
end

function mod:MistveilBite(args)
	self:Nameplate(325021, 14.6, args.sourceGUID) -- Mistveil Tear
end

function mod:MistveilTear(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:MistveilStalkerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mistveil Stinger

function mod:MistveilStingerEngaged(guid)
	self:Nameplate(325224, 5.2, guid) -- Anima Injection
end

function mod:AnimaInjection(args)
	self:Nameplate(args.spellId, 14.6, args.sourceGUID)
end

function mod:AnimaInjectionApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Anima Injection")
	end
end

function mod:MistveilStingerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Mistveil Tender

function mod:MistveilTenderEngaged(guid)
	self:Nameplate(324914, 9.7, guid) -- Nourish the Forest
end

function mod:NourishTheForest(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:NourishTheForestInterrupt(args)
	self:Nameplate(324914, 16.4, args.destGUID)
end

do
	local prev = 0
	function mod:NourishTheForestSuccess(args)
		self:Nameplate(args.spellId, 16.4, args.sourceGUID)
		if args.time - prev > 2 and self:Dispeller("magic", true, args.spellId) then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:MistveilTenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Spinemaw Acidgullet

function mod:SpinemawAcidgulletEngaged(guid)
	self:Nameplate(325418, 7.8, guid) -- Volatile Acid
end

function mod:VolatileAcidSuccess(args)
	self:Nameplate(325418, 15.8, args.sourceGUID)
end

function mod:VolatileAcidApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Volatile Acid")
	end
end

function mod:SpinemawAcidgulletDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Spinemaw Staghorn

function mod:SpinemawStaghornEngaged(guid)
	self:Nameplate(326046, 5.3, guid) -- Stimulate Resistance
	self:Nameplate(460092, 10.1, guid) -- Acid Nova
	self:Nameplate(340544, 15.0, guid) -- Stimulate Regeneration
end

function mod:StimulateRegeneration(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 24.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:StimulateResistance(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:StimulateResistanceInterrupt(args)
	self:Nameplate(326046, 15.2, args.destGUID)
end

function mod:StimulateResistanceSuccess(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Friendly(args.destFlags) then
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "warning")
	end
	self:Nameplate(args.spellId, 15.2, args.sourceGUID)
end

function mod:AcidNova(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 21.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:SpinemawStaghornDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Spinemaw Gorger

function mod:SpinemawGorgerEngaged(guid)
	self:Nameplate(326021, 10.2, guid) -- Acid Globule
end

do
	local prev = 0
	function mod:AcidGlobule(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:AcidGlobuleSuccess(args)
	self:Nameplate(args.spellId, 13.3, args.sourceGUID)
end

function mod:SpinemawGorgerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Gormling Larva

do
	local prev = 0
	function mod:DecomposingAcidDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Spinemaw Reaver

function mod:SpinemawReaverEngaged(guid)
	self:Nameplate(326090, 5.7, guid) -- Stinging Assault
end

function mod:StingingAssault(args)
	self:Nameplate(args.spellId, 10.9, args.sourceGUID)
end

do
	local prev = 0
	function mod:DebilitatingPoisonApplied(args)
		if args.time - prev > 2 and self:Dispeller("poison", nil, 326090) then -- Stinging Assault
			prev = args.time
			self:StackMessage(326090, "orange", args.destName, args.amount, 2, args.spellName)
			self:PlaySound(326090, "alert", nil, args.destName)
		end
	end
end

function mod:SpinemawReaverDeath(args)
	self:ClearNameplate(args.destGUID)
end
