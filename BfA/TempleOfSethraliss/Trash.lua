
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Temple of Sethraliss Trash", 1822)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	134990, -- Charged Dust Devil
	134600, -- Sandswept Marksman
	134602, -- Shrouded Fang
	134629, -- Scaled Krolust Rider
	134390, -- Sand-crusted Striker
	134364, -- Faithless Tender
	139425, -- Crazed Incubator
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dustDevil = "Charged Dust Devil"
	L.marksman = "Sandswept Marksman"
	L.fang = "Shrouded Fang"
	L.rider = "Scaled Krolusk Rider"
	L.striker = "Sand-crusted Striker"
	L.tender = "Faithless Tender"
	L.incubator = "Crazed Incubator"
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
		-- Shrouded Fang
		258908, -- Blade Flurry
		-- Scaled Krolusk Rider
		272659, -- Electrified Scales
		272657, -- Noxious Breath
		-- Sand-crusted Striker
		268705, -- Dust Cloud
		-- Faithless Tender
		272700, -- Greater Healing Potion
		-- Crazed Incubator
		273995, -- Pyrrhic Blast
	}, {
		[265968] = L.dustDevil,
		[264574] = L.marksman,
		[258908] = L.fang,
		[272659] = L.rider,
		[268705] = L.striker,
		[272700] = L.tender,
		[273995] = L.incubator,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HealingSurge", 265968)
	self:Log("SPELL_CAST_START", "PowerShot", 264574)
	self:Log("SPELL_CAST_START", "BladeFlurry", 258908)
	self:Log("SPELL_AURA_APPLIED", "BladeFlurryApplied", 258908)
	self:Log("SPELL_CAST_START", "ElectrifiedScales", 272659)
	self:Log("SPELL_AURA_APPLIED", "ElectrifiedScalesApplied", 272659)
	self:Log("SPELL_CAST_START", "NoxiousBreath", 272657)
	self:Log("SPELL_CAST_START", "DustCloud", 268705)
	self:Log("SPELL_CAST_START", "GreaterHealingPotion", 272700)
	self:Log("SPELL_CAST_START", "PyrrhicBlast", 273995)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HealingSurge(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:PowerShot(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:BladeFlurry(args)
	self:Message2(args.spellId, "orange", L.casting:format(args.spellId))
	self:PlaySound(args.spellId, "alert")
end

function mod:BladeFlurryApplied(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 8)
end

function mod:ElectrifiedScales(args)
	self:CastBar(args.spellId, 2)
end

function mod:ElectrifiedScalesApplied(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:NoxiousBreath(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:DustCloud(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:GreaterHealingPotion(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:PyrrhicBlast(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
