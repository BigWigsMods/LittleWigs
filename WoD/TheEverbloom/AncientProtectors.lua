
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ancient Protectors", 1279, 1207)
if not mod then return end
mod:RegisterEnableMob(83894, 83892, 83893) -- Dulhu, Life Warden Gola, Earthshaper Telu
mod.engageId = 1757
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local golaHasDied = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L[83892] = "|cFF00CCFFGola|r"
	L[83893] = "|cFF00CC00Telu|r"

	L.custom_on_automark = "Auto-Mark Bosses"
	L.custom_on_automark_desc = "Automatically mark Gola with a {rt8} and Telu with a {rt7}, requires promoted or leader."
	L.custom_on_automark_icon = 8
end

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
		"custom_on_automark",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RevitalizingWaters", 168082)
	self:Log("SPELL_AURA_APPLIED", "RapidTides", 168105)

	self:Log("SPELL_CAST_START", "Briarskin", 168041)
	self:Log("SPELL_AURA_APPLIED", "BramblePatch", 167977)

	self:Log("SPELL_CAST_START", "Slash", 168383)

	self:Log("SPELL_AURA_APPLIED", "ShapersFortitude", 168520)

	self:Death("GolasDeath", 83892) -- Life Warden Gola
end

function mod:OnEngage()
	golaHasDied = false
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetOption("custom_on_automark") then
		for i = 1, 3 do
			local unit = ("boss%d"):format(i)
			local id = self:MobId(self:UnitGUID(unit))
			if id == 83892 and not golaHasDied then
				self:CustomIcon(false, unit, 8)
			elseif id == 83893 then
				self:CustomIcon(false, unit, golaHasDied and 8 or 7)
			end
		end
	end
end

-- Life Warden Gola
function mod:RevitalizingWaters(args)
	local raidIcon = CombatLog_String_GetIcon(args.sourceRaidFlags)
	self:MessageOld(args.spellId, "orange", "warning", CL.other:format(raidIcon.. L[83892], CL.casting:format(self:SpellName(31730)))) -- 31730 = "Heal"
end

function mod:RapidTides(args)
	local raidIcon = CombatLog_String_GetIcon(args.destRaidFlags)
	local name = L[self:MobId(args.destGUID)] or args.destName
	self:MessageOld(args.spellId, "red", self:Dispeller("magic", true) and "alarm", CL.other:format(args.spellName, raidIcon..name))
end

-- Earthshaper Telu
function mod:Briarskin(args)
	local raidIcon = CombatLog_String_GetIcon(args.sourceRaidFlags)
	self:MessageOld(args.spellId, "yellow", "alert", CL.other:format(raidIcon.. L[83893], CL.casting:format(args.spellName)))
end

function mod:BramblePatch(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", nil, CL.underyou:format(args.spellName))
	end
end

-- Dulhu
function mod:Slash(args)
	self:MessageOld(args.spellId, "yellow")
end

-- General
function mod:ShapersFortitude(args)
	local raidIcon = CombatLog_String_GetIcon(args.destRaidFlags)
	local name = L[self:MobId(args.destGUID)] or args.destName
	self:MessageOld(args.spellId, "yellow", nil, CL.other:format(args.spellName, raidIcon..name))
	self:Bar(args.spellId, 8, CL.other:format(self:SpellName(111923), raidIcon..name)) -- 111923 = "Fortitude"
end

function mod:GolasDeath()
	golaHasDied = true
	self:INSTANCE_ENCOUNTER_ENGAGE_UNIT() -- no IEEU events on deaths
end
