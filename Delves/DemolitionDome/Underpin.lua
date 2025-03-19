--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Underpin", 2831)
if not mod then return end
mod:RegisterEnableMob(234168) -- The Underpin (Tier 8)
mod:SetEncounterID(3126)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.the_underpin = "The Underpin (Tier 8)"
	L.crony = "Crony"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.the_underpin
end

function mod:GetOptions()
	return {
		1213852, -- Crush
		1217371, -- Flamethrower
		1214147, -- Time Bomb Launcher
		1215521, -- Signal Cronies
		1214052, -- Divert Energy to Shields
		{1214053, "CASTBAR"}, -- Recharge
		-- Crony
		{1214043, "OFF"}, -- Molten Cannon
		1218153, -- Flaming Wreckage
	}, {
		[1214043] = L.crony,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Crush", 1213852)
	self:Log("SPELL_CAST_START", "Flamethrower", 1217371)
	self:Log("SPELL_CAST_SUCCESS", "TimeBombLauncher", 1214147)
	self:Log("SPELL_CAST_START", "SignalCronies", 1215521)
	self:Log("SPELL_CAST_START", "DivertEnergyToShields", 1214052)
	self:Log("SPELL_AURA_APPLIED", "DivertEnergyToShieldsApplied", 1214052)
	self:Log("SPELL_AURA_REMOVED", "DivertEnergyToShieldsRemoved", 1214052)

	-- Crony (npc 235162)
	self:Log("SPELL_CAST_START", "MoltenCannon", 1214043)
	self:Log("SPELL_PERIODIC_DAMAGE", "FlamingWreckageDamage", 1218153)
	self:Log("SPELL_PERIODIC_MISSED", "FlamingWreckageDamage", 1218153)
end

function mod:OnEngage()
	self:CDBar(1213852, 4.5) -- Crush
	self:CDBar(1217371, 9.4) -- Flamethrower
	self:CDBar(1214147, 13.0) -- Time Bomb Launcher
	self:CDBar(1215521, 17.1) -- Signal Cronies
	-- cast at 100 energy, 45s energy gain + delay
	self:CDBar(1214052, 45.8) -- Divert Energy to Shields
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Crush(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 20.1)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Flamethrower(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 20.4)
	self:PlaySound(args.spellId, "alarm")
end

function mod:TimeBombLauncher(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 25.4)
	self:PlaySound(args.spellId, "info")
end

function mod:SignalCronies(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 71.6)
	self:PlaySound(args.spellId, "long")
end

function mod:DivertEnergyToShields(args)
	-- will not be cast if above 80% HP
	self:StopBar(args.spellId)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "warning")
end

do
	local rechargeStart = 0

	function mod:DivertEnergyToShieldsApplied(args)
		rechargeStart = args.time
		self:CastBar(1214053, 15) -- Recharge
	end

	function mod:DivertEnergyToShieldsRemoved(args)
		self:StopCastBar(self:SpellName(1214053)) -- Recharge
		-- 45s enery gain + delay
		self:CDBar(args.spellId, 45.8) -- Divert Energy to Shields
		if args.amount > 0 then
			self:Message(args.spellId, "cyan", CL.percent:format(25, self:SpellName(1214053))) -- Recharge
			self:PlaySound(args.spellId, "warning")
		else
			self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, args.time - rechargeStart))
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
