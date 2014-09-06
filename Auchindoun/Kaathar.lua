
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Vigilant Kaathar", 984, 1185)
mod:RegisterEnableMob(75839)

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
		153002, 153006, "bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	-- XXX Currently doesn't fire IEEU, rely on the old fashioned engage
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:Log("SPELL_CAST_START", "HolyShield", 153002)
	self:Log("SPELL_CAST_START", "ConsecratedLight", 153006)

	self:Death("Win", 75839)
end

function mod:OnEngage()
	self:CDBar(153002, 30) -- Holy Shield
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HolyShield(args)
	-- XXX warn for target?
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 47)
	self:Bar(153006, 7)
end

function mod:ConsecratedLight(args)
	self:Message(args.spellId, "Important", "Alert")
	self:Bar(args.spellId, 9, CL.cast:format(args.spellName))
end

