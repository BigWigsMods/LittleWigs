
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Vigilant Kaathar", 984, 1185)
if not mod then return end
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
		153002, -- Holy Shield
		{153006, "FLASH"}, -- Consecrated Light
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "HolyShield", 153002)
	self:Log("SPELL_CAST_START", "ConsecratedLight", 153006)

	self:Death("Win", 75839)
end

function mod:OnEngage()
	self:CDBar(153002, 30.5) -- Holy Shield
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, player, guid)
		self:TargetMessage(153002, player, "Urgent", "Alert", nil, nil, true)
	end
	function mod:HolyShield(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 47)
		self:Bar(153006, 7) -- Consecrated Light
	end
end

function mod:ConsecratedLight(args)
	self:Message(args.spellId, "Important", "Warning")
	self:Bar(args.spellId, 12, CL.cast:format(args.spellName))
	self:Flash(args.spellId)
end

