
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Horrific Vision of Orgrimmar Trash", 2212)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	153097, -- Voidbound Shaman
	152704, -- Crawling Corruption
	156406, -- Voidbound Honor Guard
	156146, -- Voidbound Shieldbearer
	153943, -- Decimator Shiq'voth
	152699, -- Voidbound Berserker
	153130, -- Greater Void Elemental
	153942, -- Annihilator Lak'hal
	153401, -- K'thir Dominator
	154524 -- K'thir Mindcarver
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
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"altpower",
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
	}
end

function mod:OnBossEnable()
	self:OpenAltPower("altpower", 318335, "ZA") -- Sanity

	self:Log("SPELL_CAST_SUCCESS", "MindProtected", 291295)	-- Cast when the vision ends
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

	self:Death("DecimatorShiqvothDeath", 153943)
	self:Death("AnnihilatorLakhalDeath", 153942)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MindProtected(args)
	self:CloseAltPower("altpower")
end

function mod:EndlessHungerTotem(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:CreepyCrawler(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message2(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:HorrifyingShout(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:Shockwave(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Decimator(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 9.7)
end

function mod:SurgingFist(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 9.7)
end

function mod:DecimatorShiqvothDeath(args)
	self:StopBar(300388) -- Decimator
	self:StopBar(300351) -- Surging Fist
end

function mod:ShadowBrandApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alert")
	elseif self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage2(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:VoidBuffet(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(299055, "orange", name)
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
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:UNIT_POWER_FREQUENT(_, unit)
	local guid = UnitGUID(unit)
	if self:MobId(guid) == 154524 then -- K'thir Mindcarver
		-- Gains 12 energy from every melee, so this must be a multiple of 12
		if UnitPower(unit) == 84 then
			self:Message2(300530, "orange", CL.soon:format(self:SpellName(300530))) -- Mind Carver
			self:PlaySound(300530, "info") -- Mind Carver
		end
	end
end
