--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Horrific Vision of Stormwind Trash", 2213)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	155604, -- Image of Wrathion
	233236, -- Image of Wrathion (Revisited only)
	152704, -- Crawling Corruption
	160061, -- Crawling Corruption
	153760, -- Enthralled Footman
	241715, -- Vengeful Footman (Revisited only)
	152722, -- Fallen Voidspeaker
	241718, -- Vengeful Voidspeaker (Revisited only)
	157700, -- Agustus Moulaine
	152669, -- Void Globule
	160704, -- Letter Encrusted Void Globule
	239586, -- Coagulated Garbage
	158092, -- Fallen Heartpiercer
	241717, -- Vengeful Heartpiercer (Revisited only)
	158146, -- Fallen Riftwalker
	157158, -- Cultist Slavedriver
	158690, -- Cultist Tormenter
	158136, -- Inquisitor Darkspeak
	158437, -- Fallen Taskmaster
	152987, -- Faceless Willbreaker
	164188, -- Horrific Figment
	156641, -- Enthralled Weaponsmith
	158158, -- Forge-Guard Hurrul
	156795, -- SI:7 Informant
	156949, -- Armsmaster Terenson
	156145, -- Burrowing Appendage
	156820, -- Dod
	152809, -- Alx'kov the Infested
	153130, -- Greater Void Elemental
	152939, -- Boundless Corruption
	159275, -- Portal Keeper
	159266, -- Portal Master
	158371, -- Zardeth of the Black Claw
	158411, -- Unstable Servant
	241698, -- Hogger (WANTED: Hogger!!) (Revisited only)
	239437, -- Hogger (Mask of the Nemesis) (Revisited only)
	237991 -- Void-Scarred Gryphon (Revisited only)
)

--------------------------------------------------------------------------------
-- Locals
--

