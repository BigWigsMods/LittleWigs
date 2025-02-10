local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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
end

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotOne then
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
			-- Dokigg the Brutalizer
			{1215850, "NAMEPLATE"}, -- Earthcrusher
			{331316, "TANK_HEALER", "NAMEPLATE"}, -- Savage Flurry
			{317605, "NAMEPLATE"}, -- Whirlwind
			-- Nekthara the Mangler
			{342135, "NAMEPLATE"}, -- Interrupting Roar
			{336995, "NAMEPLATE"}, -- Whirling Blade
			-- Heavin the Breaker
			{332708, "NAMEPLATE"}, -- Ground Smash
			{331288, "TANK", "NAMEPLATE"}, -- Colossus Smash
			-- Harugia the Bloodthirsty
			{333861, "SAY", "NAMEPLATE"}, -- Ricocheting Blade
			{334023, "NAMEPLATE"}, -- Bloodthirsty Charge
			-- Ancient Captain
			{330562, "NAMEPLATE"}, -- Demoralizing Shout
			{330565, "TANK", "NAMEPLATE"}, -- Shield Bash
			-- Advent Nevermore
			{333827, "NAMEPLATE"}, -- Seismic Stomp
			-- Rek the Hardened
			{333845, "TANK_HEALER", "NAMEPLATE"}, -- Unbalancing Blow
			-- Portal Guardian
			{330716, "NAMEPLATE"}, -- Soulstorm
			{330725, "DISPEL", "NAMEPLATE"}, -- Shadow Vulnerability
			-- Maniacal Soulbinder
			{330868, "NAMEPLATE"}, -- Necrotic Bolt Volley
			-- Bone Magus
			{342675, "NAMEPLATE"}, -- Bone Spear
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
			[1215850] = L.dokigg_the_brutalizer,
			[342135] = L.nekthara_the_mangler,
			[332708] = L.heavin_the_breaker,
			[333861] = L.harugia_the_bloodthirsty,
			[330562] = L.ancient_captain,
			[333827] = L.advent_nevermore,
			[333845] = L.rek_the_hardened,
			[330716] = L.portal_guardian,
			[330868] = L.maniacal_soulbinder,
			[342675] = L.bone_magus,
			[333294] = L.nefarious_darkspeaker,
			[331223] = L.soulforged_bonereaver
		}
	end
else -- XXX delete this block when 11.1 is live
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
			{332836, "NAMEPLATE"}, -- Chop (removed in 11.1)
			-- Rancid Gasbag
			{330614, "DISPEL", "NAMEPLATE"}, -- Vile Eruption
			342103, -- Rancid Bile
			-- Dokigg the Brutalizer
			342139, -- Battle Trance (removed 11.1)
			342125, -- Brutal Leap (removed 11.1)
			-- Nekthara the Mangler
			{342135, "NAMEPLATE"}, -- Interrupting Roar
			{317605, "NAMEPLATE"}, -- Whirlwind
			{336995, "NAMEPLATE"}, -- Whirling Blade
			-- Heavin the Breaker
			{332708, "NAMEPLATE"}, -- Ground Smash
			{331288, "TANK", "NAMEPLATE"}, -- Colossus Smash
			-- Harugia the Bloodthirsty
			{333861, "SAY", "NAMEPLATE"}, -- Ricocheting Blade
			{334023, "NAMEPLATE"}, -- Bloodthirsty Charge
			-- Ancient Captain
			{330562, "NAMEPLATE"}, -- Demoralizing Shout
			{330565, "TANK", "NAMEPLATE"}, -- Shield Bash
			-- Advent Nevermore
			{333827, "NAMEPLATE"}, -- Seismic Stomp
			331275, -- Unbreakable Guard (removed 11.1)
			-- Rek the Hardened
			{333845, "TANK_HEALER", "NAMEPLATE"}, -- Unbalancing Blow
			-- Portal Guardian
			{330716, "NAMEPLATE"}, -- Soulstorm
			{330725, "DISPEL", "NAMEPLATE"}, -- Shadow Vulnerability
			-- Maniacal Soulbinder
			{330868, "NAMEPLATE"}, -- Necrotic Bolt Volley
			{333708, "DISPEL"}, -- Soul Corruption (removed 11.1)
			-- Bone Magus
			{342675, "NAMEPLATE"}, -- Bone Spear
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
			[342139] = L.dokigg_the_brutalizer,
			[342135] = L.nekthara_the_mangler,
			[332708] = L.heavin_the_breaker,
			[333861] = L.harugia_the_bloodthirsty,
			[330562] = L.ancient_captain,
			[333827] = L.advent_nevermore,
			[333845] = L.rek_the_hardened,
			[330716] = L.portal_guardian,
			[330868] = L.maniacal_soulbinder,
			[342675] = L.bone_magus,
			[333294] = L.nefarious_darkspeaker,
			[331223] = L.soulforged_bonereaver
		}
	end
