
--------------------------------------------------------------------------------
-- TODO List:
-- - Confirm 198931 (Healing Light), 198934 (Rune of Healing) spell ids

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Valor Trash", 1041)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	97081, -- King Bjorn
	95843, -- King Haldor
	97083, -- King Ranulf
	97084, -- King Tor
	97202, -- Olmyr the Enlightened
	95834, -- Valarjar Mystic
	95842, -- Valarjar Thundercaller
	97197, -- Valarjar Purifier
	101637 -- Valarjar Aspirant
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.fourkings = "The Four Kings"
	L.olmyr = "Olmyr the Enlightened"
	L.purifier = "Valarjar Purifier"
	L.thundercaller = "Valarjar Thundercaller"
	L.mystic = "Valarjar Mystic"
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
		{215430, "SAY", "FLASH", "PROXIMITY"}, -- Thunderstrike
		198931, -- Healing Light
		198934, -- Rune of Healing
	}, {
		[192563] = L.purifier,
		[199726] = L.fourkings,
		[192158] = L.olmyr,
		[191508] = L.aspirant,
		[215430] = L.thundercaller,
		[198931] = L.mystic,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	--[CLEU] SPELL_CAST_START#Creature-0-2084-1477-6795-99891-00003FDF54#Storm Drake##nil#198892#Crackling Storm#nil#nil

	-- Cleansing Flames, Unruly Yell, Sanctify, Blast of Light, Healing Light, Rune of Healing
	self:Log("SPELL_CAST_START", "Casts", 192563, 199726, 192158, 191508, 198931, 198934)

	self:Log("SPELL_AURA_APPLIED", "Thunderstrike", 215430)
	self:Log("SPELL_AURA_REMOVED", "ThunderstrikeRemoved", 215430)

	--self:Death("Disable", 97197) -- Valarjar Purifier
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Casts(args)
	self:Message(args.spellId, "Important", "Alert")
end

function mod:Thunderstrike(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
	self:TargetBar(args.spellId, 3, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
		self:OpenProximity(args.spellId, 8)
	end
end

function mod:ThunderstrikeRemoved(args)
	if self:Me(args.destGUID) then
		self:CloseProximity(args.spellId)
	end
end
