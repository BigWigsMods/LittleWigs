
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brother Korloff", 874, 671)
mod:RegisterEnableMob(59223)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "I will break you."

	L.fists, L.fists_desc = EJ_GetSectionInfo(5601)
	L.fists_icon = 114807

	L.firestorm, L.firestorm_desc = EJ_GetSectionInfo(5602)
	L.firestorm_icon = 113764
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"fists", 114460, "firestorm", "bosskill"}
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
	self:Bar("firestorm", L["firestorm"], 11, 113764)
	self:Bar("fists", L["fists"], 20, 114807)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BlazingFists(args)
	self:Message("fists", args.spellName, "Urgent", args.spellId, "Alert")
	self:Bar("fists", CL["cast"]:format(args.spellName), 6, args.spellId)
	self:Bar("fists", args.spellName, 30, args.spellId)
end

function mod:ScorchedEarthYou(args)
	if UnitIsUnit(args.destName, "player") then
		self:LocalMessage(114460, CL["underyou"]:format(args.spellName), "Personal", 114460, "Alarm")
		self:FlashShake(114460)
	end
end

function mod:FirestormKick(args)
	self:Message("firestorm", args.spellName, "Attention", args.spellId)
	self:Bar("firestorm", CL["cast"]:format(args.spellName), 6, args.spellId)
	self:Bar("firestorm", args.spellName, 25.2, args.spellId)
end