end

function mod:OnBossEnable()
	-- Warmup
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Battlefield Ritualist
	self:RegisterEngageMob("BattlefieldRitualistEngaged", 174197)
	self:Log("SPELL_CAST_START", "UnholyFervor", 341902)
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
	self:Log("SPELL_CAST_START", "Chop", 332836) -- XXX removed in 11.1
	self:Log("SPELL_CAST_SUCCESS", "ChopSuccess", 332836) -- XXX removed in 11.1
	self:Death("PutridButcherDeath", 169927)

	-- Rancid Gasbag
	self:RegisterEngageMob("RancidGasbagEngaged", 163086)
	self:Log("SPELL_CAST_START", "VileEruption", 330614)
	self:Log("SPELL_AURA_APPLIED", "VileEruptionApplied", 330592)
	self:Log("SPELL_PERIODIC_DAMAGE", "RancidBileDamage", 342103)
	self:Log("SPELL_PERIODIC_MISSED", "RancidBileDamage", 342103)
	self:Death("RancidGasbagDeath", 163086)

	-- Chamber of Conquest
	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		self:RegisterEngageMob("DokiggTheBrutalizerEngaged", 167538)
		self:RegisterEngageMob("NektharaTheManglerEngaged", 162744)
		self:RegisterEngageMob("HeavinTheBreakerEngaged", 167532)
		self:RegisterEngageMob("HarugiaTheBloodthirstyEngaged", 167536)
		self:RegisterEngageMob("AdventNevermoreEngaged", 167533)
		self:RegisterEngageMob("RekTheHardenedEngaged", 167534)
	end
	self:Death("ChamberOfConquestDeath", 167538, 162744, 167532, 167536, 167533, 167534)

	-- Dokigg the Brutalizer
	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		self:Log("SPELL_CAST_START", "Earthcrusher", 1215850)
		self:Log("SPELL_CAST_START", "SavageFlurry", 331316)
	else -- XXX remove this block when 11.1 is live
		self:Log("SPELL_CAST_START", "BattleTrance", 342139) -- XXX removed in 11.1
		self:Log("SPELL_AURA_APPLIED", "BattleTranceApplied", 342139) -- XXX removed in 11.1
		self:Log("SPELL_CAST_START", "BrutalLeap", 342125) -- XXX removed in 11.1
	end
	self:Log("SPELL_CAST_START", "Whirlwind", 317605)

	-- Nekthara the Mangler / Heavin the Breaker
	self:Log("SPELL_CAST_START", "InterruptingRoar", 342135)

	-- Nekthara the Mangler / Harugia the Bloodthirsty
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- for 336995, Whirling Blade
	self:Log("SPELL_DAMAGE", "WhirlingBladeDamage", 337037)
	self:Log("SPELL_MISSED", "WhirlingBladeDamage", 337037)

	-- Heavin the Breaker
	self:Log("SPELL_CAST_START", "GroundSmash", 332708)
	self:Log("SPELL_CAST_START", "ColossusSmash", 331288)

	-- Harugia the Bloodthirsty / Advent Nevermore
	self:Log("SPELL_CAST_START", "RicochetingBlade", 333861)

	-- Harugia the Bloodthirsty
	self:Log("SPELL_CAST_START", "BloodthirstyCharge", 334023)

	-- Ancient Captain
	self:RegisterEngageMob("AncientCaptainEngaged", 164506)
	self:Log("SPELL_CAST_START", "DemoralizingShout", 330562)
	self:Log("SPELL_CAST_START", "ShieldBash", 330565)
	self:Death("AncientCaptainDeath", 164506)

	-- Advent Nevermore
	self:Log("SPELL_CAST_START", "SeismicStomp", 333827)
	if not isElevenDotOne then -- XXX remove when 11.1 is live
		self:Log("SPELL_CAST_START", "UnbreakableGuard", 331275)
	end

	-- Rek the Hardened
	self:Log("SPELL_CAST_START", "UnbalancingBlow", 333845)

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
	self:Log("SPELL_AURA_APPLIED", "SoulCorruptionApplied", 333708) -- XXX removed in 11.1
	self:Death("ManiacalSoulbinderDeath", 160495)

	-- Bone Magus
	self:RegisterEngageMob("BoneMagusEngaged", 170882)
	self:Log("SPELL_CAST_START", "BoneSpear", 342675)
	self:Log("SPELL_INTERRUPT", "BoneSpearInterrupt", 342675)
	self:Log("SPELL_CAST_SUCCESS", "BoneSpearSuccess", 342675)
	self:Death("BoneMagusDeath", 170882)

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
	-- cooldown is triggered by cast start
	if isElevenDotOne then
		self:Nameplate(args.spellId, 24.3, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 15.8, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "alert")
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

