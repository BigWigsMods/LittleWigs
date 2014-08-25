
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Auchindoun Trash", 984)
mod:RegisterEnableMob(79508)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.displayname = "Trash"

	L.abyssal = "Felborne Abyssal"
end
L = mod:GetLocale()
mod.displayName = L.displayname

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{157168, "FLASH", "SAY", "ICON"}
	}, {
		[157168] = L.abyssal,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Fixate", 157168)

	self:Death("Disable", 79508)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Fixate(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:TargetBar(args.spellId, 12, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
	end
end

