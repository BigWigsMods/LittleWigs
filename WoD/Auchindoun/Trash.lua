
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Auchindoun Trash", 1182)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(79508)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.abyssal = "Felborne Abyssal"
end

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
	self:TargetMessageOld(args.spellId, args.destName, "red", "alert")
	self:TargetBar(args.spellId, 12, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId, nil, nil, "Fixate")
	end
end
