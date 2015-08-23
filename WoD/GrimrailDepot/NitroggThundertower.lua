
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nitrogg Thundertower", 993, 1163)
if not mod then return end
mod:RegisterEnableMob(79545)

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1

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
		161073, -- Blackrock Grenade
		160965, -- Blackrock Mortar Shells
		{160681, "ICON", "FLASH"}, -- Suppressive Fire
		166570, -- Slag Blast
		"phases",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "SuppressiveFire", 160681) -- APPLIED fires for cannon and player, use SUCCESS which happens at the exact same time
	self:Log("SPELL_AURA_REMOVED", "SuppressiveFireRemoved", 160681)
	self:Log("SPELL_CAST_START", "Reloading", 160680)

	self:Log("SPELL_AURA_APPLIED", "PickedUpMortarShells", 160702)
	self:Death("EngineerDies", 79720) -- Blackrock Artillery Engineer

	self:Log("SPELL_AURA_APPLIED", "PickedUpGrenades", 160703)
	self:Death("GrenadierDies", 79739) -- Blackrock Grenadier

	self:Log("SPELL_AURA_APPLIED", "SlagBlast", 166570)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SlagBlast", 166570)

	self:Death("Win", 79545)
end

function mod:OnEngage()
	phase = 1
	self:Message("phases", "Neutral", nil, CL.phase:format(1), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_TARGETABLE_CHANGED()
	if phase == 1 then
		phase = 2
		self:Message("phases", "Neutral", "Long", "60% - ".. CL.phase:format(2), false)
	elseif phase == 2 then
		phase = 3
		self:Message("phases", "Neutral", "Long", CL.phase:format(3), false)
	end
end

function mod:SuppressiveFire(args)
	self:TargetBar(args.spellId, 10, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SuppressiveFireRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellId, args.destName)
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(160681, player, "Important", "Alert")
		self:PrimaryIcon(160681, player)
		if self:Me(guid) then
			self:Flash(160681)
		end
	end
	function mod:Reloading(args)
		self:GetBossTarget(printTarget, 0.3, args.sourceGUID)
	end
end

do
	function mod:EngineerDies()
		self:Message(160965, "Urgent", "Info", L.dropped:format(self:SpellName(160965)))
	end

	function mod:PickedUpMortarShells(args)
		self:TargetMessage(160965, args.destName, "Positive")
	end
end

do
	function mod:GrenadierDies()
		self:Message(161073, "Attention", nil, L.dropped:format(self:SpellName(161073)))
	end

	function mod:PickedUpGrenades(args)
		self:TargetMessage(161073, args.destName, "Positive")
	end
end

function mod:SlagBlast(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

