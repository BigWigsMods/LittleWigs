--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Horrific Vision of Orgrimmar Trash", 2212)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	155604, -- Image of Wrathion
	233236, -- Image of Wrathion (Revisited only)
	153097, -- Voidbound Shaman
	153141, -- Endless Hunger Totem
	152704, -- Crawling Corruption
	157268, -- Crawling Corruption
	157604, -- Crawling Corruption
	152669, -- Void Globule
	157603, -- Void Globule
	160704, -- Letter Encrusted Void Globule
	153065, -- Voidbound Ravager
	156406, -- Voidbound Honor Guard
	156146, -- Voidbound Shieldbearer
	158565, -- Naros
	240675, -- Barkeep Morag (Revisited only)
	153943, -- Decimator Shiq'voth
	152993, -- Garona Halforcen
	152699, -- Voidbound Berserker
	161140, -- Bwemba
	153130, -- Greater Void Elemental
	152987, -- Faceless Willbreaker
	157608, -- Faceless Willbreaker
	164188, -- Horrific Figment
	153942, -- Annihilator Lak'hal
	153401, -- K'thir Dominator
	157610, -- K'thir Dominator
	244186, -- K'thir Dominator (Revisited only)
	154524, -- K'thir Mindcarver
	157609, -- K'thir Mindcarver
	156653, -- Coagulated Horror
	156143, -- Voidcrazed Hulk
	155656, -- Misha
	157904, -- Aqir Scarab
	153531, -- Aqir Bonecrusher
	153532, -- Aqir Mindhunter
	156089, -- Aqir Venomweaver
	153526, -- Aqir Swarmer
	153527, -- Aqir Swarmer
	241702, -- Gamon (Gamon's Axe) (Revisited only)
	240672 -- Gamon (Mask of the Nemesis) (Revisited only)
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sanity_change = "%d Sanity"
	L.madnesses = "Madnesses"
	L.potions = "Potions"
	L.buffs = "Buffs"
	L.slowed = "Slowed"
	L.sluggish_potion_effect = "Heal 2% every 5 sec"
	L.sickening_potion_effect = "5% damage reduction"
	L.spicy_potion_effect = "Breathe fire"

	L.voidbound_shaman = "Voidbound Shaman"
	L.endless_hunger_totem = "Endless Hunger Totem"
	L.crawling_corruption = "Crawling Corruption"
	L.void_globule = "Void Globule"
	L.voidbound_ravager = "Voidbound Ravager"
	L.voidbound_honor_guard = "Voidbound Honor Guard"
	L.voidbound_shieldbearer = "Voidbound Shieldbearer"
	L.naros = "Naros"
	L.barkeep_morag = "Barkeep Morag"
	L.decimator_shiqvoth = "Decimator Shiq'voth"
	L.voidbound_berserker = "Voidbound Berserker"
	L.bwemba = "Bwemba"
	L.greater_void_elemental = "Greater Void Elemental"
	L.faceless_willbreaker = "Faceless Willbreaker"
	L.burrowing_appendage = "Burrowing Appendage"
	L.annihilator_lakhal = "Annihilator Lak'hal"
	L.kthir_dominator = "K'thir Dominator"
	L.kthir_mindcarver = "K'thir Mindcarver"
	L.coagulated_horror = "Coagulated Horror"
	L.voidcrazed_hulk = "Voidcrazed Hulk"
	L.misha = "Misha"
	L.aqir_scarab = "Aqir Scarab"
	L.aqir_bonecrusher = "Aqir Bonecrusher"
	L.aqir_mindhunter = "Aqir Mindhunter"
	L.aqir_venomweaver = "Aqir Venomweaver"
	L.gamon = "Gamon"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		-- General
		"altpower",
		autotalk,
		{311996, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Open Vision
		307870, -- Sanity Restoration Orb
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
		313770, -- Smith's Strength
		1225675, -- Prohibition
		313670, -- Spirit of Wind
		313961, -- Ethereal Essence
		-- Voidbound Shaman
		{297237, "NAMEPLATE"}, -- Endless Hunger Totem
		-- Endless Hunger Totem
		297302, -- Endless Hunger
		-- Crawling Corruption
		296510, -- Creepy Crawler
		-- Void Globule
		296492, -- Void Eruption
		-- Voidbound Ravager
		{297161, "NAMEPLATE"}, -- Bladestorm
		-- Voidbound Honor Guard
		{305369, "NAMEPLATE"}, -- Break Spirit
		305378, -- Horrifying Shout
		-- Voidbound Shieldbearer
		{298630, "NAMEPLATE"}, -- Shockwave
		-- Naros
		{306770, "NAMEPLATE"}, -- Forge Breath
		{319304, "DISPEL", "NAMEPLATE"}, -- Shadow Brand
		-- Barkeep Morag
		{308346, "NAMEPLATE"}, -- Barrel Aged
		-- Decimator Shiq'voth
		{300351, "NAMEPLATE"}, -- Surging Fist
		{300388, "NAMEPLATE"}, -- Decimator
		-- Voidbound Berserker
		{297146, "DISPEL"}, -- Shadow Brand
		-- Bwemba
		{11641, "DISPEL", "NAMEPLATE"}, -- Hex
		-- Greater Void Elemental
		{297315, "NAMEPLATE"}, -- Void Buffet
		-- Faceless Willbreaker
		{296718, "NAMEPLATE"}, -- Dark Smash
		-- Burrowing Appendage
		298074, -- Rupture
		-- Annihilator Lak'hal
		{299110, "NAMEPLATE"}, -- Orb of Annihilation
		{299055, "SAY", "NAMEPLATE"}, -- Dark Force
		-- K'thir Dominator
		{298033, "NAMEPLATE"}, -- Touch of the Abyss
		-- K'thir Mindcarver
		300530, -- Mind Carver
		-- Coagulated Horror
		{303589, "NAMEPLATE"}, -- Sanguine Residue
		{305875, "NAMEPLATE"}, -- Visceral Fluid
		-- Voidcrazed Hulk
		{306199, "NAMEPLATE"}, -- Howling in Pain
		{306001, "NAMEPLATE"}, -- Explosive Leap
		-- Misha
		{304165, "DISPEL", "NAMEPLATE"}, -- Desperate Retching
		{304101, "NAMEPLATE"}, -- Maddening Roar
		-- Aqir Scarab
		308018, -- Ruptured Carapace
		-- Aqir Bonecrusher
		{298502, "NAMEPLATE"}, -- Toxic Breath
		{298510, "DISPEL"}, -- Aqiri Mind Toxin
		-- Aqir Mindhunter
		{304169, "NAMEPLATE"}, -- Toxic Volley
		-- Aqir Venomweaver
		{312584, "NAMEPLATE"}, -- Concentrated Venom
		{305236, "OFF"}, -- Venom Bolt
		-- Gamon
		{314720, "NAMEPLATE"}, -- Whirlwind
		{314723, "NAMEPLATE"}, -- War Stomp
	}, {
		["altpower"] = "general",
		[311390] = L.madnesses,
		[315814] = L.potions,
		[313698] = L.buffs,
		[297237] = L.voidbound_shaman,
		[297302] = L.endless_hunger_totem,
		[296510] = L.crawling_corruption,
		[305369] = L.voidbound_honor_guard,
		[298630] = L.voidbound_shieldbearer,
		[306770] = L.naros,
		[308346] = L.barkeep_morag,
		[300351] = L.decimator_shiqvoth,
		[297146] = L.voidbound_berserker,
		[11641] = L.bwemba,
		[297315] = L.greater_void_elemental,
		[296718] = L.faceless_willbreaker,
		[298074] = L.burrowing_appendage,
		[299110] = L.annihilator_lakhal,
		[298033] = L.kthir_dominator,
		[300530] = L.kthir_mindcarver,
		[303589] = L.coagulated_horror,
		[306199] = L.voidcrazed_hulk,
		[304165] = L.misha,
		[308018] = L.aqir_scarab,
		[298502] = L.aqir_bonecrusher,
		[304169] = L.aqir_mindhunter,
		[312584] = L.aqir_venomweaver,
		[314720] = L.gamon,
	}
end

function mod:OnBossEnable()
	-- Sanity
	self:OpenAltPower("altpower", 318335, "ZA")

	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	self:RegisterEvent("UNIT_SPELLCAST_START") -- Open Vision
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- War Stomp

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
	self:Log("SPELL_AURA_APPLIED", "BuffApplied", 313770, 1225675, 313670, 313961) -- Smith's Strength, Prohibition, Spirit of Wind, Ethereal Essence

	-- Voidbound Shaman
	self:Log("SPELL_CAST_SUCCESS", "EndlessHungerTotem", 297237)
	self:Death("VoidboundShamanDeath", 153097)

	-- Endless Hunger Totem
	self:Log("SPELL_CAST_START", "EndlessHunger", 297302)

	-- Crawling Corruption
	self:Log("SPELL_CAST_START", "CreepyCrawler", 296510)

	-- Void Globule
	self:Log("SPELL_CAST_START", "VoidEruption", 296492)

	-- Voidbound Ravager
	self:Log("SPELL_CAST_START", "Bladestorm", 297161)

	-- Voidbound Honor Guard
	self:RegisterEngageMob("VoidboundHonorGuardEngaged", 156406)
	self:Log("SPELL_CAST_START", "BreakSpirit", 305369)
	self:Log("SPELL_CAST_START", "HorrifyingShout", 305378)
	self:Death("VoidboundHonorGuardDeath", 156406)

	-- Voidbound Shieldbearer
	self:RegisterEngageMob("VoidboundShieldbearerEngaged", 156146)
	self:Log("SPELL_CAST_START", "Shockwave", 298630)
	self:Death("VoidboundShieldbearerDeath", 156146)

	-- Naros
	self:RegisterEngageMob("NarosEngaged", 158565)
	self:Log("SPELL_CAST_START", "ForgeBreath", 306770)
	self:Log("SPELL_INTERRUPT", "ForgeBreathInterrupt", 306770)
	self:Log("SPELL_CAST_SUCCESS", "ForgeBreathSuccess", 306770)
	self:Log("SPELL_CAST_SUCCESS", "ShadowBrand", 319304)
	self:Log("SPELL_AURA_APPLIED", "ShadowBrandAppliedNaros", 319304)
	self:Death("NarosDeath", 158565)

	-- Barkeep Morag
	self:RegisterEngageMob("BarkeepMoragEngaged", 240675)
	self:Log("SPELL_CAST_START", "BarrelAged", 308346)
	self:Log("SPELL_CAST_SUCCESS", "BarrelAgedSuccess", 308346)
	self:Death("BarkeepMoragDeath", 240675)

	-- Decimator Shiq'voth
	self:RegisterEngageMob("DecimatorShiqvothEngaged", 153943)
	self:Log("SPELL_CAST_START", "SurgingFist", 300351)
	self:Log("SPELL_CAST_START", "Decimator", 300388)
	self:Death("DecimatorShiqvothDeath", 153943)

	-- Voidbound Berserker
	self:Log("SPELL_AURA_APPLIED", "ShadowBrandApplied", 297146)

	-- Bwemba
	self:RegisterEngageMob("BwembaEngaged", 161140)
	self:Log("SPELL_CAST_SUCCESS", "Hex", 11641)
	self:Log("SPELL_AURA_APPLIED", "HexApplied", 11641)
	self:Death("BwembaDeath", 161140)

	-- Greater Void Elemental
	self:RegisterEngageMob("GreaterVoidElementalEngaged", 153130)
	self:Log("SPELL_CAST_START", "VoidBuffet", 297315)
	self:Log("SPELL_INTERRUPT", "VoidBuffetInterrupt", 297315)
	self:Log("SPELL_CAST_SUCCESS", "VoidBuffetSuccess", 297315)
	self:Death("GreaterVoidElementalDeath", 153130)

	-- Faceless Willbreaker
	self:RegisterEngageMob("FacelessWillbreakerEngaged", 152987, 157608, 164188) -- Faceless Willbreaker, Faceless Willbreaker, Horrific Figment
	self:Log("SPELL_CAST_START", "DarkSmash", 296718)
	self:Death("FacelessWillbreakerDeath", 152987, 157608, 164188) -- Faceless Willbreaker, Faceless Willbreaker, Horrific Figment

	-- Burrowing Appendage
	self:Log("SPELL_CAST_SUCCESS", "Rupture", 298074)

	-- Annihilator Lak'hal
	self:RegisterEngageMob("AnnihilatorLakhalEngaged", 153942)
	self:Log("SPELL_CAST_START", "OrbOfAnnihilation", 299110)
	self:Log("SPELL_CAST_START", "DarkForce", 299055)
	self:Death("AnnihilatorLakhalDeath", 153942)

	-- K'thir Dominator
	self:RegisterEngageMob("KthirDominatorEngaged", 153401, 157610, 244186)
	self:Log("SPELL_CAST_START", "TouchOfTheAbyss", 298033)
	self:Log("SPELL_INTERRUPT", "TouchOfTheAbyssInterrupt", 298033)
	self:Log("SPELL_CAST_SUCCESS", "TouchOfTheAbyssSuccess", 298033)
	self:Death("KthirDominatorDeath", 153401, 157610, 244186)

	-- K'thir Mindcarver
	self:RegisterEvent("UNIT_POWER_FREQUENT")

	-- Coagulated Horror
	self:RegisterEngageMob("CoagulatedHorrorEngaged", 156653)
	self:Log("SPELL_CAST_START", "SanguineResidue", 303589)
	self:Log("SPELL_CAST_START", "VisceralFluid", 305875)
	self:Death("CoagulatedHorrorDeath", 156653)

	-- Voidcrazed Hulk
	self:RegisterEngageMob("VoidcrazedHulkEngaged", 156143)
	self:Log("SPELL_CAST_START", "HowlingInPain", 306199)
	self:Log("SPELL_CAST_START", "ExplosiveLeap", 306001)
	self:Death("VoidcrazedHulkDeath", 156143)

	-- Misha
	self:RegisterEngageMob("MishaEngaged", 155656)
	self:Log("SPELL_CAST_START", "DesperateRetching", 304165)
	self:Log("SPELL_AURA_APPLIED", "DesperateRetchingApplied", 304165)
	self:Log("SPELL_CAST_START", "MaddeningRoar", 304101)
	self:Death("MishaDeath", 155656)

	-- Aqir Scarab
	self:Log("SPELL_CAST_START", "RupturedCarapace", 308018)

	-- Aqir Bonecrusher
	self:RegisterEngageMob("AqirBonecrusherEngaged", 153531)
	self:Log("SPELL_CAST_START", "ToxicBreath", 298502)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AqiriMindToxinApplied", 298510)
	self:Death("AqirBonecrusherDeath", 153531)

	-- Aqir Mindhunter
	self:RegisterEngageMob("AqirMindhunterEngaged", 153532)
	self:Log("SPELL_CAST_START", "ToxicVolley", 304169)
	self:Death("AqirMindhunterDeath", 153532)

	-- Aqir Venomweaver
	self:RegisterEngageMob("AqirVenomweaverEngaged", 156089)
	self:Log("SPELL_CAST_START", "ConcentratedVenom", 312584)
	self:Log("SPELL_CAST_START", "VenomBolt", 305236)
	self:Death("AqirVenomweaverDeath", 156089)

	-- Gamon
	self:RegisterEngageMob("GamonEngaged", 241702, 240672) -- Gamon's Axe, Mask of the Nemesis
	self:Log("SPELL_CAST_START", "Whirlwind", 314720)
	--self:Log("SPELL_CAST_SUCCESS", "WarStomp", 314723) no CLEU
	self:Death("GamonDeath", 241702, 240672) -- Gamon's Axe, Mask of the Nemesis
end

function mod:VerifyEnable()
	-- some enable mobs are shared with Horrific Vision of Stormwind
	local _, _, _, _, _, _, _, instanceId = GetInstanceInfo()
	return instanceId == 2212 or instanceId == 2828 -- BFA, Revisited
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(49742) then -- The Drag, continue vision (Garona Halforcen)
			-- 49742:You have my aid. <Help Garona up>
			self:SelectGossipID(49742)
		end
	end
end

-- Image of Wrathion

function mod:UNIT_SPELLCAST_START(event, _, _, spellId)
	if spellId == 311996 then -- Open Vision
		self:UnregisterEvent(event)
		self:Message(spellId, "cyan")
		self:CastBar(spellId, 10)
		self:PlaySound(spellId, "long")
	end
end

do
	local prevCast = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, castGUID, spellId)
		if spellId == 314723 and castGUID ~= prevCast then -- War Stomp (Gamon)
			prevCast = castGUID
			self:WarStomp({sourceGUID = self:UnitGUID(unit)})
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

