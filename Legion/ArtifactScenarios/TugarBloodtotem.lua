
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tugar Bloodtotem", 1129)
if not mod then return end
mod:RegisterEnableMob(117230, 117484) -- Tugar Bloodtotem, Jormog the Behemoth
mod.otherMenu = 1021 -- Broken Shore

--------------------------------------------------------------------------------
-- Locals
--

local screamTimers = {8.4, 46.1, 19.4, 37.7, 15.8} -- This is not correct
local screamCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Tugar Bloodtotem"
	L.remaining = "%d Scales Remaining"

	L.submerge = "Submerge"
	L.submerge_desc = "Submerges below the ground, summoning spitter eggs."
	L.submerge_icon = 242379

	L.totem_warning = "The totem hit you!"
end
mod.displayName = L.name

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		237950, -- Earthquake
		242733, -- Fel Burst
		241687, -- Sonic Scream
		243224, -- Fel Surge Totem
		238471, -- Fel Hardened Scales
		"submerge",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_SUCCESS", "Earthquake", 237950)
	self:Log("SPELL_CAST_START", "FelBurst", 242733)
	self:Log("SPELL_CAST_START", "SonicScream", 241687)
	self:Log("SPELL_AURA_REMOVED_DOSE", "ScaleRemoved", 238471)
	self:Log("SPELL_AURA_APPLIED", "FitSurgeHitYou", 242496)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")

	self:Death("Win", 117230)
end

function mod:OnEngage()
	screamCount = 1

	self:CDBar(237950, 20.6) -- Earthquake
	self:CDBar(242733, 3.5) -- Fel Burst
	self:CDBar(241687, screamTimers[screamCount]) -- Sonic Scream
	self:CDBar(243224, 60.7) -- Fel Surge Totem
	self:CDBar("submerge", 21.8, L.submerge, L.submerge_icon) -- Summon Bile Spitter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Earthquake(args)
	self:Message(args.spellId, "Attention", "Info")
	self:CDBar(args.spellId, 60.7)
end

function mod:FelBurst(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 18)
end

function mod:SonicScream(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(args.spellName))
	screamCount = screamCount + 1
	self:CDBar(args.spellId, screamTimers[screamCount])
end

function mod:ScaleRemoved(args)
	self:Message(args.spellId, "Positive", nil, L.remaining:format(args.amount))
end

function mod:FitSurgeHitYou(args)
	if self:Me(args.destGUID) then
		self:Message(243224, "Personal", "Long", L.totem_warning)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 243224 then -- Fel Surge Totem
		self:Message(spellId, "Important", "Long")
		self:CDBar(spellId, 25.5)
	elseif spellId == 34098 then -- ClearAllDebuffs
		-- Submerge
		self:Message("submerge", "Urgent", "Alarm", L.submerge, L.submerge_icon)
		self:CDBar("submerge", 60.7, L.submerge, L.submerge_icon)
	end
end
