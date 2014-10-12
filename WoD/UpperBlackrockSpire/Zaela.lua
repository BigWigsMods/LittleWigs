
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Warlord Zaela", 995, 1234)
if not mod then return end
mod:RegisterEnableMob(77120)

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
		{155721, "ICON", "FLASH"}, -- Black Iron Cyclone
		"stages",
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "BlackIronCyclone", 155721)
	self:Log("SPELL_AURA_REMOVED", "BlackIronCycloneOver", 155721)

	self:RegisterEvent("UNIT_TARGETABLE_CHANGED")

	self:Death("Win", 77120)
end

function mod:OnEngage()
	self:CDBar(155721, 12.5) -- Black Iron Cyclone
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BlackIronCyclone(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 4.5, args.destName)
	self:CDBar(args.spellId, 19) -- 18-21
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:BlackIronCycloneOver(args)
	self:PrimaryIcon(args.spellId)
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if UnitCanAttack("player", unit) then
		self:Message("stages", "Important", "Info", CL.incoming:format(self.displayName), "achievement_character_orc_female")
	else
		self:Message("stages", "Important", "Info", ("60%% - %s"):format(CL.intermission), false)
		self:DelayedMessage("stages", 1, "Important", self:SpellName(-10741), "achievement_character_orc_male") -- Black Iron Wyrm Riders
		self:Bar("stages", 28, CL.intermission, "achievement_character_orc_female")
		self:StopBar(155721) -- Black Iron Cyclone
	end
end

