
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brother Korloff", 1004, 671)
if not mod then return end
mod:RegisterEnableMob(59223)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.engage_yell = "I will break you."

	L.fists = -5601 -- Blazing Fists
	L.fists_icon = 114807

	L.firestorm = -5602 -- Firestorm Kick
	L.firestorm_icon = 113764
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"fists",
		{114460, "FLASH"}, -- Scorched Earth
		"firestorm",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BlazingFists", 114807)
	self:Log("SPELL_CAST_SUCCESS", "FirestormKick", 113764)

	self:Log("SPELL_DAMAGE", "ScorchedEarthYou", 114465)
	self:Log("SPELL_MISSED", "ScorchedEarthYou", 114465)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59223)
end

function mod:OnEngage()
	self:Bar("firestorm", 11, L["firestorm"], 113764)
	self:Bar("fists", 20, L["fists"], 114807)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BlazingFists(args)
	self:MessageOld("fists", "orange", "alert", args.spellId)
	self:Bar("fists", 6, CL["cast"]:format(args.spellName), args.spellId)
	self:Bar("fists", 30, args.spellId)
end

function mod:ScorchedEarthYou(args)
	if self:Me(args.destGUID) then
		self:MessageOld(114460, "blue", "alarm", CL["underyou"]:format(args.spellName))
		self:Flash(114460)
	end
end

function mod:FirestormKick(args)
	self:MessageOld("firestorm", "yellow", nil, args.spellId)
	self:Bar("firestorm", 6, CL["cast"]:format(args.spellName), args.spellId)
	self:Bar("firestorm", 25.2, args.spellId)
end
