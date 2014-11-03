
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ancient Protectors", 1008, 1207)
if not mod then return end
mod:RegisterEnableMob(83894, 83892, 83893) -- Dulhu, Life Warden Gola, Earthshaper Telu

--------------------------------------------------------------------------------
-- Locals
--

local deathCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		168082, -- Revitalizing Waters
		168105, -- Rapid Tides
		168041, -- Briarskin
		167977, -- Bramble Patch
		168383, -- Slash
		168520, -- Shaper's Fortitude
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "RevitalizingWaters", 168082)
	self:Log("SPELL_CAST_START", "RapidTides", 168105)

	self:Log("SPELL_CAST_START", "Briarskin", 168041)
	self:Log("SPELL_AURA_APPLIED", "BramblePatch", 167977)

	self:Log("SPELL_CAST_START", "Slash", 168383)

	self:Log("SPELL_AURA_APPLIED", "ShapersFortitude", 168520)

	self:Death("Deaths", 83894, 83892, 83893) -- Dulhu, Life Warden Gola, Earthshaper Telu
end

function mod:OnEngage()
	deathCount = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Life Warden Gola
function mod:RevitalizingWaters(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

function mod:RapidTides(args)
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(args.spellName))
end

-- Earthshaper Telu
function mod:Briarskin(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
end

function mod:BramblePatch(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", nil, CL.underyou:format(args.spellName))
	end
end

-- Dulhu
function mod:Slash(args)
	self:Message(args.spellId, "Attention")
end

-- General
function mod:ShapersFortitude(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:Bar(args.spellId, 8)
end

function mod:Deaths(args)
	deathCount = deathCount + 1
	if deathCount > 2 then
		self:Win()
	end
end

