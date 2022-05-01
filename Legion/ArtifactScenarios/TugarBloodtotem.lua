
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tugar Bloodtotem", 1702) -- Feltotem's Fall
if not mod then return end
mod:RegisterEnableMob(117230, 117484) -- Tugar Bloodtotem, Jormog the Behemoth
mod.otherMenu = 1716 -- Broken Shore Mage Tower

--------------------------------------------------------------------------------
-- Locals
--

local screamTimers = {8.4, 46.1, 19.4, 37.7, 15.8} -- This is not correct
local screamCount = 1
local burstCount = 1
local deathCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.tugar = "Tugar Bloodtotem"
	L.jormog = "Jormog the Behemoth"

	L.remaining = "Scales Remaining"

	L.submerge = "Submerge"
	L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."
	L.submerge_icon = 242379

	L.charge = 100
	L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."
	L.charge_icon = 100

	L.rupture = "{243382} (X)"
	L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."
	L.rupture_icon = 243382

	L.totem_warning = "The totem hit you!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Tugar ]]--
		242733, -- Fel Burst
		243224, -- Fel Surge Totem
		"rupture", -- Fel Rupture

		--[[ Jormog ]]--
		241687, -- Sonic Scream
		{238471, "INFOBOX"}, -- Fel Hardened Scales
		"submerge",
		"charge",
	}, {
		[242733] = L.tugar,
		[241687] = L.jormog,
	}
end

function mod:OnRegister()
	self.displayName = L.tugar
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")

	self:Log("SPELL_CAST_START", "FelBurst", 242733)
	self:Log("SPELL_CAST_START", "SonicScream", 241687)
	self:Log("SPELL_AURA_REMOVED_DOSE", "ScaleRemoved", 238471)
	self:Log("SPELL_AURA_REMOVED", "ScaleRemoved", 238471)
	self:Log("SPELL_CAST_START", "FitSurgeStart", 242496)
	self:Log("SPELL_AURA_APPLIED", "FitSurgeHitYou", 242496)

	self:Death("Deaths", 117230, 117484)
end

function mod:OnEngage()
	screamCount = 1
	burstCount = 1
	deathCount = 0

	self:OpenInfo(238471, L.remaining)
	self:SetInfo(238471, 1, 9)
	self:CDBar(242733, 3.5) -- Fel Burst
	self:CDBar(241687, screamTimers[screamCount]) -- Sonic Scream
	self:CDBar(243224, 60.7) -- Fel Surge Totem
	self:CDBar("submerge", 21.8, L.submerge, L.submerge_icon)
	self:CDBar("rupture", 7, "X", L.rupture_icon)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FelBurst(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
	burstCount = burstCount + 1
	if burstCount == 4 then burstCount = 1 end
	self:CDBar(args.spellId, burstCount == 2 and 23 or 18)
end

function mod:SonicScream(args)
	self:MessageOld(args.spellId, "red", "alert", CL.casting:format(args.spellName))
	screamCount = screamCount + 1
	--self:CDBar(args.spellId, screamTimers[screamCount]) -- innacurate
end

function mod:ScaleRemoved(args)
	self:SetInfo(args.spellId, 1, args.amount or 0)
end

function mod:FitSurgeStart(args)
	self:MessageOld(243224, "red", "long")
	self:CDBar(243224, 25.5)
end

function mod:FitSurgeHitYou(args)
	if self:Me(args.destGUID) then
		self:MessageOld(243224, "blue", "long", L.totem_warning)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE()
	self:MessageOld("charge", "blue", "alarm", CL.incoming:format(self:SpellName(100)), L.charge_icon)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 34098 then -- ClearAllDebuffs
		self:MessageOld("submerge", "orange", "alarm", L.submerge, L.submerge_icon)
		self:CDBar("submerge", 60.7, L.submerge, L.submerge_icon)
	elseif spellId == 241664 then
		self:MessageOld("rupture", "yellow", "alarm", CL.underyou:format("X"), L.rupture_icon)
		self:CDBar("rupture", 11, "X", L.rupture_icon)
	end
end

function mod:Deaths()
	deathCount = deathCount + 1
	if deathCount > 1 then
		self:Win()
	end
end
