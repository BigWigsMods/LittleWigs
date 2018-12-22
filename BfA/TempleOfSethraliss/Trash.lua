
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
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dustDevil = "Charged Dust Devil"
	L.marksman = "Sandswept Marksman"
	L.fang = "Shrouded Fang"
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
	}, {
		[265968] = L.dustDevil,
		[264574] = L.marksman,
		[258908] = L.fang,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HealingSurge", 265968)
	self:Log("SPELL_CAST_START", "PowerShot", 264574)
	self:Log("SPELL_CAST_START", "BladeFlurry", 258908)
	self:Log("SPELL_AURA_APPLIED", "BladeFlurryApplied", 258908)
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
end