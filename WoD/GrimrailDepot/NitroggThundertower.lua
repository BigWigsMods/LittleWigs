
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nitrogg Thundertower", 1208, 1163)
if not mod then return end
mod:RegisterEnableMob(79545)
mod.engageId = 1732
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dropped = "%s dropped!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		161073, -- Blackrock Grenade
		160965, -- Blackrock Mortar Shells
		{160681, "ICON", "FLASH"}, -- Suppressive Fire
		166570, -- Slag Blast
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1", "boss2") -- Nitrogg becomes boss2 after cannon activates, cannon doesn't fire this event

	self:Log("SPELL_CAST_SUCCESS", "SuppressiveFire", 160681) -- APPLIED fires for cannon and player, use SUCCESS which happens at the exact same time
	self:Log("SPELL_AURA_REMOVED", "SuppressiveFireRemoved", 160681)
	self:Log("SPELL_CAST_START", "Reloading", 160680)

	self:Log("SPELL_AURA_APPLIED", "PickedUpMortarShells", 160702)
	self:Death("EngineerDies", 79720) -- Blackrock Artillery Engineer

	self:Log("SPELL_AURA_APPLIED", "PickedUpGrenades", 160703)
	self:Death("GrenadierDies", 79739) -- Blackrock Grenadier

	self:Log("SPELL_AURA_APPLIED", "SlagBlast", 166570)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SlagBlast", 166570)
end

function mod:OnEngage()
	self:MessageOld("stages", "cyan", nil, CL.stage:format(1), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if UnitCanAttack("player", unit) then
		self:MessageOld("stages", "cyan", "long", CL.stage:format(3), false)
	else
		self:MessageOld("stages", "cyan", "long", CL.percent:format(60, CL.stage:format(2)), false)
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
		self:TargetMessageOld(160681, player, "red", "alert")
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
		self:MessageOld(160965, "orange", "info", L.dropped:format(self:SpellName(160965))) -- Blackrock Mortar Shells
	end

	function mod:PickedUpMortarShells(args)
		self:TargetMessageOld(160965, args.destName, "green")
	end
end

do
	function mod:GrenadierDies()
		self:MessageOld(161073, "yellow", nil, L.dropped:format(self:SpellName(161073))) -- Blackrock Grenade
	end

	function mod:PickedUpGrenades(args)
		self:TargetMessageOld(161073, args.destName, "green")
	end
end

function mod:SlagBlast(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
	end
end
