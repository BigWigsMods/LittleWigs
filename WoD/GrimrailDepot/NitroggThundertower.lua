--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nitrogg Thundertower", 1208, 1163)
if not mod then return end
mod:RegisterEnableMob(
	79545, -- Nitrogg Thundertower
	79548, -- Assault Cannon
	77483, -- Grom'kar Gunner
	79720, -- Grom'kar Boomer
	79739  -- Grom'kar Grenadier
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
		163550, -- Blackrock Mortar
		{160681, "SAY", "ICON", "FLASH"}, -- Suppressive Fire
		166570, -- Slag Blast
		160965, -- Blackrock Mortar Shells
		156357, -- Blackrock Shrapnel
		161073, -- Blackrock Grenade
	}, {
		[163550] = -10620,
		[160681] = -10332,
		[160965] = -9713,
	}
end

function mod:OnBossEnable()
	-- Stages
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1", "boss2") -- Nitrogg becomes boss2 after cannon activates, cannon doesn't fire this event

	-- Nitrogg Thundertower
	self:Log("SPELL_CAST_START", "BlackrockMortar", 163550)

	-- Assault Cannon
	self:Log("SPELL_CAST_SUCCESS", "SuppressiveFire", 160681) -- APPLIED fires for cannon and player, use SUCCESS which happens at the exact same time
	self:Log("SPELL_AURA_REMOVED", "SuppressiveFireRemoved", 160681)
	self:Log("SPELL_CAST_START", "Reloading", 160680)
	self:Log("SPELL_CAST_START", "SlagBlast", 166565)
	self:Log("SPELL_AURA_APPLIED", "SlagBlastApplied", 166570)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SlagBlastApplied", 166570)

	-- Adds
	self:Log("SPELL_AURA_APPLIED", "PickedUpBlackrockShrapnel", 156357)
	self:Death("GunnerDies", 77483) -- Grom'kar Gunner

	self:Log("SPELL_AURA_APPLIED", "PickedUpMortarShells", 160702)
	self:Death("BoomerDies", 79720) -- Grom'kar Boomer

	self:Log("SPELL_AURA_APPLIED", "PickedUpGrenades", 160703)
	self:Death("GrenadierDies", 79739) -- Grom'kar Grenadier
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(163550, 10.1) -- Blackrock Mortar
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if UnitCanAttack("player", unit) then
		self:SetStage(3)
		self:Message("stages", "cyan", CL.stage:format(3), false)
		self:PlaySound("stages", "long")
		self:StopBar(166570) -- Slag Blast
	else
		self:SetStage(2)
		self:Message("stages", "cyan", CL.percent:format(60, CL.stage:format(2)), false)
		self:PlaySound("stages", "long")
		self:StopBar(163550) -- Blackrock Mortar
	end
end

-- Nitrogg Thundertower

function mod:BlackrockMortar(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 12.2)
end

-- Assault Cannon

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
		self:TargetMessage(160681, "red", player)
		self:PlaySound(160681, "alert", nil, player)
		self:PrimaryIcon(160681, player)
		if self:Me(guid) then
			self:Flash(160681)
			self:Say(160681)
		end
	end
	function mod:Reloading(args)
		self:GetBossTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:SlagBlast(args)
	self:Message(166570, "orange")
	self:PlaySound(166570, "alert")
	self:Bar(166570, 35.3)
end

function mod:SlagBlastApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

-- Adds

function mod:GunnerDies()
	self:Message(156357, "orange", L.dropped:format(self:SpellName(156357))) -- Blackrock Shrapnel
	self:PlaySound(156357, "info")
end

function mod:PickedUpBlackrockShrapnel(args)
	self:TargetMessage(156357, "green", args.destName)
end

function mod:BoomerDies()
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
