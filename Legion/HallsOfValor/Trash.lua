
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
	101637, -- Valarjar Aspirant
	97068,  -- Storm Drake
	99891,  -- Storm Drake
	96640,  -- Valarjar Marksman
	96934,  -- Valarjar Trapper
	96574   -- Stormforged Sentinel
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
	L.drake = "Storm Drake"
	L.marksman = "Valarjar Marksman"
	L.trapper = "Valarjar Trapper"
	L.sentinel = "Stormforged Sentinel"
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
		198931, -- Healing Light (replaced by Holy Radiance in mythic difficulty)
		198934, -- Rune of Healing
		215433, -- Holy Radiance
		198888, -- Lightning Breath
		199210, -- Penetrating Shot
		199341, -- Bear Trap
		210875, -- Charged Pulse
	}, {
		[192563] = L.purifier,
		[199726] = L.fourkings,
		[192158] = L.olmyr,
		[191508] = L.aspirant,
		[215430] = L.thundercaller,
		[198931] = L.mystic,
		[198888] = L.drake,
		[199210] = L.marksman,
		[199341] = L.trapper,
		[210875] = L.sentinel,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	--[CLEU] SPELL_CAST_START#Creature-0-2084-1477-6795-99891-00003FDF54#Storm Drake##nil#198892#Crackling Storm#nil#nil

	-- Cleansing Flames, Unruly Yell, Sanctify, Blast of Light, Healing Light, Rune of Healing, Holy Radiance, Lightning Breath, Penetrating Shot, Bear Trap, Charged Pulse
	self:Log("SPELL_CAST_START", "Casts", 192563, 199726, 192158, 191508, 198931, 198934, 215433, 198888, 199210, 199341, 210875)

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
