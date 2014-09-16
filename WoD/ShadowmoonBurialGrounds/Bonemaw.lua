
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Bonemaw", 969, 1140)
if not mod then return end
mod:RegisterEnableMob(75452)

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
		{153804, "FLASH"}, -- Inhale
		154175, -- Body Slam
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "InhaleInc", "boss1")
	self:Log("SPELL_CAST_SUCCESS", "Inhale", 153804)
	self:Log("SPELL_CAST_START", "BodySlam", 154175)

	self:Death("Win", 75452)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InhaleInc(unit, spellName, _, _, spellId)
	if spellId == 154868 or spellId == 154214 then -- Inhale, Teleport Logic
		self:Message(153804, "Urgent", "Warning", CL.incoming:format(self:SpellName(153804)))
		self:Flash(153804)
	end
end

function mod:Inhale(args)
	self:Bar(args.spellId, 9, CL.cast:format(args.spellName))
	self:Message(args.spellId, "Urgent", "Warning")
end

function mod:BodySlam(args)
	self:Message(args.spellId, "Attention", "Alert")
end