local portalsClosed = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sanity_change = "%d Sanity"
	L.portal_closed = "Portal Closed"
	L.portal_closed_desc = "Show a message when a portal is closed in the Mage Quarter."
	L.portal_closed_icon = "spell_arcane_teleportstormwind"
	L.madnesses = "Madnesses"
	L.potions = "Potions"
	L.buffs = "Buffs"
	L.slowed = "Slowed"
	L.sluggish_potion_effect = "Heal 2% every 5 sec"
	L.sickening_potion_effect = "5% damage reduction"
	L.spicy_potion_effect = "Breathe fire"

	L.crawling_corruption = "Crawling Corruption"
	L.enthralled_footman = "Enthralled Footman"
	L.fallen_voidspeaker = "Fallen Voidspeaker"
	L.void_globule = "Void Globule"
	L.fallen_heartpiercer = "Fallen Heartpiercer"
	L.fallen_riftwalker = "Fallen Riftwalker"
	L.cultist_slavedriver = "Cultist Slavedriver"
	L.cultist_tormenter = "Cultist Tormenter"
	L.inquisitor_darkspeak = "Inquisitor Darkspeak"
	L.fallen_taskmaster = "Fallen Taskmaster"
	L.faceless_willbreaker = "Faceless Willbreaker"
	L.enthralled_weaponsmith = "Enthralled Weaponsmith"
	L.forge_guard_hurrul = "Forge-Guard Hurrul"
	L.si7_informant = "SI:7 Informant"
	L.armsmaster_terenson = "Armsmaster Terenson"
	L.burrowing_appendage = "Burrowing Appendage"
	L.dod = "Dod"
	L.alxkov_the_infested = "Alx'kov the Infested"
	L.greater_void_elemental = "Greater Void Elemental"
	L.boundless_corruption = "Boundless Corruption"
	L.portal_keeper = "Portal Keeper"
	L.zardeth_of_the_black_claw = "Zardeth of the Black Claw"
	L.unstable_servant = "Unstable Servant"
	L.hogger = "Hogger"
	L.void_scarred_gryphon = "Void-Scarred Gryphon"

	L.therum_deepforge_warmup_trigger = "So ye like tae play with explosives, do ye? Then let's play."
	L.alleria_windrunner_warmup_trigger = "Mother... do not listen to the whispers!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"altpower",
		{311996, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Open Vision
		307870, -- Sanity Restoration Orb
		"portal_closed",
		-- Madnesses
		{311390, "EMPHASIZE"}, -- Madness: Entomophobia
		292240, -- Entomophobia
		306583, -- Leaden Foot
		315385, -- Scorched Feet
		313303, -- Burned Bridge
		-- Potions
		315814, -- Fermented Mixture
		315807, -- Noxious Mixture
		315845, -- Sluggish Potion
		315849, -- Sickening Potion
		315817, -- Spicy Potion
		-- Buffs
		313698, -- Gift of the Titans
		312456, -- Elite Extermination
		314203, -- Requited Bulwark
		312355, -- Bear Spirit
		314165, -- Empowered
		314087, -- Enriched
		-- Crawling Corruption
		296510, -- Creepy Crawler
		-- Enthralled Footman
		{298584, "NAMEPLATE"}, -- Repel
		-- Fallen Voidspeaker
		{308375, "NAMEPLATE"}, -- Psychic Scream
		-- Void Globule
		296492, -- Void Eruption
		-- Fallen Heartpiercer
		{308308, "NAMEPLATE"}, -- Piercing Shot
		-- Fallen Riftwalker
		{308481, "NAMEPLATE"}, -- Rift Strike
		308575, -- Shadow Shift
		-- Cultist Slavedriver
		{309882, "NAMEPLATE"}, -- Brutal Smash
		-- Cultist Tormenter
		{296537, "NAMEPLATE"}, -- Mental Assault
		-- Inquisitor Darkspeak
		308366, -- Agonizing Torment
		{308380, "NAMEPLATE"}, -- Convert
		-- Fallen Taskmaster
		{308998, "NAMEPLATE"}, -- Improve Morale
		{308967, "NAMEPLATE"}, -- Continuous Beatings
		-- Faceless Willbreaker
		{296718, "NAMEPLATE"}, -- Dark Smash
		-- Enthralled Weaponsmith
		{306770, "NAMEPLATE"}, -- Forge Breath
		-- Forge-Guard Hurrul
		{308406, "NAMEPLATE"}, -- Entropic Leap
		{308432, "DISPEL", "NAMEPLATE"}, -- Void-Tainted Blades
		-- SI:7 Informant
		{298033, "NAMEPLATE"}, -- Touch of the Abyss
		-- Armsmaster Terenson
		{311399, "NAMEPLATE"}, -- Blade Flourish
		{311456, "NAMEPLATE"}, -- Roaring Blast
		-- Burrowing Appendage
		298074, -- Rupture
		-- Dod
		{264398, "NAMEPLATE"}, -- Hoppy Finish
		{308346, "NAMEPLATE"}, -- Barrel Aged
		-- Alx'kov the Infested
		{308265, "DISPEL", "NAMEPLATE"}, -- Corrupted Blight
		{296669, "NAMEPLATE"}, -- Lurking Appendage
		{308305, "SAY"}, -- Blight Eruption
		-- Greater Void Elemental
		{297315, "NAMEPLATE"}, -- Void Buffet
		-- Boundless Corruption
		{296911, "NAMEPLATE"}, -- Chaos Breath
		-- Zardeth of the Black Claw
		{308801, "NAMEPLATE"}, -- Rain of Fire
		{308878, "NAMEPLATE"}, -- Twisted Summons
		-- Unstable Servant
		308862, -- Unstable Eruption
		-- Hogger
		{1223111, "ME_ONLY", "NAMEPLATE"}, -- Vicious Slice
		{1223112, "NAMEPLATE"}, -- Maddening Call
		86736, -- Enrage
		-- Void-Scarred Gryphon
		{250505, "NAMEPLATE"}, -- Hysteria
		{258768, "NAMEPLATE"}, -- Splitting Slash
	}, {
		["altpower"] = "general",
		[311390] = L.madnesses,
		[315814] = L.potions,
		[313698] = L.buffs,
		[296510] = L.crawling_corruption,
		[298584] = L.enthralled_footman,
		[308375] = L.fallen_voidspeaker,
		[296492] = L.void_globule,
		[308308] = L.fallen_heartpiercer,
		[308481] = L.fallen_riftwalker,
		[309882] = L.cultist_slavedriver,
		[296537] = L.cultist_tormenter,
		[308366] = L.inquisitor_darkspeak,
		[308998] = L.fallen_taskmaster,
		[296718] = L.faceless_willbreaker,
		[306770] = L.enthralled_weaponsmith,
		[308406] = L.forge_guard_hurrul,
		[298033] = L.si7_informant,
		[311399] = L.armsmaster_terenson,
		[298074] = L.burrowing_appendage,
		[264398] = L.dod,
		[308265] = L.alxkov_the_infested,
		[297315] = L.greater_void_elemental,
		[296911] = L.boundless_corruption,
		[308801] = L.zardeth_of_the_black_claw,
		[308862] = L.unstable_servant,
		[1223111] = L.hogger,
		[250505] = L.void_scarred_gryphon,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Sanity
	self:OpenAltPower("altpower", 318335, "ZA")

	self:RegisterEvent("UNIT_SPELLCAST_START") -- Open Vision, Hoppy Finish

	-- Sanity Restoration Orb
	self:Log("SPELL_CAST_START", "SanityRestorationOrb", 307870)

	-- Madnesses
	self:Log("SPELL_AURA_APPLIED_DOSE", "MadnessEntomophobiaApplied", 311390)
	self:Log("SPELL_AURA_APPLIED", "EntomophobiaApplied", 292240)
	self:Log("SPELL_AURA_APPLIED_DOSE", "LeadenFootApplied", 306583)
	self:Log("SPELL_AURA_APPLIED", "ScorchedFeetApplied", 315385)
	self:Log("SPELL_PERIODIC_ENERGIZE", "BurnedBridge", 313303)

	-- Potions
	self:Log("SPELL_ENERGIZE", "FermentedMixture", 315814)
	self:Log("SPELL_ENERGIZE", "NoxiousMixture", 315807)
	self:InitBuffs() -- reload protection
	self:RegisterUnitEvent("UNIT_AURA", nil, "player")

	-- Buffs
	self:Log("SPELL_ENERGIZE", "EliteExtermination", 312456)
	self:Log("SPELL_AURA_APPLIED", "BuffApplied", 314203, 312355, 314165, 314087) -- Requited Bulwark, Bear Spirit, Empowered, Enriched

	-- Crawling Corruption
	self:Log("SPELL_CAST_START", "CreepyCrawler", 296510)

	-- Enthralled Footman
	self:RegisterEngageMob("EnthralledFootmanEngaged", 153760, 241715) -- Enthralled Footman, Vengeful Footman
	self:Log("SPELL_CAST_SUCCESS", "Repel", 298584)
	self:Death("EnthralledFootmanDeath", 153760, 241715) -- Enthralled Footman, Vengeful Footman

	-- Fallen Voidspeaker
	self:RegisterEngageMob("FallenVoidspeakerEngaged", 152722, 159275, 241718, 157700) -- Fallen Voidspeaker, Portal Keeper, Vengeful Voidspeaker, Agustus Moulaine
	self:Log("SPELL_CAST_START", "PsychicScream", 308375)
	self:Log("SPELL_INTERRUPT", "PsychicScreamInterrupt", 308375)
	self:Log("SPELL_CAST_SUCCESS", "PsychicScreamSuccess", 308375)
	self:Death("FallenVoidspeakerDeath", 152722, 241718, 157700) -- Fallen Voidspeaker, Vengeful Voidspeaker, Agustus Moulaine
	self:Death("PortalKeeperDeath", 159275)

	-- Fallen Heartpiercer
	self:RegisterEngageMob("FallenHeartpiercerEngaged", 158092, 241717) -- Fallen Heartpiercer, Vengeful Heartpiercer
	self:Log("SPELL_CAST_START", "PiercingShot", 308308)
	self:Log("SPELL_CAST_SUCCESS", "PiercingShotSuccess", 308308)
	self:Death("FallenHeartpiercerDeath", 158092, 241717) -- Fallen Heartpiercer, Vengeful Heartpiercer

	-- Fallen Riftwalker
	self:RegisterEngageMob("FallenRiftwalkerEngaged", 158146)
	self:Log("SPELL_CAST_START", "RiftStrike", 308481)
	self:Log("SPELL_CAST_START", "ShadowShift", 308575)
	self:Death("FallenRiftwalkerDeath", 158146)

	-- Cultist Slavedriver
	self:RegisterEngageMob("CultistSlavedriverEngaged", 157158)
	self:Log("SPELL_CAST_START", "BrutalSmash", 309882)
	self:Death("CultistSlavedriverDeath", 157158)

	-- Cultist Tormenter
	self:RegisterEngageMob("CultistTormenterEngaged", 158690)
	self:Log("SPELL_CAST_START", "MentalAssault", 296537)
	self:Log("SPELL_INTERRUPT", "MentalAssaultInterrupt", 296537)
	self:Log("SPELL_CAST_SUCCESS", "MentalAssaultSuccess", 296537)
	self:Death("CultistTormenterDeath", 158690)

	-- Inquisitor Darkspeak
	self:RegisterEngageMob("InquisitorDarkspeakEngaged", 158136)
	self:Log("SPELL_CAST_START", "AgonizingTorment", 308366)
	self:Log("SPELL_CAST_START", "Convert", 308380)
	self:Death("InquisitorDarkspeakDeath", 158136)

	-- Fallen Taskmaster
	self:RegisterEngageMob("FallenTaskmasterEngaged", 158437)
	self:Log("SPELL_CAST_START", "ImproveMorale", 308998)
	self:Log("SPELL_CAST_SUCCESS", "ContinuousBeatings", 308967)
	self:Death("FallenTaskmasterDeath", 158437)

	-- Faceless Willbreaker
	self:RegisterEngageMob("FacelessWillbreakerEngaged", 152987, 164188) -- Faceless Willbreaker, Horrific Figment
	self:Log("SPELL_CAST_START", "DarkSmash", 296718)
	self:Death("FacelessWillbreakerDeath", 152987, 164188) -- Faceless Willbreaker, Horrific Figment

	-- Enthralled Weaponsmith
	self:RegisterEngageMob("EnthralledWeaponsmithEngaged", 156641)
	self:Log("SPELL_CAST_START", "ForgeBreath", 306770)
	self:Log("SPELL_INTERRUPT", "ForgeBreathInterrupt", 306770)
	self:Log("SPELL_CAST_SUCCESS", "ForgeBreathSuccess", 306770)
	self:Death("EnthralledWeaponsmithDeath", 156641)

	-- Forge-Guard Hurrul
	self:RegisterEngageMob("ForgeGuardHurrulEngaged", 158158)
	self:Log("SPELL_CAST_START", "EntropicLeap", 308406)
	self:Log("SPELL_CAST_SUCCESS", "VoidTaintedBlades", 308432)
	self:Log("SPELL_AURA_APPLIED", "VoidTaintedBladesApplied", 308432)
	self:Death("ForgeGuardHurrulDeath", 158158)

	-- SI:7 Informant
	self:RegisterEngageMob("SI7InformantEngaged", 156795)
	self:Log("SPELL_CAST_START", "TouchOfTheAbyss", 298033)
	self:Log("SPELL_INTERRUPT", "TouchOfTheAbyssInterrupt", 298033)
	self:Log("SPELL_CAST_SUCCESS", "TouchOfTheAbyssSuccess", 298033)
	self:Death("SI7InformantDeath", 156795)

	-- Armsmaster Terenson
	self:RegisterEngageMob("ArmsmasterTerensonEngaged", 156949)
	self:Log("SPELL_CAST_START", "BladeFlourish", 311399)
	self:Log("SPELL_CAST_START", "RoaringBlast", 311456)
	self:Death("ArmsmasterTerensonDeath", 156949)

	-- Burrowing Appendage
	self:Log("SPELL_CAST_SUCCESS", "Rupture", 298074)

	-- Dod
	self:RegisterEngageMob("DodEngaged", 156820)
	--self:Log("SPELL_CAST_START", "HoppyFinish", 264398) no CLEU
	self:Log("SPELL_CAST_START", "BarrelAged", 308346)
	self:Death("DodDeath", 156820)

	-- Alx'kov the Infested
	self:RegisterEngageMob("AlxkovTheInfestedEngaged", 152809)
	self:Log("SPELL_CAST_SUCCESS", "CorruptedBlight", 308265)
	self:Log("SPELL_AURA_APPLIED", "CorruptedBlightApplied", 308265)
	self:Log("SPELL_CAST_START", "LurkingAppendage", 296669)
	self:Log("SPELL_AURA_APPLIED", "LurkingAppendageDamage", 296674)
	self:Log("SPELL_PERIODIC_DAMAGE", "LurkingAppendageDamage", 296674)
	self:Log("SPELL_CAST_START", "BlightEruption", 308305)
	self:Death("AlxkovTheInfestedDeath", 152809)

	-- Greater Void Elemental
	self:RegisterEngageMob("GreaterVoidElementalEngaged", 153130)
	self:Log("SPELL_CAST_START", "VoidBuffet", 297315)
	self:Log("SPELL_INTERRUPT", "VoidBuffetInterrupt", 297315)
	self:Log("SPELL_CAST_SUCCESS", "VoidBuffetSuccess", 297315)
	self:Death("GreaterVoidElementalDeath", 153130)

	-- Portal Master
	self:Death("PortalMasterDeath", 159266)

	-- Boundless Corruption
	self:RegisterEngageMob("BoundlessCorruptionEngaged", 152939)
	self:Log("SPELL_CAST_START", "ChaosBreath", 296911)
	self:Death("BoundlessCorruptionDeath", 152939)

	-- Void Globule
	self:Log("SPELL_CAST_START", "VoidEruption", 296492)

	-- Zardeth of the Black Claw
	self:RegisterEngageMob("ZardethOfTheBlackClawEngaged", 158371)
	self:Log("SPELL_CAST_START", "RainOfFire", 308801)
	self:Log("SPELL_CAST_SUCCESS", "TwistedSummons", 308865, 308878)
	self:Death("ZardethOfTheBlackClawDeath", 158371)

	-- Unstable Servant
	self:Log("SPELL_CAST_START", "UnstableEruption", 308862)

	-- Hogger
	self:RegisterEngageMob("HoggerEngaged", 241698, 239437) -- WANTED: Hogger!!, Mask of the Nemesis
	self:Log("SPELL_CAST_SUCCESS", "ViciousSlice", 1223111)
	self:Log("SPELL_AURA_APPLIED", "ViciousSliceApplied", 1223111)
	self:Log("SPELL_CAST_START", "MaddeningCall", 1223112)
	self:Log("SPELL_INTERRUPT", "MaddeningCallInterrupt", 1223112)
	self:Log("SPELL_CAST_SUCCESS", "MaddeningCallSuccess", 1223112)
	self:Log("SPELL_CAST_SUCCESS", "Enrage", 86736)
	self:Death("HoggerDeath", 241698, 239437) -- WANTED: Hogger!!, Mask of the Nemesis

	-- Void-Scarred Gryphon
	self:RegisterEngageMob("VoidScarredGryphonEngaged", 237991)
	self:Log("SPELL_CAST_START", "Hysteria", 250505)
	self:Log("SPELL_INTERRUPT", "HysteriaInterrupt", 250505)
	self:Log("SPELL_CAST_SUCCESS", "HysteriaSuccess", 250505)
	self:Log("SPELL_CAST_START", "SplittingSlash", 258768)
	self:Log("SPELL_CAST_SUCCESS", "SplittingSlashSuccess", 258768)
	self:Death("VoidScarredGryphonDeath", 237991)
end

function mod:VerifyEnable()
	-- some enable mobs are shared with Horrific Vision of Orgrimmar
	local _, _, _, _, _, _, _, instanceId = GetInstanceInfo()
	return instanceId == 2213 or instanceId == 2827
end

function mod:OnBossDisable()
	portalsClosed = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.therum_deepforge_warmup_trigger then
		local therumDeepforgeModule = BigWigs:GetBossModule("Therum Deepforge", true)
		if therumDeepforgeModule then
			therumDeepforgeModule:Enable()
			therumDeepforgeModule:Warmup()
		end
	elseif msg == L.alleria_windrunner_warmup_trigger then
		local alleriaWindrunnerModule = BigWigs:GetBossModule("Alleria Windrunner", true)
		if alleriaWindrunnerModule then
			alleriaWindrunnerModule:Enable()
			alleriaWindrunnerModule:Warmup()
		end
	end
end

-- Image of Wrathion

do
	local prevCast
	function mod:UNIT_SPELLCAST_START(_, unit, castGUID, spellId)
		if spellId == 311996 and castGUID ~= prevCast then -- Open Vision (Image of Wrathion)
			prevCast = castGUID
			self:Message(spellId, "cyan")
			self:CastBar(spellId, 10)
			self:PlaySound(spellId, "long")
		elseif spellId == 264398 and castGUID ~= prevCast then -- Hoppy Finish (Dod)
			prevCast = castGUID
			self:HoppyFinish({sourceGUID = self:UnitGUID(unit)})
		end
	end
end

-- Sanity Restoration Orb

function mod:SanityRestorationOrb(args)
	self:Message(args.spellId, "green", CL.other:format(self:ColorName(args.sourceName), args.spellName))
	self:PlaySound(args.spellId, "info")
end

-- Madnesses

function mod:MadnessEntomophobiaApplied(args)
	local amount = args.amount or 1
	if self:Me(args.destGUID) and amount >= 3 then
		self:StackMessage(args.spellId, "blue", args.destName, amount, 5)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:EntomophobiaApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:LeadenFootApplied(args)
	local amount = args.amount or 1
	if self:Me(args.destGUID) and amount % 5 == 0 and amount >= 10 then
		self:StackMessage(args.spellId, "blue", args.destName, amount, 10)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:ScorchedFeetApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:BurnedBridge(args)
	if self:Me(args.destGUID) then
		local sanityLost = args.extraSpellId -- will be a negative number representing Sanity lost
		self:Message(args.spellId, "blue", CL.other:format(CL.underyou:format(args.spellName), L.sanity_change:format(sanityLost)))
		self:PlaySound(args.spellId, "underyou")
	end
end

-- Potions

function mod:FermentedMixture(args)
	if self:Me(args.destGUID) then
		local sanityGained = args.extraSpellId -- will be a positive number representing Sanity gained
		self:Message(args.spellId, "green", CL.other:format(args.spellName, L.sanity_change:format(sanityGained)))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:NoxiousMixture(args)
	if self:Me(args.destGUID) then
		local sanityLost = args.extraSpellId -- will be a negative number representing Sanity lost
		self:Message(args.spellId, "yellow", CL.other:format(args.spellName, L.sanity_change:format(sanityLost)))
		self:PlaySound(args.spellId, "warning")
	end
end

do
	local trackedBuffs = {
		[315845] = true, -- Sluggish Potion
		[315849] = true, -- Sickening Potion
		[315817] = true, -- Spicy Potion
		[313698] = true, -- Gift of the Titans
	}
	local activeBuffs = {}

	function mod:InitBuffs() -- reload protection
		activeBuffs = {}
		for spellId in next, trackedBuffs do
			local auraTbl = self:GetPlayerAura(spellId)
			if auraTbl then
				activeBuffs[auraTbl.auraInstanceID] = {auraTbl.expirationTime, spellId}
				if spellId == 315845 then -- Sluggish Potion
					self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.sluggish_potion_effect)
				elseif spellId == 315849 then -- Sickening Potion
					self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.sickening_potion_effect)
				elseif spellId == 315817 then -- Spicy Potion
					self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.spicy_potion_effect)
				elseif spellId == 313698 then -- Gift of the Titans
					self:Bar(spellId, auraTbl.expirationTime - GetTime())
				end
			end
		end
	end

	function mod:UNIT_AURA(_, _, updateInfo)
		if not updateInfo or updateInfo.isFullUpdate then
			self:InitBuffs()
		else
			if updateInfo.addedAuras then
				for i = 1, #updateInfo.addedAuras do
					local auraTbl = updateInfo.addedAuras[i]
					local spellId = auraTbl.spellId

					if trackedBuffs[spellId] then
						activeBuffs[auraTbl.auraInstanceID] = {auraTbl.expirationTime, spellId}
						if spellId == 315845 then -- Sluggish Potion
							self:Message(spellId, "green", CL.other:format(CL.you:format(auraTbl.name), L.sluggish_potion_effect))
							self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.sluggish_potion_effect)
							self:PlaySound(spellId, "info")
						elseif spellId == 315849 then -- Sickening Potion
							self:Message(spellId, "green", CL.other:format(CL.you:format(auraTbl.name), L.sickening_potion_effect))
							self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.sickening_potion_effect)
							self:PlaySound(spellId, "info")
						elseif spellId == 315817 then -- Spicy Potion
							self:Message(spellId, "green", CL.other:format(CL.you:format(auraTbl.name), L.spicy_potion_effect))
							self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.spicy_potion_effect)
							self:PlaySound(spellId, "info")
						elseif spellId == 313698 then -- Gift of the Titans
							self:Message(spellId, "green", CL.you:format(auraTbl.name))
							self:Bar(spellId, auraTbl.expirationTime - GetTime())
							self:PlaySound(spellId, "long")
						end
					end
				end
			end
			if updateInfo.removedAuraInstanceIDs then
				for i = 1, #updateInfo.removedAuraInstanceIDs do
					local hadBuff = activeBuffs[updateInfo.removedAuraInstanceIDs[i]]
					if hadBuff then
						local spellId = hadBuff[2]
						activeBuffs[updateInfo.removedAuraInstanceIDs[i]] = nil
						if spellId == 315845 then -- Sluggish Potion
							self:Message(spellId, "blue", CL.other:format(CL.removed:format(self:SpellName(spellId)), L.slowed))
							self:StopBar(L.sluggish_potion_effect)
							self:PlaySound(spellId, "warning")
						elseif spellId == 315849 then -- Sickening Potion
							self:Message(spellId, "blue", CL.other:format(CL.removed:format(self:SpellName(spellId)), self:SpellName(315850))) -- Vomit
							self:StopBar(L.sickening_potion_effect)
							self:PlaySound(spellId, "warning")
						elseif spellId == 315817 then -- Spicy Potion
							self:Message(spellId, "blue", CL.other:format(CL.removed:format(self:SpellName(spellId)), self:SpellName(315818))) -- Burning
							self:StopBar(L.spicy_potion_effect)
							self:PlaySound(spellId, "warning")
						elseif spellId == 313698 then -- Gift of the Titans
							self:StopBar(spellId)
						end
					end
				end
			end
			if updateInfo.updatedAuraInstanceIDs then
				for i = 1, #updateInfo.updatedAuraInstanceIDs do
					local hadBuff = activeBuffs[updateInfo.updatedAuraInstanceIDs[i]]
					if hadBuff then
						local spellId = hadBuff[2]
						local auraTbl = self:GetPlayerAura(spellId)
						if hadBuff[1] ~= auraTbl.expirationTime then
							activeBuffs[updateInfo.updatedAuraInstanceIDs[i]][1] = auraTbl.expirationTime
							if spellId == 315845 then -- Sluggish Potion
								self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.sluggish_potion_effect)
							elseif spellId == 315849 then -- Sickening Potion
								self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.sickening_potion_effect)
							elseif spellId == 315817 then -- Spicy Potion
								self:Bar(spellId, auraTbl.expirationTime - GetTime(), L.spicy_potion_effect)
							elseif spellId == 313698 then -- Gift of the Titans
								self:Bar(spellId, auraTbl.expirationTime - GetTime())
							end
						end
					end
				end
			end
		end
	end
