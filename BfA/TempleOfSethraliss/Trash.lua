--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Temple of Sethraliss Trash", 1877)
if not mod then return end
mod:SetTrashModule(true)
mod:RegisterEnableMob(
	134990, -- Charged Dust Devil
	134600, -- Sandswept Marksman
	134602, -- Shrouded Fang
	134629, -- Scaled Krolusk Rider
	134364, -- Faithless Tender
	139425, -- Crazed Incubator
	136076, -- Agitated Nimbus
	139949  -- Plague Doctor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	dust_devil = "Charged Dust Devil",
	marksman = "Sandswept Marksman",
	fang = "Shrouded Fang",
	rider = "Scaled Krolusk Rider",
	tender = "Faithless Tender",
	incubator = "Crazed Incubator",
	nimbus = "Agitated Nimbus",
	doctor = "Plague Doctor",
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Charged Dust Devil
		265968, -- Healing Surge
		-- Sandswept Marksman
		264574, -- Power Shot
		273563, -- Neurotoxin
		-- Shrouded Fang
		258908, -- Blade Flurry
		-- Scaled Krolusk Rider
		272659, -- Electrified Scales
		272657, -- Noxious Breath
		-- Faithless Tender
		272700, -- Greater Healing Potion
		267237, -- Drain
		-- Crazed Incubator
		273995, -- Pyrrhic Blast
		-- Agitated Nimbus
		265912, -- Accumulate Charge
		-- Plague Doctor
		268008, -- Snake Charm
	}, {
		[265968] = L.dust_devil,
		[264574] = L.marksman,
		[258908] = L.fang,
		[272659] = L.rider,
		[272700] = L.tender,
		[273995] = L.incubator,
		[265912] = L.nimbus,
		[268008] = L.doctor,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_CAST_START", "HealingSurge", 265968)
	self:Log("SPELL_CAST_START", "PowerShot", 264574)
	self:Log("SPELL_AURA_APPLIED", "NeurotoxinApplied", 273563)
	self:Log("SPELL_CAST_START", "BladeFlurry", 258908)
	self:Log("SPELL_AURA_APPLIED", "BladeFlurryApplied", 258908)
	self:Log("SPELL_CAST_START", "ElectrifiedScales", 272659)
	self:Log("SPELL_AURA_APPLIED", "ElectrifiedScalesApplied", 272659)
	self:Log("SPELL_CAST_START", "NoxiousBreath", 272657)
	self:Log("SPELL_CAST_START", "GreaterHealingPotion", 272700)
	self:Log("SPELL_CAST_SUCCESS", "Drain", 267237)
	self:Log("SPELL_CAST_START", "PyrrhicBlast", 273995)
	self:Log("SPELL_CAST_START", "AccumulateCharge", 265912)
	self:Log("SPELL_CAST_START", "SnakeCharm", 268008)
	self:Log("SPELL_AURA_APPLIED", "SnakeCharmApplied", 268008)
end

--------------------------------------------------------------------------------
-- Midnight Auras
--

if mod:Retail() then -- Midnight+
	mod:SetAuraData({
		{1291399, header = 134629, duration = 6, dispel = "bleed", note = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1291399))}, -- Serrated Charge (Sand-Sworn Rider)
		{272655, duration = 4, mechanic = "disoriented", note = CL.debuffFailureMoveFromCastNote:format(mod:SpellName(272655))}, -- Scouring Sand (Sand-Sworn Rider)
		{1291468, header = 134991, duration = 10, soundOnAppliedDose = "none", note = CL.debuffTankAfterCastNote:format(mod:SpellName(1291468))}, -- Sunder Slam (Sandfury Stonefist)
		{1308113, header = 134600, duration = 9, note = CL.debuffTargetedNote:format(mod:SpellName(1308113))}, -- Arrow Barrage (Sandswept Hunter)
		{1308100, header = 134602, duration = 5, dispel = "poison", mechanic = "stunned", note = CL.debuffFailureInterruptNote:format(mod:SpellName(1308100))}, -- Poisoned Cheap Shot (Shrouded Fang)
		{1308148, header = 135562, duration = 10, dispel = "poison", note = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1308148))}, -- Cytotoxin (Poisonous Viper)
		{1293133, header = 135846, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Lingering Storm (Lightning Serpent)
		{1293307, header = 134364, duration = 5, dispel = "curse", mechanic = "disoriented", note = CL.debuffFailureInterruptNote:format(mod:SpellName(1293307))}, -- Addle Mind (Faithless Subjugator)
		{1296052, header = 134599, duration = 20, dispel = "magic", note = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1296052))}, -- Imbued Conduction (Imbued Stormcaller)
		{1303596, header = 240681, soundOnApplied = "info", note = CL.debuffWalkIntoObjectNote:format(mod:SpellName(269443))}, -- Siphon Energy (Eye of Sethraliss)
		{1308546, header = 135007, duration = 10, note = CL.debuffTankAfterCastNote:format(mod:SpellName(1308546))}, -- Venomous Slash (Orb Watcher)
		{1303486, duration = 10, note = CL.debuffGroupAfterCastNote:format(mod:SpellName(1303486))}, -- Caustic Stomp (Orb Watcher)
		{1300704, header = 268317, note = CL.debuffTargetedNote:format(mod:SpellName(1300702))}, -- Fixate (Faithless Tormentor)
		{1311981, header = 136250, duration = 5, note = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1311980))}, -- Latent Hex (Twisted Hexxer)
		{1300684, mechanic = "polymorphed", note = CL.debuffUnderYouNote}, -- Hex Muck (Twisted Hexxer)
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
		}
	end

	function mod:OnBossEnable()
		self:RegisterEvent("GOSSIP_SHOW")
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetGossipID(48126) then -- 48126:We will restore you!
		local avatarModule = BigWigs:GetBossModule("Avatar of Sethraliss", true)
		if avatarModule then
			avatarModule:Enable()
			avatarModule:GOSSIP_SHOW()
		end
	end
end

function mod:HealingSurge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:PowerShot(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:NeurotoxinApplied(args)
	if self:Dispeller("poison") or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:BladeFlurry(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:BladeFlurryApplied(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:TargetBar(args.spellId, 8, args.destName)
end

do
	local prev = 0
	function mod:ElectrifiedScales(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:ElectrifiedScalesApplied(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:NoxiousBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:GreaterHealingPotion(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:Drain(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:PyrrhicBlast(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:AccumulateCharge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SnakeCharm(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SnakeCharmApplied(args)
	if self:Dispeller("magic") or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end