function mod:RagingBloodhornEngaged(guid)
	self:Nameplate(333241, 8.8, guid) -- Raging Tantrum
end

function mod:RagingTantrum(args)
	if isElevenDotOne then
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 15.8, args.sourceGUID)
	end
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

function mod:RagingBloodhornDeath(args)
	self:ClearNameplate(args.destGUID)
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
		if self:Dispeller("disease", nil, 330697) and args.time - prev > 3 then
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
	self:Nameplate(341969, 10.2, guid) -- Withering Discharge
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
	self:Nameplate(341969, 24.1, args.destGUID)
end

function mod:WitheringDischargeSuccess(args)
	self:Nameplate(args.spellId, 24.1, args.sourceGUID)
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

do
	local function printTarget(self, name, guid) -- XXX removed in 11.1
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(332836, "red", name)
			self:PlaySound(332836, "alert", nil, name)
		end
	end

	function mod:Chop(args) -- XXX removed in 11.1
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if not self:Tank() then
			self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		end
	end

	function mod:ChopSuccess(args) -- XXX removed in 11.1
		self:Nameplate(args.spellId, 16.7, args.sourceGUID)
	end
end

function mod:PutridButcherDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Rancid Gasbag

function mod:RancidGasbagEngaged(guid)
	self:Nameplate(330614, 6.8, guid) -- Vile Eruption
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

-- Chamber of Conquest

function mod:DokiggTheBrutalizerEngaged(guid)
	self:Nameplate(331316, 2.0, guid) -- Savage Flurry
	self:Nameplate(317605, 3.5, guid) -- Whirlwind
	self:Nameplate(1215850, 11.7, guid) -- Earthcrusher
end

function mod:NektharaTheManglerEngaged(guid)
	self:Nameplate(317605, 1.9, guid) -- Whirlwind
	self:Nameplate(336995, 2.1, guid) -- Whirling Blade
	self:Nameplate(342135, 9.2, guid) -- Interrupting Roar
end

function mod:HeavinTheBreakerEngaged(guid)
	self:Nameplate(342135, 2.3, guid) -- Interrupting Roar
	self:Nameplate(332708, 2.4, guid) -- Ground Smash
	self:Nameplate(331288, 11.8, guid) -- Colossus Smash
end

function mod:HarugiaTheBloodthirstyEngaged(guid)
	self:Nameplate(333861, 2.0, guid) -- Ricocheting Blade
	self:Nameplate(334023, 5.6, guid) -- Bloodthirsty Charge
end

function mod:AdventNevermoreEngaged(guid)
	self:Nameplate(333861, 2.4, guid) -- Ricocheting Blade
	self:Nameplate(333827, 2.4, guid) -- Seismic Stomp
end

function mod:RekTheHardenedEngaged(guid)
	self:Nameplate(333845, 5.7, guid) -- Unbalancing Blow
	self:Nameplate(317605, 6.1, guid) -- Whirlwind
	-- and Swift Strikes, which doesn't matter
end

function mod:ChamberOfConquestDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Dokigg the Brutalizer / Harugia the Bloodthirsty

