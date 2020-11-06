
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Temple of Sethraliss Trash", 1877)
if not mod then return end
mod.displayName = CL.trash
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

local L = mod:GetLocale()
if L then
	L.dust_devil = "Charged Dust Devil"
	L.marksman = "Sandswept Marksman"
	L.fang = "Shrouded Fang"
	L.rider = "Scaled Krolusk Rider"
	L.tender = "Faithless Tender"
	L.incubator = "Crazed Incubator"
	L.nimbus = "Agitated Nimbus"
	L.doctor = "Plague Doctor"
end

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
-- Event Handlers
--

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
