--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Theater Of Pain Trash", 2293)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	170838, -- Unyielding Contender
	174197, -- Battlefield Ritualist
	170850, -- Raging Bloodhorn
	170690, -- Diseased Horror
	174210, -- Blighted Sludge-Spewer
	163089, -- Disgusting Refuse
	169927, -- Putrid Butcher
	163086, -- Rancid Gasbag
	164510, -- Shambling Arbalest
	167538, -- Dokigg the Brutalizer
	162744, -- Nekthara the Mangler
	167532, -- Heavin the Breaker
	167536, -- Harugia the Bloodthirsty
	164506, -- Ancient Captain
	167533, -- Advent Nevermore
	167534, -- Rek the Hardened
	167998, -- Portal Guardian
	160495, -- Maniacal Soulbinder
	170882, -- Bone Magus
	169893, -- Nefarious Darkspeaker
	162763 -- Soulforged Bonereaver
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.battlefield_ritualist = "Battlefield Ritualist"
	L.raging_bloodhorn = "Raging Bloodhorn"
	L.diseased_horror = "Diseased Horror"
	L.blighted_sludge_spewer = "Blighted Sludge-Spewer"
	L.putrid_butcher = "Putrid Butcher"
	L.disgusting_refuse = "Disgusting Refuse"
	L.rancid_gasbag = "Rancid Gasbag"
	L.shambling_arbalest = "Shambling Arbalest"
	L.dokigg_the_brutalizer = "Dokigg the Brutalizer"
	L.nekthara_the_mangler = "Nekthara the Mangler"
	L.heavin_the_breaker = "Heavin the Breaker"
	L.harugia_the_bloodthirsty = "Harugia the Bloodthirsty"
	L.ancient_captain = "Ancient Captain"
	L.advent_nevermore = "Advent Nevermore"
	L.rek_the_hardened = "Rek the Hardened"
	L.portal_guardian = "Portal Guardian"
	L.maniacal_soulbinder = "Maniacal Soulbinder"
	L.bone_magus = "Bone Magus"
	L.nefarious_darkspeaker = "Nefarious Darkspeaker"
	L.soulforged_bonereaver = "Soulforged Bonereaver"

	L.mordretha_warmup_trigger = "Soldiers of Maldraxxus! Are you ready for some carnage?!"

	L["334023_desc"] = 334025 -- Bloodthirsty Charge, 334023 has a broken description
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Battlefield Ritualist
		{341902, "DISPEL", "NAMEPLATE"}, -- Unholy Fervor
		-- Raging Bloodhorn
		{333241, "NAMEPLATE"}, -- Raging Tantrum
		-- Diseased Horror
		{341977, "NAMEPLATE"}, -- Meat Shield
		{330697, "DISPEL", "NAMEPLATE"}, -- Decaying Strike
		-- Disgusting Refuse
		321039, -- Disgusting Burst
		{341949, "DISPEL"}, -- Withering Blight
		-- Blighted Sludge-Spewer
		{341969, "NAMEPLATE"}, -- Withering Discharge
		-- Putrid Butcher
		{330586, "NAMEPLATE"}, -- Devour Flesh
		-- Rancid Gasbag
		{330614, "DISPEL", "NAMEPLATE"}, -- Vile Eruption
		342103, -- Rancid Bile
		-- Shambling Arbalest
		{330532, "ME_ONLY", "NAMEPLATE"}, -- Jagged Quarrel
		-- Dokigg the Brutalizer
		{1215850, "NAMEPLATE"}, -- Earthcrusher
		{331316, "TANK_HEALER", "NAMEPLATE"}, -- Savage Flurry
		{317605, "NAMEPLATE"}, -- Whirlwind
		-- Nekthara the Mangler
		{342135, "NAMEPLATE"}, -- Interrupting Roar
		{336995, "NAMEPLATE"}, -- Whirling Blade
		{331288, "TANK", "NAMEPLATE"}, -- Colossus Smash
		-- Harugia the Bloodthirsty
		{333861, "SAY", "NAMEPLATE"}, -- Ricocheting Blade
		{333845, "TANK_HEALER", "NAMEPLATE"}, -- Unbalancing Blow
		{334023, "NAMEPLATE"}, -- Bloodthirsty Charge
		-- Ancient Captain
		{330562, "NAMEPLATE"}, -- Demoralizing Shout
		{330565, "TANK", "NAMEPLATE"}, -- Shield Bash
		-- Advent Nevermore
		{333827, "NAMEPLATE"}, -- Seismic Stomp
		-- Portal Guardian
		{330716, "NAMEPLATE"}, -- Soulstorm
		{330725, "DISPEL", "NAMEPLATE"}, -- Shadow Vulnerability
		-- Maniacal Soulbinder
		{330868, "NAMEPLATE"}, -- Necrotic Bolt Volley
		-- Bone Magus
		{342675, "OFF"}, -- Bone Spear
		-- Nefarious Darkspeaker
		{333294, "NAMEPLATE"}, -- Death Winds
		{333299, "DISPEL", "SAY", "NAMEPLATE"}, -- Curse of Desolation
		-- Soulforged Bonereaver
		{331223, "NAMEPLATE"}, -- Bonestorm
		{331237, "NAMEPLATE"}, -- Bone Spikes
	}, {
		[341902] = L.battlefield_ritualist,
		[333241] = L.raging_bloodhorn,
		[341977] = L.diseased_horror,
		[321039] = L.disgusting_refuse,
		[341969] = L.blighted_sludge_spewer,
		[330586] = L.putrid_butcher,
		[330614] = L.rancid_gasbag,
		[330532] = L.shambling_arbalest,
		[1215850] = L.dokigg_the_brutalizer,
		[342135] = L.nekthara_the_mangler,
		[333861] = L.harugia_the_bloodthirsty,
		[330562] = L.ancient_captain,
		[333827] = L.advent_nevermore,
		[330716] = L.portal_guardian,
		[330868] = L.maniacal_soulbinder,
		[342675] = L.bone_magus,
		[333294] = L.nefarious_darkspeaker,
		[331223] = L.soulforged_bonereaver
	}
