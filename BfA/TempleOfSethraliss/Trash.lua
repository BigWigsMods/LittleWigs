
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
	}, {
		[265968] = L.dustDevil,
		[264574] = L.marksman,
		[258908] = L.fang,
		[272659] = L.rider,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HealingSurge", 265968)
	self:Log("SPELL_CAST_START", "PowerShot", 264574)
	self:Log("SPELL_CAST_START", "BladeFlurry", 258908)
	self:Log("SPELL_AURA_APPLIED", "BladeFlurryApplied", 258908)
	self:Log("SPELL_AURA_APPLIED", "ElectrifiedScalesApplied", 272659)
	self:Log("SPELL_CAST_START", "NoxiousBreath", 272657)
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

function mod:ElectrifiedScalesApplied(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:NoxiousBreath(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end
