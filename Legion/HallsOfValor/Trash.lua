
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Valor Trash", 1041)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	97197, -- Valarjar Purifier
	97081, -- King Bjorn
	95843, -- King Haldor
	97083, -- King Ranulf
	97084, -- King Tor
	97202, -- Olmyr the Enlightened
	101637 -- Valarjar Aspirant
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.purifier = "Valarjar Purifier"
	L.fourkings = "The Four Kings"
	L.olmyr = "Olmyr the Enlightened"
	L.aspirant = "Valarjar Aspirant"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		192563, -- Cleansing Flames
		199726, -- Unruly Yell
		192158, -- Sanctify
		191508, -- Blast of Light
	}, {
		[192563] = L.purifier,
		[199726] = L.fourkings,
		[192158] = L.olmyr,
		[191508] = L.aspirant,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	--[CLEU] SPELL_CAST_START#Creature-0-2084-1477-6795-99891-00003FDF54#Storm Drake##nil#198892#Crackling Storm#nil#nil
	self:Log("SPELL_CAST_START", "Casts", 192563, 199726, 192158, 191508) -- Cleansing Flames, Unruly Yell

	--self:Death("Disable", 97197) -- Valarjar Purifier
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Casts(args)
	self:Message(args.spellId, "Important", "Alert")
end
