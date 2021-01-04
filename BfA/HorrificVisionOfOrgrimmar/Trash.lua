
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Horrific Vision of Orgrimmar Trash", 2212)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	155604, -- Image of Wrathion
	153097, -- Voidbound Shaman
	152704, -- Crawling Corruption
	156406, -- Voidbound Honor Guard
	156146, -- Voidbound Shieldbearer
	153943, -- Decimator Shiq'voth
	152699, -- Voidbound Berserker
	153130, -- Greater Void Elemental
	153942, -- Annihilator Lak'hal
	153401, -- K'thir Dominator
	154524, -- K'thir Mindcarver
	157609, -- K'thir Mindcarver
	156653, -- Coagulated Horror
	156143, -- Voidcrazed Hulk
	155656, -- Misha
	153531, -- Aqir Bonecrusher
	156089, -- Aqir Venomweaver
	153526, -- Aqir Swarmer
	153527 -- Aqir Swarmer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.voidbound_shaman = "Voidbound Shaman"
	L.crawling_corruption = "Crawling Corruption"
	L.voidbound_honor_guard = "Voidbound Honor Guard"
	L.voidbound_shieldbearer = "Voidbound Shieldbearer"
	L.decimator_shiqvoth = "Decimator Shiq'voth"
	L.voidbound_berserker = "Voidbound Berserker"
	L.greater_void_elemental = "Greater Void Elemental"
	L.annihilator_lakhal = "Annihilator Lak'hal"
	L.kthir_dominator = "K'thir Dominator"
	L.kthir_mindcarver = "K'thir Mindcarver"
	L.coagulated_horror = "Coagulated Horror"
	L.voidcrazed_hulk = "Voidcrazed Hulk"
	L.misha = "Misha"
	L.aqir_bonecrusher = "Aqir Bonecrusher"
	L.aqir_venomweaver = "Aqir Venomweaver"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"altpower",
		311996, -- Open Vision
		311390, -- Madness: Entomophobia
		306583, -- Leaden Foot
		-- Voidbound Shaman
		297237, -- Endless Hunger Totem
		-- Crawling Corruption
		296510, -- Creepy Crawler
		-- Voidbound Honor Guard
		305378, -- Horrifying Shout
		-- Voidbound Shieldbearer
		298630, -- Shockwave
		-- Decimator Shiq'voth
		300388, -- Decimator
		300351, -- Surging Fist
		-- Voidbound Berserker
		{297146, "DISPEL"}, -- Shadow Brand
		-- Greater Void Elemental
		297315, -- Void Buffet
		-- Annihilator Lak'hal
		{299055, "SAY"}, -- Dark Force
		-- K'thir Dominator
		298033, -- Touch of the Abyss
		-- K'thir Mindcarver
		300530, -- Mind Carver
		-- Coagulated Horror
		305875, -- Visceral Fluid
		303589, -- Sanguine Residue
		-- Voidcrazed Hulk
		306199, -- Howling in Pain
		306001, -- Explosive Leap
		-- Misha
		{304165, "DISPEL"}, -- Desperate Retching
		304101, -- Maddening Roar
		-- Aqir Bonecrusher
		298502, -- Toxic Breath
		-- Aqir Venomweaver
		305236, -- Venom Bolt
		{298510, "DISPEL"}, -- Aqiri Mind Toxin
	}, {
		["altpower"] = "general",
		[297237] = L.voidbound_shaman,
		[296510] = L.crawling_corruption,
		[305378] = L.voidbound_honor_guard,
		[298630] = L.voidbound_shieldbearer,
		[300388] = L.decimator_shiqvoth,
		[297146] = L.voidbound_berserker,
		[297315] = L.greater_void_elemental,
		[299055] = L.annihilator_lakhal,
		[298033] = L.kthir_dominator,
		[300530] = L.kthir_mindcarver,
		[305875] = L.coagulated_horror,
		[306199] = L.voidcrazed_hulk,
		[304165] = L.misha,
		[298502] = L.aqir_bonecrusher,
	}
end

-- Some mob ids are shared by different visions
function mod:VerifyEnable()
	local _, _, _, _, _, _, _, instanceId = GetInstanceInfo()
	return instanceId == 2212
end