end

function mod:OnBossEnable()
	-- Warmup
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Battlefield Ritualist
	self:RegisterEngageMob("BattlefieldRitualistEngaged", 174197)
	self:Log("SPELL_CAST_START", "UnholyFervor", 341902)
	self:Log("SPELL_INTERRUPT", "UnholyFervorInterrupt", 341902)
	self:Log("SPELL_CAST_SUCCESS", "UnholyFervorSuccess", 341902)
	self:Log("SPELL_AURA_APPLIED", "UnholyFervorApplied", 341902)
	self:Death("BattlefieldRitualistDeath", 174197)

	-- Raging Bloodhorn
	self:RegisterEngageMob("RagingBloodhornEngaged", 170850)
	self:Log("SPELL_CAST_SUCCESS", "RagingTantrum", 333241)
	self:Log("SPELL_AURA_APPLIED", "RagingTantrumApplied", 333241)
	self:Death("RagingBloodhornDeath", 170850)

	-- Diseased Horror
	self:RegisterEngageMob("DiseasedHorrorEngaged", 170690)
	self:Log("SPELL_CAST_START", "MeatShield", 341977)
	self:Log("SPELL_CAST_START", "DecayingStrike", 330697)
	self:Log("SPELL_CAST_SUCCESS", "DecayingStrikeSuccess", 330697)
	self:Log("SPELL_AURA_APPLIED", "DecayingBlightApplied", 330700)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DecayingBlightApplied", 330700)
	self:Death("DiseasedHorrorDeath", 170690)

	-- Blighted Sludge-Spewer (Mythic only)
	self:RegisterEngageMob("BlightedSludgeSpewerEngaged", 174210)
	self:Log("SPELL_CAST_START", "WitheringDischarge", 341969)
	self:Log("SPELL_INTERRUPT", "WitheringDischargeInterrupt", 341969)
	self:Log("SPELL_CAST_SUCCESS", "WitheringDischargeSuccess", 341969)
	self:Death("BlightedSludgeSpewerDeath", 174210)

	-- Disgusting Refuse
	self:Death("DisgustingRefuseDeath", 163089) -- Disgusting Burst
	self:Log("SPELL_AURA_APPLIED", "WitheringBlightApplied", 341949) -- this stacks but just alerting on initial application

	-- Putrid Butcher
	self:Log("SPELL_CAST_START", "DevourFlesh", 330586)
	self:Log("SPELL_CAST_SUCCESS", "DevourFleshSuccess", 330586)
	self:Death("PutridButcherDeath", 169927)

	-- Rancid Gasbag
	self:RegisterEngageMob("RancidGasbagEngaged", 163086)
	self:Log("SPELL_CAST_START", "VileEruption", 330614)
	self:Log("SPELL_AURA_APPLIED", "VileEruptionApplied", 330592)
	self:Log("SPELL_PERIODIC_DAMAGE", "RancidBileDamage", 342103)
	self:Log("SPELL_PERIODIC_MISSED", "RancidBileDamage", 342103)
	self:Death("RancidGasbagDeath", 163086)

	-- Shambling Arbalest
	self:RegisterEngageMob("ShamblingArbalestEngaged", 164510)
	self:Log("SPELL_CAST_START", "JaggedQuarrel", 330532)
	self:Log("SPELL_CAST_SUCCESS", "JaggedQuarrelSuccess", 330532)
	self:Death("ShamblingArbalestDeath", 164510)

	-- Chamber of Conquest
	self:RegisterEngageMob("DokiggTheBrutalizerEngaged", 167538)
	self:RegisterEngageMob("NektharaTheManglerEngaged", 162744)
	self:RegisterEngageMob("HeavinTheBreakerEngaged", 167532)
	self:RegisterEngageMob("HarugiaTheBloodthirstyEngaged", 167536)
	self:RegisterEngageMob("AdventNevermoreEngaged", 167533)
	self:RegisterEngageMob("RekTheHardenedEngaged", 167534)
	self:Death("ChamberOfConquestDeath", 167538, 162744, 167532, 167536, 167533, 167534)

	-- Dokigg the Brutalizer
	self:Log("SPELL_CAST_START", "Earthcrusher", 1215850)
	self:Log("SPELL_CAST_START", "SavageFlurry", 331316)
	self:Log("SPELL_CAST_START", "Whirlwind", 317605)

	-- Nekthara the Mangler
	self:Log("SPELL_CAST_START", "InterruptingRoar", 342135)
	self:Log("SPELL_CAST_SUCCESS", "WhirlingBlade", 336995)
	self:Log("SPELL_DAMAGE", "WhirlingBladeDamage", 337037)
	self:Log("SPELL_MISSED", "WhirlingBladeDamage", 337037)
	self:Log("SPELL_CAST_START", "ColossusSmash", 331288)

	-- Harugia the Bloodthirsty
	self:Log("SPELL_CAST_START", "RicochetingBlade", 333861)
	self:Log("SPELL_CAST_START", "UnbalancingBlow", 333845)
	self:Log("SPELL_CAST_SUCCESS", "UnbalancingBlowSuccess", 333845)
	self:Log("SPELL_CAST_START", "BloodthirstyCharge", 334023)

	-- Ancient Captain
	self:RegisterEngageMob("AncientCaptainEngaged", 164506)
	self:Log("SPELL_CAST_START", "DemoralizingShout", 330562)
	self:Log("SPELL_CAST_START", "ShieldBash", 330565)
	self:Death("AncientCaptainDeath", 164506)

	-- Advent Nevermore
	self:Log("SPELL_CAST_START", "SeismicStomp", 333827)

	-- Portal Guardian
	self:RegisterEngageMob("PortalGuardianEngaged", 167998)
	self:Log("SPELL_CAST_START", "Soulstorm", 330716)
	self:Log("SPELL_CAST_SUCCESS", "ShadowVulnerability", 330725)
	self:Log("SPELL_AURA_APPLIED", "ShadowVulnerabilityApplied", 330725)
	self:Death("PortalGuardianDeath", 167998)

	-- Maniacal Soulbinder
	self:RegisterEngageMob("ManiacalSoulbinderEngaged", 160495)
	self:Log("SPELL_CAST_START", "NecroticBoltVolley", 330868)
	self:Log("SPELL_INTERRUPT", "NecroticBoltVolleyInterrupt", 330868)
	self:Log("SPELL_CAST_SUCCESS", "NecroticBoltVolleySuccess", 330868)
	self:Death("ManiacalSoulbinderDeath", 160495)

	-- Bone Magus
	self:Log("SPELL_CAST_START", "BoneSpear", 342675)

	-- Nefarious Darkspeaker
	self:RegisterEngageMob("NefariousDarkspeakerEngaged", 169893)
	self:Log("SPELL_CAST_START", "DeathWinds", 333294)
	self:Log("SPELL_CAST_SUCCESS", "CurseOfDesolation", 333299)
	self:Log("SPELL_AURA_APPLIED", "CurseOfDesolationApplied", 333299)
	self:Death("NefariousDarkspeakerDeath", 169893)

	-- Soulforged Bonereaver
	self:RegisterEngageMob("SoulforgedBonereaverEngaged", 162763)
	self:Log("SPELL_CAST_START", "Bonestorm", 331223)
	self:Log("SPELL_DAMAGE", "BonestormDamage", 331224)
	self:Log("SPELL_CAST_START", "BoneSpikes", 331237)
	self:Death("SoulforgedBonereaverDeath", 162763)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg == L.mordretha_warmup_trigger then -- Mordretha Warmup
		local mordrethaModule = BigWigs:GetBossModule("Mordretha, the Endless Empress", true)
		if mordrethaModule then
			mordrethaModule:Enable()
			mordrethaModule:Warmup()
		end
	end