function mod:BattleTrance(args) -- XXX removed in 11.1
	local canInterrupt, interruptReady = self:Interrupter()
	local enrageDispeller = self:Dispeller("enrage", true)
	-- this can be interrupted or you can let the cast go through and dispel the enrage
	if canInterrupt or enrageDispeller then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		if interruptReady then
			self:PlaySound(args.spellId, "warning")
		elseif enrageDispeller then
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:BattleTranceApplied(args) -- XXX removed in 11.1
	if self:Dispeller("enrage", true) or self:Tank() then
		self:Message(args.spellId, "orange", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Dokigg the Brutalizer

function mod:BrutalLeap(args) -- XXX removed in 11.1
	-- target detection not possible with this spell
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

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

-- Nekthara the Mangler / Heavin the Breaker

function mod:InterruptingRoar(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "yellow")
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end
end

-- Dokigg the Brutalizer / Nekthara the Mangler / Rek the Hardened

function mod:Whirlwind(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "orange")
		local mobId = self:MobId(args.sourceGUID)
		if mobId == 167538 then -- Dokigg the Brutalizer
			self:Nameplate(args.spellId, 26.7, args.sourceGUID)
		elseif mobId == 162744 then -- Nekthara the Mangler
			self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		else -- 167534, Rek the Hardened
			self:Nameplate(args.spellId, 20.6, args.sourceGUID)
		end
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Nekthara the Mangler

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, castGUID, spellId)
		if castGUID ~= prev and spellId == 336995 then -- Whirling Blade
			prev = castGUID
			local unitGUID = self:UnitGUID(unit)
			if unitGUID then
				self:Message(spellId, "red")
				self:Nameplate(spellId, 13.3, unitGUID)
				self:PlaySound(spellId, "alarm")
			end
		end
	end
end

--function mod:WhirlingBlade(args)
	--self:Message(args.spellId, "red")
	--self:Nameplate(args.spellId, 13.3, args.sourceGUID)
	--self:PlaySound(args.spellId, "alarm")
--end

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

-- Heavin the Breaker

function mod:GroundSmash(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ColossusSmash(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "purple")
		self:Nameplate(args.spellId, 9.7, args.sourceGUID)
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

-- Harugia the Bloodthirsty

function mod:BloodthirstyCharge(args)
	self:Message(args.spellId, "orange")
	if isElevenDotOne then
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 10.5, args.sourceGUID)
	end
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

function mod:UnbreakableGuard(args) -- XXX remove when 11.1 is live
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
	end
end

-- Rek the Hardened

function mod:UnbalancingBlow(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "purple")
		self:Nameplate(args.spellId, 8.5, args.sourceGUID)
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
	if isElevenDotOne then
		self:Nameplate(args.spellId, 26.7, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 23.0, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:ShadowVulnerability(args)
	if isElevenDotOne then
		self:Nameplate(args.spellId, 18.3, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	end
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
	if isElevenDotOne then
		self:Nameplate(330868, 9.5, guid) -- Necrotic Bolt Volley
	else -- XXX remove in 11.1
		self:Nameplate(330868, 6.9, guid) -- Necrotic Bolt Volley
	end
end

function mod:NecroticBoltVolley(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
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

function mod:SoulCorruptionApplied(args) -- XXX removed in 11.1
	if not self:Player(args.destFlags) then -- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
		return
	end
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:ManiacalSoulbinderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bone Magus

function mod:BoneMagusEngaged(guid)
	if isElevenDotOne then
		self:Nameplate(342675, 9.4, guid) -- Bone Spear
	else -- XXX remove in 11.1
		self:Nameplate(342675, 1.2, guid) -- Bone Spear
	end
end

function mod:BoneSpear(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:BoneSpearInterrupt(args)
	if isElevenDotOne then
		self:Nameplate(342675, 22.0, args.destGUID)
	else -- XXX remove in 11.1
		self:Nameplate(342675, 17.4, args.destGUID)
	end
end

function mod:BoneSpearSuccess(args)
	if isElevenDotOne then
		self:Nameplate(args.spellId, 22.0, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 17.4, args.sourceGUID)
	end
end

function mod:BoneMagusDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nefarious Darkspeaker

function mod:NefariousDarkspeakerEngaged(guid)
	self:Nameplate(333294, 5.9, guid) -- Death Winds
	self:Nameplate(333299, 7.1, guid) -- Curse of Desolation
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
	self:Nameplate(331237, 5.0, guid) -- Bone Spikes
	self:Nameplate(331223, 21.7, guid) -- Bonestorm
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
	self:Nameplate(args.spellId, 33.9, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:SoulforgedBonereaverDeath(args)
	self:ClearNameplate(args.destGUID)
end