-- Voidbound Shaman

function mod:EndlessHungerTotem(args)
	-- not cast until 50%
	self:Message(args.spellId, "cyan", CL.spawning:format(args.spellName))
	self:Nameplate(args.spellId, 60.7, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:VoidboundShamanDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Endless Hunger Totem

function mod:EndlessHunger(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
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

-- Voidbound Ravager

do
	local prev = 0
	function mod:Bladestorm(args)
		-- not cast until 50% HP
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:Nameplate(args.spellId, 61.8, args.sourceGUID)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Voidbound Honor Guard

function mod:VoidboundHonorGuardEngaged(guid)
	self:Nameplate(305369, 3.7, guid) -- Break Spirit
end

do
	local prev = 0
	function mod:BreakSpirit(args)
		self:Nameplate(args.spellId, 9.5, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:HorrifyingShout(args)
		-- cast once at 50%
		self:Message(args.spellId, "red", CL.percent:format(50, CL.casting:format(args.spellName)))
		if args.time - prev > 2 then
			prev = args.time
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:VoidboundHonorGuardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Voidbound Shieldbearer

function mod:VoidboundShieldbearerEngaged(guid)
	self:Nameplate(298630, 3.5, guid) -- Shockwave
end

do
	local prev = 0
	function mod:Shockwave(args)
		self:Nameplate(args.spellId, 9.7, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:VoidboundShieldbearerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Naros

do
	local timer

	function mod:NarosEngaged(guid)
		self:CDBar(306770, 3.3) -- Forge Breath
		self:Nameplate(306770, 3.3, guid) -- Forge Breath
		self:CDBar(319304, 5.9) -- Shadow Brand
		self:Nameplate(319304, 5.9, guid) -- Shadow Brand
		timer = self:ScheduleTimer("NarosDeath", 20, nil, guid)
	end

	function mod:ForgeBreath(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("NarosDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:ForgeBreathInterrupt(args)
		self:Nameplate(306770, 10.1, args.destGUID)
	end

	function mod:ForgeBreathSuccess(args)
		self:Nameplate(args.spellId, 10.1, args.sourceGUID)
	end

	function mod:ShadowBrand(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		timer = self:ScheduleTimer("NarosDeath", 30, nil, args.sourceGUID)
	end

	function mod:ShadowBrandAppliedNaros(args)
		if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end

	function mod:NarosDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(306770) -- Forge Breath
		self:StopBar(319304) -- Shadow Brand
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Barkeep Morag

do
	local timer

	function mod:BarkeepMoragEngaged(guid)
		self:CDBar(308346, 5.8) -- Barrel Aged
		self:Nameplate(308346, 5.8, guid) -- Barrel Aged
		timer = self:ScheduleTimer("BarkeepMoragDeath", 20, nil, guid)
	end

	function mod:BarrelAged(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("BarkeepMoragDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:BarrelAgedSuccess(args)
		self:CDBar(args.spellId, 5.5)
		self:Nameplate(args.spellId, 5.5, args.sourceGUID)
	end

	function mod:BarkeepMoragDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(308346) -- Barrel Aged
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Decimator Shiq'voth

do
	local timer

	function mod:DecimatorShiqvothEngaged(guid)
		self:CDBar(300351, 2.8) -- Surging Fist
		self:Nameplate(300351, 2.8, guid) -- Surging Fist
		self:CDBar(300388, 5.4) -- Decimator
		self:Nameplate(300388, 5.4, guid) -- Decimator
		timer = self:ScheduleTimer("DecimatorShiqvothDeath", 20, nil, guid)
	end

	function mod:SurgingFist(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 9.7)
		self:Nameplate(args.spellId, 9.7, args.sourceGUID)
		timer = self:ScheduleTimer("DecimatorShiqvothDeath", 20, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:Decimator(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 9.7)
		self:Nameplate(args.spellId, 9.7, args.sourceGUID)
		timer = self:ScheduleTimer("DecimatorShiqvothDeath", 20, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end

	function mod:DecimatorShiqvothDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(300388) -- Decimator
		self:StopBar(300351) -- Surging Fist
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Voidbound Berserker

do
	local prev = 0
	function mod:ShadowBrandApplied(args)
		if (self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId)) and args.time - prev > 2 then
			prev = args.time
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

-- Bwemba

do
	local timer

	function mod:BwembaEngaged(guid)
		self:CDBar(11641, 2.0) -- Hex
		self:Nameplate(11641, 2.0, guid) -- Hex
		timer = self:ScheduleTimer("BwembaDeath", 20, nil, guid)
	end

	function mod:Hex(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 10.9)
		self:Nameplate(args.spellId, 10.9, args.sourceGUID)
		timer = self:ScheduleTimer("BwembaDeath", 30, nil, args.sourceGUID)
	end

	function mod:HexApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
			self:TargetMessage(args.spellId, "orange", args.destName)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end

	function mod:BwembaDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(11641) -- Hex
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Greater Void Elemental

function mod:GreaterVoidElementalEngaged(guid)
	self:Nameplate(297315, 2.0, guid) -- Void Buffet
end

function mod:VoidBuffet(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidBuffetInterrupt(args)
	self:Nameplate(297315, 6.1, args.destGUID)
end

function mod:VoidBuffetSuccess(args)
	self:Nameplate(args.spellId, 6.1, args.sourceGUID)
end

function mod:GreaterVoidElementalDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Faceless Willbreaker

function mod:FacelessWillbreakerEngaged(guid)
	-- Dark Smash not cast until ~75%, but the initial CD is high enough to start a timer here
	self:Nameplate(296718, 3.4, guid) -- Dark Smash
end

do
	local prev = 0
	function mod:DarkSmash(args)
		self:Nameplate(args.spellId, 7.2, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:FacelessWillbreakerDeath(args)
	self:ClearNameplate(args.destGUID)
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

-- Annihilator Lak'hal

do
	local timer

	function mod:AnnihilatorLakhalEngaged(guid)
		self:CDBar(299110, 1.0) -- Orb of Annihilation
		self:Nameplate(299110, 1.0, guid) -- Orb of Annihilation
		self:CDBar(299055, 4.3) -- Dark Force
		self:Nameplate(299055, 4.3, guid) -- Dark Force
		timer = self:ScheduleTimer("AnnihilatorLakhalDeath", 20, nil, guid)
	end

	function mod:OrbOfAnnihilation(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 4.0)
		self:Nameplate(args.spellId, 4.0, args.sourceGUID)
		timer = self:ScheduleTimer("AnnihilatorLakhalDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	do
		local function printTarget(self, name, guid)
			self:TargetMessage(299055, "orange", name)
			if self:Me(guid) and not self:Solo() then
				self:Say(299055, nil, nil, "Dark Force")
			end
			self:PlaySound(299055, "alarm", nil, name)
		end

		function mod:DarkForce(args)
			if timer then
				self:CancelTimer(timer)
			end
			self:CDBar(args.spellId, 12.1)
			self:Nameplate(args.spellId, 12.1, args.sourceGUID)
			self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
			timer = self:ScheduleTimer("AnnihilatorLakhalDeath", 30, nil, args.sourceGUID)
		end
	end

	function mod:AnnihilatorLakhalDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(299110) -- Orb of Annihilation
		self:StopBar(299055) -- Dark Force
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- K'thir Dominator

function mod:KthirDominatorEngaged(guid)
	self:Nameplate(298033, 4.6, guid) -- Touch of the Abyss
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

function mod:KthirDominatorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- K'thir Mindcarver

do
	local prev = 0
	function mod:UNIT_POWER_FREQUENT(_, unit)
		local guid = self:UnitGUID(unit)
		local mobId = self:MobId(guid)
		if mobId == 154524 or mobId == 157609 then -- K'thir Mindcarver (same mob with different ids)
			-- Gains 12 energy from every melee, so this must be a multiple of 12
			local t = GetTime()
			if UnitPower(unit) == 84 and t-prev > 1.5 then
				prev = t
				self:Message(300530, "orange", CL.soon:format(self:SpellName(300530))) -- Mind Carver
				self:PlaySound(300530, "info") -- Mind Carver
			end
		end
	end
end

-- Coagulated Horror

do
	local timer

	function mod:CoagulatedHorrorEngaged(guid)
		self:CDBar(303589, 2.9) -- Sanguine Residue
		self:Nameplate(303589, 2.9, guid) -- Sanguine Residue
		self:CDBar(305875, 7.1) -- Visceral Fluid
		self:Nameplate(305875, 7.1, guid) -- Visceral Fluid
		timer = self:ScheduleTimer("CoagulatedHorrorDeath", 20, nil, guid)
	end

	function mod:SanguineResidue(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 9.2)
		self:Nameplate(args.spellId, 9.2, args.sourceGUID)
		timer = self:ScheduleTimer("CoagulatedHorrorDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:VisceralFluid(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		timer = self:ScheduleTimer("CoagulatedHorrorDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:CoagulatedHorrorDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(305875) -- Visceral Fluid
		self:StopBar(303589) -- Sanguine Residue
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Voidcrazed Hulk

do
	local timer

	function mod:VoidcrazedHulkEngaged(guid)
		self:CDBar(306001, 6.2) -- Explosive Leap
		self:Nameplate(306001, 6.2, guid) -- Explosive Leap
		self:CDBar(306199, 9.7) -- Howling in Pain
		self:Nameplate(306199, 9.7, guid) -- Howling in Pain
		timer = self:ScheduleTimer("VoidcrazedHulkDeath", 20, nil, guid)
	end

	function mod:HowlingInPain(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		timer = self:ScheduleTimer("VoidcrazedHulkDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:ExplosiveLeap(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		timer = self:ScheduleTimer("VoidcrazedHulkDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:VoidcrazedHulkDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(306199) -- Howling in Pain
		self:StopBar(306001) -- Explosive Leap
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Misha

do
	local timer

	function mod:MishaEngaged(guid)
		self:CDBar(304165, 4.1) -- Desperate Retching
		self:Nameplate(304165, 4.1, guid) -- Desperate Retching
		self:CDBar(304101, 8.2) -- Maddening Roar
		self:Nameplate(304101, 8.2, guid) -- Maddening Roar
		timer = self:ScheduleTimer("MishaDeath", 20, nil, guid)
	end

	function mod:DesperateRetching(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 16.6)
		self:Nameplate(args.spellId, 16.6, args.sourceGUID)
		timer = self:ScheduleTimer("MishaDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:DesperateRetchingApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end

	function mod:MaddeningRoar(args)
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 19.4)
		self:Nameplate(args.spellId, 19.4, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:MishaDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(304165) -- Desperate Retching
		self:StopBar(304101) -- Maddening Roar
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Aqir Scarab

do
	local prev = 0
	function mod:RupturedCarapace(args)
		-- cast at low HP
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Aqir Bonecrusher

function mod:AqirBonecrusherEngaged(guid)
	self:Nameplate(298502, 4.7, guid) -- Toxic Breath
end

function mod:ToxicBreath(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 7.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:AqiriMindToxinApplied(args)
	local amount = args.amount or 1
	if amount >= 3 and (self:Me(args.destGUID) or self:Dispeller("poison", nil, args.spellId)) then
		self:StackMessage(args.spellId, "yellow", args.destName, amount, 3)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:AqirBonecrusherDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Aqir Mindhunter

function mod:AqirMindhunterEngaged(guid)
	self:Nameplate(298502, 1.0, guid) -- Toxic Breath
	self:Nameplate(304169, 5.7, guid) -- Toxic Volley
end

function mod:ToxicVolley(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 7.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:AqirMindhunterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Aqir Venomweaver

function mod:AqirVenomweaverEngaged(guid)
	self:Nameplate(312584, 3.3, guid) -- Concentrated Venom
end

function mod:ConcentratedVenom(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:VenomBolt(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	-- no cooldown
	self:PlaySound(args.spellId, "alert")
end

function mod:AqirVenomweaverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Gamon

do
	local timer

	function mod:GamonEngaged(guid)
		self:CDBar(314720, 2.0) -- Whirlwind
		self:Nameplate(314720, 2.0, guid) -- Whirlwind
		self:CDBar(314723, 5.5) -- War Stomp
		self:Nameplate(314723, 5.5, guid) -- War Stomp
		timer = self:ScheduleTimer("GamonDeath", 20, nil, guid)
	end

	function mod:Whirlwind(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 7.2)
		self:Nameplate(args.spellId, 7.2, args.sourceGUID)
		timer = self:ScheduleTimer("GamonDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:WarStomp(args) -- not in CLEU, so can't use args.spellId
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(314723, "yellow")
		self:CDBar(314723, 15.7)
		if args.sourceGUID then -- remove check if this is added to CLEU
			self:Nameplate(314723, 15.7, args.sourceGUID)
			timer = self:ScheduleTimer("GamonDeath", 30, nil, args.sourceGUID)
		end
		self:PlaySound(314723, "info")
	end

	function mod:GamonDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(314720) -- Whirlwind
		self:StopBar(314723) -- War Stomp
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end