end

-- Battlefield Ritualist

function mod:BattlefieldRitualistEngaged(guid)
	self:Nameplate(341902, 1.0, guid) -- Unholy Fervor
end

function mod:UnholyFervor(args)
	-- this isn't cast unless there is a mob nearby with low hp
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:UnholyFervorInterrupt(args)
	self:Nameplate(341902, 24.4, args.destGUID)
end

function mod:UnholyFervorSuccess(args)
	self:Nameplate(args.spellId, 24.4, args.sourceGUID)
end

function mod:UnholyFervorApplied(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.on:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:BattlefieldRitualistDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Raging Bloodhorn

do
	local timer

	function mod:RagingBloodhornEngaged(guid)
		self:CDBar(333241, 8.8) -- Raging Tantrum
		self:Nameplate(333241, 8.8, guid) -- Raging Tantrum
		timer = self:ScheduleTimer("RagingBloodhornDeath", 20, nil, guid)
	end

	function mod:RagingTantrum(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 18.2)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		timer = self:ScheduleTimer("RagingBloodhornDeath", 30, nil, args.sourceGUID)
	end

	function mod:RagingTantrumApplied(args)
		if self:Dispeller("enrage", true) then
			self:Message(args.spellId, "orange", CL.on:format(args.destName, args.spellName))
			self:PlaySound(args.spellId, "warning")
		else
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end

	function mod:RagingBloodhornDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(333241) -- Raging Tantrum
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Diseased Horror

function mod:DiseasedHorrorEngaged(guid)
	-- Meat Shield isn't cast until a certain hp % threshold
	self:Nameplate(330697, 2.7, guid) -- Decaying Strike
end

function mod:MeatShield(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	-- cooldown is triggered by cast start
	self:Nameplate(args.spellId, 15.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:DecayingStrike(args)
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:DecayingStrikeSuccess(args)
	self:Nameplate(args.spellId, 22.1, args.sourceGUID)
end

do
	local prev = 0
	function mod:DecayingBlightApplied(args)
		if not self:Player(args.destFlags) then -- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
			return
		end
		if (self:Me(args.destGUID) or self:Dispeller("disease", nil, 330697)) and args.time - prev > 3 then
			prev = args.time
			self:StackMessage(330697, "purple", args.destName, args.amount, 1)
			self:PlaySound(330697, "alert", nil, args.destName)
		end
	end
end

function mod:DiseasedHorrorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Blighted Sludge-Spewer

function mod:BlightedSludgeSpewerEngaged(guid)
	self:Nameplate(341969, 9.6, guid) -- Withering Discharge
end

do
	local prev = 0
	function mod:WitheringDischarge(args)
		-- this NPC is only present in Mythic difficulty
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:WitheringDischargeInterrupt(args)
	self:Nameplate(341969, 24.0, args.destGUID)
end

function mod:WitheringDischargeSuccess(args)
	self:Nameplate(args.spellId, 24.0, args.sourceGUID)
end

function mod:BlightedSludgeSpewerDeath(args)
	self:DisgustingRefuseDeath(args) -- Disgusting Burst
	self:ClearNameplate(args.destGUID)
end

-- Disgusting Refuse

do
	local prev = 0
	function mod:DisgustingRefuseDeath(args) -- Disgusting Burst
		if args.time - prev > 2 then
			prev = args.time
			self:Message(321039, "orange")
			self:PlaySound(321039, "alarm")
		end
	end
end

do
	local playerList = {}
	local prev = 0
	function mod:WitheringBlightApplied(args)
		if self:Dispeller("disease", nil, args.spellId) then
			if args.time - prev > .5 then -- throttle alerts to .5s intervals
				prev = args.time
				playerList = {}
			end
			playerList[#playerList+1] = args.destName
			self:TargetsMessage(args.spellId, "yellow", playerList, 5, nil, nil, .5)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end

-- Putrid Butcher

--function mod:PutridButcherEngaged(guid)
	-- Devour Flesh isn't cast until a certain hp % threshold
--end

function mod:DevourFlesh(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:DevourFleshSuccess(args)
	self:Nameplate(args.spellId, 24.2, args.sourceGUID)
end

function mod:PutridButcherDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Rancid Gasbag

function mod:RancidGasbagEngaged(guid)
	self:Nameplate(330614, 6.4, guid) -- Vile Eruption
end

function mod:VileEruption(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 15.7, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:VileEruptionApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("disease", nil, 330614) then
		self:TargetMessage(330614, "yellow", args.destName)
		self:PlaySound(330614, "info", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:RancidBileDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:RancidGasbagDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Shambling Arbalest

function mod:ShamblingArbalestEngaged(guid)
	self:Nameplate(330532, 9.3, guid) -- Jagged Quarrel
end

do
	local function printTarget(self, name)
		self:TargetMessage(330532, "yellow", name)
		self:PlaySound(330532, "alert", nil, name)
	end

	function mod:JaggedQuarrel(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:JaggedQuarrelSuccess(args)
	self:Nameplate(args.spellId, 22.0, args.sourceGUID)
end

function mod:ShamblingArbalestDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Chamber of Conquest

function mod:DokiggTheBrutalizerEngaged(guid)
	self:Nameplate(331316, 2.0, guid) -- Savage Flurry
	self:Nameplate(317605, 3.5, guid) -- Whirlwind
	self:Nameplate(1215850, 11.7, guid) -- Earthcrusher
end

function mod:NektharaTheManglerEngaged(guid)
	self:Nameplate(331288, 2.3, guid) -- Colossus Smash
	self:Nameplate(336995, 5.6, guid) -- Whirling Blade
	self:Nameplate(342135, 8.0, guid) -- Interrupting Roar
end

function mod:HeavinTheBreakerEngaged(guid)
	self:Nameplate(342135, 2.3, guid) -- Interrupting Roar
	self:Nameplate(331288, 8.1, guid) -- Colossus Smash
	self:Nameplate(317605, 11.7, guid) -- Whirlwind
end

function mod:HarugiaTheBloodthirstyEngaged(guid)
	self:Nameplate(333861, 2.0, guid) -- Ricocheting Blade
	self:Nameplate(334023, 5.1, guid) -- Bloodthirsty Charge
	self:Nameplate(333845, 5.9, guid) -- Unbalancing Blow
end

function mod:AdventNevermoreEngaged(guid)
	self:Nameplate(336995, 2.3, guid) -- Whirling Blade
	self:Nameplate(331288, 5.8, guid) -- Colossus Smash
	self:Nameplate(333827, 9.4, guid) -- Seismic Stomp
end

function mod:RekTheHardenedEngaged(guid)
	self:Nameplate(317605, 5.6, guid) -- Whirlwind
	self:Nameplate(333845, 5.7, guid) -- Unbalancing Blow
	-- and Swift Strikes, which doesn't matter
end

function mod:ChamberOfConquestDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Dokigg the Brutalizer

function mod:Earthcrusher(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "red")
		self:Nameplate(args.spellId, 13.3, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:SavageFlurry(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "purple")
		self:Nameplate(args.spellId, 13.3, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end
end

-- Dokigg the Brutalizer / Heavin the Breaker / Rek the Hardened

function mod:Whirlwind(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "orange")
		local mobId = self:MobId(args.sourceGUID)
		if mobId == 167538 then -- Dokigg the Brutalizer
			self:Nameplate(args.spellId, 26.7, args.sourceGUID)
		else -- 167532, Heavin the Breaker and 167534, Rek the Hardened
			self:Nameplate(args.spellId, 20.6, args.sourceGUID)
		end
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Nekthara the Mangler / Heavin the Breaker

function mod:InterruptingRoar(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "yellow")
		self:Nameplate(args.spellId, 17.8, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end
end

-- Nekthara the Mangler

function mod:WhirlingBlade(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "red")
		self:Nameplate(args.spellId, 13.3, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end
end

do
	local prev = 0
	function mod:WhirlingBladeDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(336995, "near")
			self:PlaySound(336995, "underyou")
		end
	end
end

-- Nekthara the Mangler / Heavin the Breaker / Advent Nevermore

function mod:ColossusSmash(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "purple")
		local mobId = self:MobId(args.sourceGUID)
		if mobId == 162744 then -- Nekthara the Mangler
			self:Nameplate(args.spellId, 14.5, args.sourceGUID)
		elseif mobId == 167532 then -- Heavin the Breaker
			self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		else -- 167533, Advent Nevermore
			self:Nameplate(args.spellId, 15.8, args.sourceGUID)
		end
		self:PlaySound(args.spellId, "alert")
	end
end

-- Harugia the Bloodthirsty / Advent Nevermore

do
	local function printTarget(self, name, guid)
		self:TargetMessage(333861, "red", name)
		if self:Me(guid) then
			self:Say(333861, nil, nil, "Ricocheting Blade")
			self:PlaySound(333861, "warning", nil, name)
		else
			self:PlaySound(333861, "alert", nil, name)
		end
	end

	function mod:RicochetingBlade(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
			self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
			self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		end
	end
end

-- Harugia the Bloodthirsty / Rek the Hardened

function mod:UnbalancingBlow(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "purple")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:UnbalancingBlowSuccess(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		if self:MobId(args.sourceGUID) == 167536 then -- Harugia the Bloodthirsty
			self:Nameplate(args.spellId, 15.3, args.sourceGUID)
		else -- 167534, Rek the Hardened
			self:Nameplate(args.spellId, 9.2, args.sourceGUID)
		end
	end
end

-- Harugia the Bloodthirsty

function mod:BloodthirstyCharge(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

-- Ancient Captain

function mod:AncientCaptainEngaged(guid)
	if self:Interrupter() then
		self:Nameplate(330562, 3.2, guid) -- Demoralizing Shout
	end
	self:Nameplate(330565, 3.3, guid) -- Shield Bash
end

function mod:DemoralizingShout(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	local canInterrupt, interruptReady = self:Interrupter()
	if canInterrupt then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		if interruptReady then
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:ShieldBash(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 9.7, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:AncientCaptainDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Advent Nevermore

function mod:SeismicStomp(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "yellow")
		self:Nameplate(args.spellId, 9.3, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end
end

-- Portal Guardian

function mod:PortalGuardianEngaged(guid)
	self:Nameplate(330725, 3.2, guid) -- Shadow Vulnerability
	self:Nameplate(330716, 8.0, guid) -- Soulstorm
end

function mod:Soulstorm(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 26.7, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:ShadowVulnerability(args)
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
end

function mod:ShadowVulnerabilityApplied(args)
	if self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:PortalGuardianDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Maniacal Soulbinder

function mod:ManiacalSoulbinderEngaged(guid)
	self:Nameplate(330868, 9.1, guid) -- Necrotic Bolt Volley
end

function mod:NecroticBoltVolley(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:NecroticBoltVolleyInterrupt(args)
	self:Nameplate(330868, 21.7, args.destGUID)
end

function mod:NecroticBoltVolleySuccess(args)
	self:Nameplate(args.spellId, 21.7, args.sourceGUID)
end

function mod:ManiacalSoulbinderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bone Magus

function mod:BoneSpear(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:PlaySound(args.spellId, "alert")
	end
end

-- Nefarious Darkspeaker

function mod:NefariousDarkspeakerEngaged(guid)
	self:Nameplate(333294, 5.9, guid) -- Death Winds
	self:Nameplate(333299, 6.8, guid) -- Curse of Desolation
end

function mod:DeathWinds(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 8.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:CurseOfDesolation(args)
	self:Nameplate(args.spellId, 13.3, args.sourceGUID)
end

function mod:CurseOfDesolationApplied(args)
	local onMe = self:Me(args.destGUID)
	if onMe or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		if onMe then
			self:Say(args.spellId, nil, nil, "Curse of Desolation")
		end
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:NefariousDarkspeakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Soulforged Bonereaver

function mod:SoulforgedBonereaverEngaged(guid)
	self:Nameplate(331237, 4.8, guid) -- Bone Spikes
	self:Nameplate(331223, 21.4, guid) -- Bonestorm
end

function mod:Bonestorm(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 33.9, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:BonestormDamage(args)
	if not self:Tank() and self:Me(args.destGUID) then
		self:PersonalMessage(331223, "near")
		self:PlaySound(331223, "underyou")
	end
end

function mod:BoneSpikes(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 32.7, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:SoulforgedBonereaverDeath(args)
	self:ClearNameplate(args.destGUID)
end
