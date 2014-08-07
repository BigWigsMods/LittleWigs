
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Nitrogg Thundertower", 993, 1163)
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
	self:Log("SPELL_AURA_APPLIED", "SuppressiveFire", 160681)
	self:Log("SPELL_AURA_REMOVED", "SuppressiveFireRemoved", 160681)

	self:Death("Win", 79545)
	self:Death("Grenadier", 79739) -- Blackrock Grenadier
	self:Death("Engineer", 79720) -- Blackrock Artillery Engineer
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

function mod:Grenadier(args)
	self:Message(161073, "Attention", nil, L.dropped:format(self:SpellName(161073)))
end

function mod:Engineer(args)
	self:Message(160965, "Urgent", "Alert", L.dropped:format(self:SpellName(160965)))
end

