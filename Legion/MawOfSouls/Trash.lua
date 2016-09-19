
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maw of Souls Trash", 1042)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	97097, -- Helarjar Champion
	97182, -- Night Watch Mariner
	97365, -- Seacursed Mistmender
	99033, -- Helarjar Mistcaller
	99307 -- Skjal
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.champion = "Helarjar Champion"
	L.mariner = "Night Watch Mariner"
	L.mistmender = "Seacursed Mistmender"
	L.mistcaller = "Helarjar Mistcaller"
	L.skjal = "Skjal"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198405, -- Bone Chilling Scream
		192019, -- Lantern of Darkness
		199514, -- Torrent of Souls
		199589, -- Whirlpool of Souls
		216197, -- Surging Waters
		195293, -- Debilitating Shout
	}, {
		[198405] = L.champion,
		[192019] = L.mariner,
		[199514] = L.mistmender,
		[199589] = L.mistcaller,
		[195293] = L.skjal,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "Casts", 198405, 199514, 199589, 216197, 195293)
	self:Log("SPELL_CAST_START", "BoneChillingScream", 198405)
	self:Log("SPELL_CAST_START", "LanternOfDarkness", 192019)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Casts(args)
	self:Message(args.spellId, "Urgent", "Alert")
end

function mod:BoneChillingScream(args)
	self:Message(args.spellId, "Important", "Warning")
end

function mod:LanternOfDarkness(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 7, CL.cast:format(args.spellName))
end
