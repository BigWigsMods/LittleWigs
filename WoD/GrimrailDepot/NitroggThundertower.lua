--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nitrogg Thundertower", 1208, 1163)
if not mod then return end
mod:RegisterEnableMob(
	79545,  -- Nitrogg Thundertower
	79548,  -- Assault Cannon
	129822, -- Grom'kar Gunner
	129824, -- Grom'kar Boomer
	129823  -- Grom'kar Grenadier
)
mod:SetEncounterID(1732)
mod:SetRespawnTime(30)
mod:SetStage(1)

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
		{160681, "SAY", "ICON", "FLASH"}, -- Suppressive Fire
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
	self:Message("stages", "cyan", CL.stage:format(1))
	self:SetStage(1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if UnitCanAttack("player", unit) then
		self:SetStage(3)
		self:Message("stages", "cyan", CL.stage:format(3))
		self:PlaySound("stages", "long")
	else
		self:SetStage(2)
		self:Message("stages", "cyan", CL.percent:format(60, CL.stage:format(2)))
		self:PlaySound("stages", "long")
	end
end

function mod:SuppressiveFire(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:TargetBar(args.spellId, 10, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SuppressiveFireRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellId, args.destName)
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(160681, "red", player)
		self:PlaySound(160681, "alert", nil, player)
		self:PrimaryIcon(160681, player)
		if self:Me(guid) then
			self:Flash(160681)
		end
	end
	function mod:Reloading(args)
		self:GetBossTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:EngineerDies()
	self:Message(160965, "orange", L.dropped:format(self:SpellName(160965))) -- Blackrock Mortar Shells
	self:PlaySound(160965, "info")
end

function mod:PickedUpMortarShells(args)
	self:TargetMessage(160965, "green", args.destName)
end

function mod:GrenadierDies()
	self:Message(161073, "yellow", L.dropped:format(self:SpellName(161073))) -- Blackrock Grenade
end

function mod:PickedUpGrenades(args)
	self:TargetMessage(161073, "green", args.destName)
end

function mod:SlagBlast(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end