function mod:OnBossEnable()
	self:OpenAltPower("altpower", 318335, "ZA") -- Sanity

	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:Log("SPELL_AURA_APPLIED", "MadnessEntomophobiaApplied", 311390)
	self:Log("SPELL_AURA_APPLIED_DOSE", "MadnessEntomophobiaApplied", 311390)
	self:Log("SPELL_AURA_APPLIED", "LeadenFootApplied", 306583)
	self:Log("SPELL_AURA_APPLIED_DOSE", "LeadenFootApplied", 306583)
	self:Log("SPELL_AURA_REMOVED", "LeadenFootRemoved", 306583)
	self:Log("SPELL_CAST_SUCCESS", "EndlessHungerTotem", 297237)
	self:Log("SPELL_CAST_START", "CreepyCrawler", 296510)
	self:Log("SPELL_CAST_START", "HorrifyingShout", 305378)
	self:Log("SPELL_CAST_START", "Shockwave", 298630)
	self:Log("SPELL_CAST_START", "Decimator", 300388)
	self:Log("SPELL_CAST_START", "SurgingFist", 300351)
	self:Log("SPELL_AURA_APPLIED", "ShadowBrandApplied", 297146)
	self:Log("SPELL_CAST_START", "VoidBuffet", 297315)
	self:Log("SPELL_CAST_START", "DarkForce", 299055)
	self:Log("SPELL_CAST_START", "TouchOfTheAbyss", 298033)
	self:RegisterEvent("UNIT_POWER_FREQUENT")
	self:Log("SPELL_CAST_START", "VisceralFluid", 305875)
	self:Log("SPELL_CAST_START", "SanguneResidue", 303589)
	self:Log("SPELL_CAST_START", "HowlingInPain", 306199)
	self:Log("SPELL_CAST_START", "ExplosiveLeap", 306001)
	self:Log("SPELL_AURA_APPLIED", "DesperateRetchingApplied", 304165)
	self:Log("SPELL_CAST_START", "MaddeningRoar", 304101)
	self:Log("SPELL_CAST_START", "ToxicBreath", 298502)
	self:Log("SPELL_CAST_START", "VenomBolt", 305236)
	self:Log("SPELL_AURA_APPLIED", "AqiriMindToxinApplied", 298510)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AqiriMindToxinApplied", 298510)

	self:Death("DecimatorShiqvothDeath", 153943)
	self:Death("AnnihilatorLakhalDeath", 153942)
	self:Death("CoagulatedHorrorDeath", 156653)
	self:Death("VoidcrazedHulkDeath", 156143)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prevCastGUID
	function mod:UNIT_SPELLCAST_START(_, _, castGUID, spellId)
		if spellId == 311996 and castGUID ~= prevCastGUID then -- Open Vision
			prevCastGUID = castGUID
			self:Message(311996, "cyan")
			self:PlaySound(311996, "long")
			self:Bar(311996, 10) -- Open Vision
		end
	end
end

function mod:MadnessEntomophobiaApplied(args)
	local amount = args.amount or 1
	if self:Me(args.destGUID) and amount >= 3 then
		self:StackMessage(args.spellId, args.destName, amount, "blue")
		self:PlaySound(args.spellId, "info")
	end
end

do
	local showRemovedWarning = false
	function mod:LeadenFootApplied(args)
		local amount = args.amount or 1
		if self:Me(args.destGUID) and amount % 5 == 0 and amount >= 10 then
			showRemovedWarning = true
			self:StackMessage(args.spellId, args.destName, amount, "blue")
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:LeadenFootRemoved(args)
		if self:Me(args.destGUID) and showRemovedWarning then
			showRemovedWarning = false
			self:Message(args.spellId, "blue", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:EndlessHungerTotem(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:CreepyCrawler(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:HorrifyingShout(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:Shockwave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Decimator(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 9.7)
end

function mod:SurgingFist(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 9.7)
end

function mod:DecimatorShiqvothDeath(args)
	self:StopBar(300388) -- Decimator
	self:StopBar(300351) -- Surging Fist
end

function mod:ShadowBrandApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId)then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:VoidBuffet(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(299055, "orange", name)
		self:PlaySound(299055, "alarm", nil, name)
		self:Bar(299055, 12.1)
		if self:Me(guid) then
			self:Say(299055)
		end
	end

	function mod:DarkForce(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:AnnihilatorLakhalDeath(args)
	self:StopBar(299055) -- Dark Force
end

function mod:TouchOfTheAbyss(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

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

function mod:VisceralFluid(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 12.1)
end

function mod:SanguneResidue(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 9.7)
end

function mod:CoagulatedHorrorDeath(args)
	self:StopBar(305875) -- Visceral Fluid
	self:StopBar(303589) -- Sangune Residue
end

function mod:HowlingInPain(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12)
end

function mod:ExplosiveLeap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidcrazedHulkDeath(args)
	self:StopBar(306199) -- Howling in Pain
	self:StopBar(306001) -- Explosive Leap
end

function mod:DesperateRetchingApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:MaddeningRoar(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:ToxicBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:VenomBolt(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:AqiriMindToxinApplied(args)
	local amount = args.amount or 1
	if amount >= 3 then
		if self:Me(args.destGUID) or self:Dispeller("poison", nil, args.spellId) then
			self:StackMessage(args.spellId, args.destName, amount, "red")
			self:PlaySound(args.spellId, "alert", args.destName)
		end
	end
end
