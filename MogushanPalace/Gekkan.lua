
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gekkan", 885, 690)
mod:RegisterEnableMob(61243)

local deaths = 0
local heal = mod:SpellName(33144)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "Stop them!"

	L.heal = EJ_GetSectionInfo(5923) .. " ("..heal..")"
	L.heal_desc = select(2, EJ_GetSectionInfo(5923))
	L.heal_icon = 118940

	L.unit_killed = "%s killed! (%d/5)"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"ej:5921", "heal", "ej:5925", "bosskill"}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:OnEngage()
	-- Trash trigger these, so register after engage
	self:Log("SPELL_AURA_APPLIED", "Shank", 118963)
	self:Log("SPELL_AURA_APPLIED", "Hex", 118903)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Hex", 118903)
	self:Log("SPELL_AURA_REMOVED", "HexRemoved", 118903)
	self:Log("SPELL_CAST_START", "Heal", 118940)
	self:Log("SPELL_INTERRUPT", "HealStop", "*")

	self:Death("Deaths", 61243, 61337, 61338, 61339, 61340)

	-- Reset fires after Gekkan dies, even if the encounter hasn't ended
	self:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Shank(args)
	self:TargetMessage("ej:5921", args.spellName, args.destName, "Attention", args.spellId)
	self:TargetBar("ej:5921", args.spellName, args.destName, 5, args.spellId)
end

do
	local hex = mod:SpellName(66054)
	function mod:Hex(args)
		self:TargetMessage("ej:5925", hex, args.destName, "Important", args.spellId)
		self:TargetBar("ej:5925", hex, args.destName, 20, args.spellId)
	end
	function mod:HexRemoved(args)
		self:StopBar(hex, args.destName)
	end
end

function mod:Heal(args)
	self:Message("heal", CL["other"]:format(args.sourceName, heal), "Urgent", args.spellId, "Alert")
	self:Bar("heal", CL["cast"]:format(heal), 3.2, args.spellId)
end

function mod:HealStop(args)
	if args.extraSpellID == 118940 then
		self:StopBar(CL["cast"]:format(heal))
	end
end

function mod:Deaths(args)
	deaths = deaths + 1
	if deaths == 5 then
		self:Win()
	else
		self:Message("bosskill", L["unit_killed"]:format(args.destName, deaths), "Positive", nil, "Info")
	end
end

