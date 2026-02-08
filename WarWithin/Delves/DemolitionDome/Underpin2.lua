--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Underpin 2", 2831)
if not mod then return end
mod:RegisterEnableMob(236626) -- The Underpin (Tier 11)
mod:SetEncounterID(3138)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.the_underpin = "The Underpin (Tier 11)"
	L.crony = "Crony"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.the_underpin
	self:SetSpellRename(1213852, CL.leap) -- Crush (Leap)
	self:SetSpellRename(1217371, CL.frontal_cone) -- Flamethrower (Frontal Cone)
	self:SetSpellRename(1214147, CL.bombs) -- Time Bomb Launcher (Bombs)
	self:SetSpellRename(1217661, CL.adds) -- Signal Cronies (Adds)
	self:SetSpellRename(1217667, CL.shield) -- Divert Energy to Shields (Shield)
end

function mod:GetOptions()
	return {
		1213852, -- Crush
		1217371, -- Flamethrower
		1214147, -- Time Bomb Launcher
		1217661, -- Signal Cronies
		1217667, -- Divert Energy to Shields
		{1217666, "CASTBAR"}, -- Recharge
		-- Crony
		{1214043, "OFF"}, -- Molten Cannon
		1218153, -- Flaming Wreckage
	},{
		[1214043] = L.crony,
	},{
		[1213852] = CL.leap, -- Crush (Leap)
		[1217371] = CL.frontal_cone, -- Flamethrower (Frontal Cone)
		[1214147] = CL.bombs, -- Time Bomb Launcher (Bombs)
		[1217661] = CL.adds, -- Signal Cronies (Adds)
		[1217667] = CL.shield, -- Divert Energy to Shields (Shield)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Crush", 1213852)
	self:Log("SPELL_CAST_START", "Flamethrower", 1217371)
	self:Log("SPELL_CAST_SUCCESS", "TimeBombLauncher", 1214147)
	self:Log("SPELL_CAST_START", "SignalCronies", 1217661)
	self:Log("SPELL_CAST_START", "DivertEnergyToShields", 1217667)
	self:Log("SPELL_AURA_APPLIED", "DivertEnergyToShieldsApplied", 1217667)
	self:Log("SPELL_AURA_REMOVED", "DivertEnergyToShieldsRemoved", 1217667)

	-- Crony (npc 237432)
	self:Log("SPELL_CAST_START", "MoltenCannon", 1214043)
	self:Log("SPELL_PERIODIC_DAMAGE", "FlamingWreckageDamage", 1218153)
	self:Log("SPELL_PERIODIC_MISSED", "FlamingWreckageDamage", 1218153)
end

function mod:OnEngage()
	self:CDBar(1213852, 4.6, CL.leap) -- Crush
	self:CDBar(1217371, 9.4, CL.frontal_cone) -- Flamethrower
	self:CDBar(1214147, 17.0, CL.bombs) -- Time Bomb Launcher
	self:CDBar(1217661, 21.1, CL.adds) -- Signal Cronies
	-- cast at 100 energy, 45s energy gain + delay
	self:CDBar(1217667, 45.8, CL.shield) -- Divert Energy to Shields
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Crush(args)
	self:Message(args.spellId, "orange", CL.leap)
	self:CDBar(args.spellId, 15.4, CL.leap)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Flamethrower(args)
	self:Message(args.spellId, "red", CL.frontal_cone)
	self:CDBar(args.spellId, 15.1, CL.frontal_cone)
	self:PlaySound(args.spellId, "alarm")
end

function mod:TimeBombLauncher(args)
	self:Message(args.spellId, "yellow", CL.bombs)
	self:CDBar(args.spellId, 20.6, CL.bombs)
	self:PlaySound(args.spellId, "info")
end

function mod:SignalCronies(args)
	self:Message(args.spellId, "cyan", CL.adds)
	self:CDBar(args.spellId, 48.2, CL.adds)
	self:PlaySound(args.spellId, "long")
end

function mod:DivertEnergyToShields(args)
	-- will not be cast if above 80% HP
	self:StopBar(CL.shield)
	self:Message(args.spellId, "cyan", CL.shield)
	self:PlaySound(args.spellId, "warning")
end

do
	local rechargeStart = 0

	function mod:DivertEnergyToShieldsApplied(args)
		rechargeStart = args.time
		self:CastBar(1217666, 15) -- Recharge
	end

	function mod:DivertEnergyToShieldsRemoved(args)
		self:StopCastBar(self:SpellName(1217666)) -- Recharge
		-- 45s enery gain + delay
		self:CDBar(args.spellId, 45.8, CL.shield) -- Divert Energy to Shields
		if args.amount > 0 then
			self:Message(args.spellId, "cyan", CL.percent:format(25, self:SpellName(1217666))) -- Recharge
			self:PlaySound(args.spellId, "warning")
		else
			self:Message(args.spellId, "green", CL.removed_after:format(CL.shield, args.time - rechargeStart))
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Crony

do
	local prev = 0
	function mod:MoltenCannon(args)
		-- no cooldown, spammed by each Crony
		if args.time - prev > 4 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:FlamingWreckageDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end
