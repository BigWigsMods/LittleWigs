
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Nitrogg Thundertower", 993, 1163)
if not mod then return end
mod:RegisterEnableMob(79545)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.dropped = "%s dropped!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		161073,
		160965,
		{160681, "ICON", "FLASH"},
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_SUCCESS", "SuppressiveFire", 160681) -- APPLIED fires for cannon and player, use SUCCESS which happens at the exact same time
	self:Log("SPELL_AURA_REMOVED", "SuppressiveFireRemoved", 160681)

	self:Log("SPELL_AURA_APPLIED", "PickedUpMortarShells", 160702)
	self:Death("EngineerDies", 79720) -- Blackrock Artillery Engineer

	self:Log("SPELL_AURA_APPLIED", "PickedUpGrenades", 160703)
	self:Death("GrenadierDies", 79739) -- Blackrock Grenadier

	self:Death("Win", 79545)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SuppressiveFire(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Warning")
	self:TargetBar(args.spellId, 10, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:SuppressiveFireRemoved(args)
	self:PrimaryIcon(args.spellId)
end

do
	function mod:EngineerDies(args)
		self:Message(160965, "Urgent", "Alert", L.dropped:format(self:SpellName(160965)))
	end

	function mod:PickedUpMortarShells(args)
		self:TargetMessage(160965, args.destName, "Positive")
	end
end

do
	function mod:GrenadierDies(args)
		self:Message(161073, "Attention", nil, L.dropped:format(self:SpellName(161073)))
	end

	function mod:PickedUpGrenades(args)
		self:TargetMessage(161073, args.destName, "Positive")
	end
end