end

-- Buffs

function mod:EliteExtermination(args)
	if self:Me(args.destGUID) then
		local sanityGained = args.extraSpellId -- will be a positive number representing Sanity gained
		self:Message(args.spellId, "green", CL.other:format(args.spellName, L.sanity_change:format(sanityGained)))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:BuffApplied(args)
	if self:Me(args.destGUID) then
		if self:Solo() then
			self:Message(args.spellId, "green", CL.you:format(args.spellName))
		else
			self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
		end
		self:PlaySound(args.spellId, "info")
	end
end

-- Crawling Corruption

do
	local prev = 0
	function mod:CreepyCrawler(args)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Enthralled Footman

function mod:EnthralledFootmanEngaged(guid)
	-- Repel not cast until ~75%, but the initial CD is high enough to start a timer here
	self:Nameplate(298584, 5.6, guid) -- Repel
end

function mod:Repel(args)
	self:Message(args.spellId, "cyan")
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:EnthralledFootmanDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Fallen Voidspeaker

function mod:FallenVoidspeakerEngaged(guid)
	self:Nameplate(308375, 6.7, guid) -- Psychic Scream
end

function mod:PsychicScream(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:PsychicScreamInterrupt(args)
	self:Nameplate(308375, 17.4, args.destGUID)
end

function mod:PsychicScreamSuccess(args)
	self:Nameplate(args.spellId, 17.4, args.sourceGUID)
end

function mod:FallenVoidspeakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

function mod:PortalKeeperDeath(args)
	portalsClosed = portalsClosed + 1
	self:ClearNameplate(args.destGUID)
	self:Message("portal_closed", "green", CL.count_amount:format(L.portal_closed, portalsClosed, 5), L.portal_closed_icon)
	self:PlaySound("portal_closed", "info")
end

-- Fallen Heartpiercer

function mod:FallenHeartpiercerEngaged(guid)
	self:Nameplate(308308, 3.2, guid) -- Piercing Shot
end

do
	local function printTarget(self, name)
		self:TargetMessage(308308, "yellow", name)
		self:PlaySound(308308, "alarm", nil, name)
	end

	local prev = 0
	function mod:PiercingShot(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1 then
			prev = args.time
			self:GetUnitTarget(printTarget, 0.6, args.sourceGUID)
		end
	end
end

function mod:PiercingShotSuccess(args)
	self:Nameplate(args.spellId, 10.4, args.sourceGUID)
end

function mod:FallenHeartpiercerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Fallen Riftwalker

function mod:FallenRiftwalkerEngaged(guid)
	self:Nameplate(308481, 2.4, guid) -- Rift Strike
end

do
	local prev = 0
	function mod:RiftStrike(args)
		self:Nameplate(args.spellId, 14.6, args.sourceGUID)
		if args.time - prev > 1 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:ShadowShift(args)
		-- cast once at 60%
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.percent:format(60, CL.casting:format(args.spellName)))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:FallenRiftwalkerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cultist Slavedriver

function mod:CultistSlavedriverEngaged(guid)
	self:Nameplate(309882, 3.5, guid) -- Brutal Smash
end

do
	local prev = 0
	function mod:BrutalSmash(args)
		self:Nameplate(args.spellId, 13.3, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:CultistSlavedriverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cultist Tormenter

function mod:CultistTormenterEngaged(guid)
	self:Nameplate(296537, 3.2, guid) -- Mental Assault
end

function mod:MentalAssault(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:MentalAssaultInterrupt(args)
	-- this happens when interrupting either the initial cast or the channel.
	-- this means interrupting the channel resets the CD to the full 15s.
	self:Nameplate(296537, 15.0, args.destGUID)
end

function mod:MentalAssaultSuccess(args)
	self:Nameplate(args.spellId, 15.0, args.sourceGUID)
end

function mod:CultistTormenterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Inquisitor Darkspeak

do
	local timer

	function mod:InquisitorDarkspeakEngaged(guid)
		self:CDBar(308380, 15.2) -- Convert
		self:Nameplate(308380, 15.2, guid) -- Convert
		timer = self:ScheduleTimer("InquisitorDarkspeakDeath", 20, nil, guid)
	end

	function mod:AgonizingTorment(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		timer = self:ScheduleTimer("InquisitorDarkspeakDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:Convert(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 42.5)
		self:Nameplate(args.spellId, 42.5, args.sourceGUID)
		timer = self:ScheduleTimer("InquisitorDarkspeakDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:InquisitorDarkspeakDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(308380) -- Convert
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Fallen Taskmaster

function mod:FallenTaskmasterEngaged(guid)
	self:Nameplate(308998, 4.3, guid) -- Improve Morale
	self:Nameplate(308967, 10.5, guid) -- Continuous Beatings
end

function mod:ImproveMorale(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 15.7, args.sourceGUID) -- cooldown on cast start
	self:PlaySound(args.spellId, "alert")
end

function mod:ContinuousBeatings(args)
	self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.sourceName))
	self:Nameplate(args.spellId, 21.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:FallenTaskmasterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Faceless Willbreaker

function mod:FacelessWillbreakerEngaged(guid)
	-- Dark Smash not cast until ~75%, but the initial CD is high enough to start a timer here
	self:Nameplate(296718, 3.4, guid) -- Dark Smash
end

function mod:DarkSmash(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 7.2, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:FacelessWillbreakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Enthralled Weaponsmith

function mod:EnthralledWeaponsmithEngaged(guid)
	self:Nameplate(306770, 6.8, guid) -- Forge Breath
end

function mod:ForgeBreath(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ForgeBreathInterrupt(args)
	self:Nameplate(306770, 10.1, args.destGUID)
end

function mod:ForgeBreathSuccess(args)
	self:Nameplate(args.spellId, 10.1, args.sourceGUID)
end

function mod:EnthralledWeaponsmithDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Forge-Guard Hurrul

do
	local timer

	function mod:ForgeGuardHurrulEngaged(guid)
		self:CDBar(308432, 5.0) -- Void-Tainted Blades
		self:Nameplate(308432, 5.0, guid) -- Void-Tainted Blades
		self:CDBar(308406, 9.1) -- Entropic Leap
		self:Nameplate(308406, 9.1, guid) -- Entropic Leap
		timer = self:ScheduleTimer("ForgeGuardHurrulDeath", 20, nil, guid)
	end

	do
		local prev = 0
		function mod:EntropicLeap(args)
			-- casts 3x in a row over ~5s, show the timer for the first cast in the sequence
			if args.time - prev > 10 then
				if timer then
					self:CancelTimer(timer)
				end
				prev = args.time
				self:CDBar(args.spellId, 25.5)
				self:Nameplate(args.spellId, 25.5, args.sourceGUID)
				timer = self:ScheduleTimer("ForgeGuardHurrulDeath", 30, nil, args.sourceGUID)
			end
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end

	function mod:VoidTaintedBlades(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 26.7)
		self:Nameplate(args.spellId, 26.7, args.sourceGUID)
		timer = self:ScheduleTimer("ForgeGuardHurrulDeath", 30, nil, args.sourceGUID)
	end

	function mod:VoidTaintedBladesApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end

	function mod:ForgeGuardHurrulDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(308406) -- Entropic Leap
		self:StopBar(308432) -- Void-Tainted Blades
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- SI:7 Informant

function mod:SI7InformantEngaged(guid)
	self:Nameplate(298033, 7.2, guid) -- Touch of the Abyss
end

do
	local prev = 0
	function mod:TouchOfTheAbyss(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:TouchOfTheAbyssInterrupt(args)
	self:Nameplate(298033, 15.0, args.destGUID)
end

function mod:TouchOfTheAbyssSuccess(args)
	self:Nameplate(args.spellId, 15.0, args.sourceGUID)
end

function mod:SI7InformantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Armsmaster Terenson

do
	local timer

	function mod:ArmsmasterTerensonEngaged(guid)
		self:CDBar(311399, 3.2) -- Blade Flourish
		self:Nameplate(311399, 3.2, guid) -- Blade Flourish
		self:CDBar(311456, 9.4) -- Roaring Blast
		self:Nameplate(311456, 9.4, guid) -- Roaring Blast
		timer = self:ScheduleTimer("ArmsmasterTerensonDeath", 20, nil, guid)
	end

	function mod:BladeFlourish(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 13.7)
		self:Nameplate(args.spellId, 13.7, args.sourceGUID)
		timer = self:ScheduleTimer("ArmsmasterTerensonDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:RoaringBlast(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 17.0)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		timer = self:ScheduleTimer("ArmsmasterTerensonDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end

	function mod:ArmsmasterTerensonDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(311399) -- Blade Flourish
		self:StopBar(311456) -- Roaring Blast
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Burrowing Appendage

do
	local prev = 0
	function mod:Rupture(args)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Dod

do
	local timer

	function mod:DodEngaged(guid)
		self:CDBar(264398, 2.4) -- Hoppy Finish
		self:Nameplate(264398, 2.4, guid) -- Hoppy Finish
		self:CDBar(308346, 9.6) -- Barrel Aged
		self:Nameplate(308346, 9.6, guid) -- Barrel Aged
		timer = self:ScheduleTimer("DodDeath", 20, nil, guid)
	end

	function mod:HoppyFinish(args) -- not in CLEU, so can't use args.spellId
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(264398, "yellow")
		self:CDBar(264398, 19.8)
		if args.sourceGUID then -- remove check if this is added to CLEU
			self:Nameplate(264398, 19.8, args.sourceGUID)
			timer = self:ScheduleTimer("DodDeath", 30, nil, args.sourceGUID)
		end
		self:PlaySound(264398, "alarm")
	end

	function mod:BarrelAged(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 19.4)
		self:Nameplate(args.spellId, 19.4, args.sourceGUID)
		timer = self:ScheduleTimer("DodDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:DodDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(264398) -- Hoppy Finish
		self:StopBar(308346) -- Barrel Aged
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Alx'kov the Infested

do
	local timer

	function mod:AlxkovTheInfestedEngaged(guid)
		self:CDBar(308265, 6.1) -- Corrupted Blight
		self:Nameplate(308265, 6.1, guid) -- Corrupted Blight
		self:CDBar(296669, 10.7) -- Lurking Appendage
		self:Nameplate(296669, 10.7, guid) -- Lurking Appendage
		timer = self:ScheduleTimer("AlxkovTheInfestedDeath", 20, nil, guid)
	end

	function mod:CorruptedBlight(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 11.2)
		self:Nameplate(args.spellId, 11.2, args.sourceGUID)
		timer = self:ScheduleTimer("AlxkovTheInfestedDeath", 30, nil, args.sourceGUID)
	end

	function mod:CorruptedBlightApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
			self:TargetMessage(args.spellId, "red", args.destName)
			if self:Dispeller("disease") then
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			else
				self:PlaySound(args.spellId, "info", nil, args.destName)
			end
		end
	end

	function mod:LurkingAppendage(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 11.2)
		self:Nameplate(args.spellId, 11.2, args.sourceGUID)
		timer = self:ScheduleTimer("AlxkovTheInfestedDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	do
		local prev = 0
		function mod:LurkingAppendageDamage(args)
			if self:Me(args.destGUID) and args.time - prev > 2 then
				prev = args.time
				self:PersonalMessage(296669, "underyou")
				self:PlaySound(296669, "underyou")
			end
		end
	end

	function mod:BlightEruption(args)
		-- cast 10s after Corrupted Blight applied, but only if it hasn't been removed
		self:Message(args.spellId, "orange")
		if self:UnitDebuff("player", 308265) then -- Corrupted Blight
			self:Say(args.spellId, nil, nil, "Blight Eruption")
		end
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:AlxkovTheInfestedDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(308265) -- Corrupted Blight
		self:StopBar(296669) -- Lurking Appendage
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Greater Void Elemental

function mod:GreaterVoidElementalEngaged(guid)
	self:Nameplate(297315, 2.2, guid) -- Void Buffet
end

function mod:VoidBuffet(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidBuffetInterrupt(args)
	self:Nameplate(297315, 6.5, args.destGUID)
end

function mod:VoidBuffetSuccess(args)
	self:Nameplate(args.spellId, 6.5, args.sourceGUID)
end

function mod:GreaterVoidElementalDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Portal Master

function mod:PortalMasterDeath(args)
	portalsClosed = portalsClosed + 1
	self:Message("portal_closed", "green", CL.count_amount:format(L.portal_closed, portalsClosed, 5), L.portal_closed_icon)
	self:PlaySound("portal_closed", "info")
end

-- Boundless Corruption

do
	local timer

	function mod:BoundlessCorruptionEngaged(guid)
		self:CDBar(296911, 6.0) -- Chaos Breath
		self:Nameplate(296911, 6.0, guid) -- Chaos Breath
		timer = self:ScheduleTimer("BoundlessCorruptionDeath", 20, nil, guid)
	end

	function mod:ChaosBreath(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 12.2)
		self:Nameplate(args.spellId, 12.2, args.sourceGUID)
		timer = self:ScheduleTimer("BoundlessCorruptionDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:BoundlessCorruptionDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(296911) -- Chaos Breath
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Void Globule

do
	local prev = 0
	function mod:VoidEruption(args)
		-- cast on death
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Zardeth of the Black Claw

do
	local timer

	function mod:ZardethOfTheBlackClawEngaged(guid)
		self:CDBar(308801, 3.9) -- Rain of Fire
		self:Nameplate(308801, 3.9, guid) -- Rain of Fire
		self:CDBar(308878, 9.4) -- Twisted Summons
		self:Nameplate(308878, 9.4, guid) -- Twisted Summons
		timer = self:ScheduleTimer("ZardethOfTheBlackClawDeath", 20, nil, guid)
	end

	function mod:RainOfFire(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 10.9)
		self:Nameplate(args.spellId, 10.9, args.sourceGUID)
		timer = self:ScheduleTimer("ZardethOfTheBlackClawDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:TwistedSummons(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(308878, "cyan")
		-- 308878 seems to be on a separate, inconsistent timer
		if args.spellId == 308865 then
			self:CDBar(308878, 16.2)
			self:Nameplate(308878, 16.2, args.sourceGUID)
		end
		timer = self:ScheduleTimer("ZardethOfTheBlackClawDeath", 30, nil, args.sourceGUID)
		self:PlaySound(308878, "info")
	end

	function mod:ZardethOfTheBlackClawDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		portalsClosed = portalsClosed + 1
		self:StopBar(308801) -- Rain of Fire
		self:StopBar(308878) -- Twisted Summons
		self:ClearNameplate(guidFromTimer or args.destGUID)
		self:Message("portal_closed", "green", CL.count_amount:format(L.portal_closed, portalsClosed, 5), L.portal_closed_icon)
		self:PlaySound("portal_closed", "info")
	end
end

-- Unstable Servant

do
	local prev = 0
	function mod:UnstableEruption(args)
		-- cast on death
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Hogger

do
	local timer

	function mod:HoggerEngaged(guid)
		self:CDBar(1223111, 5.0) -- Vicious Slice
		self:Nameplate(1223111, 5.0, guid) -- Vicious Slice
		self:CDBar(1223112, 9.8) -- Maddening Call
		self:Nameplate(1223112, 9.8, guid) -- Maddening Call
		timer = self:ScheduleTimer("HoggerDeath", 20, nil, guid)
	end

	function mod:ViciousSlice(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 10.1)
		self:Nameplate(args.spellId, 10.1, args.sourceGUID)
		timer = self:ScheduleTimer("HoggerDeath", 30, nil, args.sourceGUID)
	end

	function mod:ViciousSliceApplied(args)
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end

	function mod:MaddeningCall(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("HoggerDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:MaddeningCallInterrupt(args)
		self:CDBar(1223112, 15.2)
		self:Nameplate(1223112, 15.2, args.destGUID)
	end

	function mod:MaddeningCallSuccess(args)
		self:CDBar(args.spellId, 15.2)
		self:Nameplate(args.spellId, 15.2, args.sourceGUID)
	end

	function mod:Enrage(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.sourceName))
		timer = self:ScheduleTimer("HoggerDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:HoggerDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1223111) -- Vicious Slice
		self:StopBar(1223112) -- Maddening Call
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Void-Scarred Gryphon

do
	local timer

	function mod:VoidScarredGryphonEngaged(guid)
		self:CDBar(250505, 6.0) -- Hysteria
		self:Nameplate(250505, 6.0, guid) -- Hysteria
		self:CDBar(258768, 10.9) -- Splitting Slash
		self:Nameplate(258768, 10.9, guid) -- Splitting Slash
		timer = self:ScheduleTimer("VoidScarredGryphonDeath", 20, nil, guid)
	end

	function mod:Hysteria(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("VoidScarredGryphonDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end

	function mod:HysteriaInterrupt(args)
		self:CDBar(250505, 17.5)
		self:Nameplate(250505, 17.5, args.destGUID)
	end

	function mod:HysteriaSuccess(args)
		self:CDBar(args.spellId, 17.5)
		self:Nameplate(args.spellId, 17.5, args.sourceGUID)
	end

	function mod:SplittingSlash(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("VoidScarredGryphonDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:SplittingSlashSuccess(args)
		self:CDBar(args.spellId, 20.1)
		self:Nameplate(args.spellId, 20.1, args.sourceGUID)
	end

	function mod:VoidScarredGryphonDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(250505) -- Hysteria
		self:StopBar(258768) -- Splitting Slash
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end
