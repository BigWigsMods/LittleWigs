
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Siege of Boralus Trash", 1822)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	134139 -- Shrine Templar
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.templar = "Shrine Templar"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Shrine Templar
		276268, -- Heaving Blow
		267977, -- Tidal Surge
	}, {
		[276268] = L.templar,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	
	self:Log("SPELL_CAST_START", "HeavingBlow", 276268)
	self:Log("SPELL_CAST_START", "TidalSurge", 267977)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HeavingBlow(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:TidalSurge(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
