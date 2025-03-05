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
	self:Log("SPELL_AURA_APPLIED", "RechargeApplied", 1214053)
	self:Log("SPELL_AURA_REMOVED", "RechargeRemoved", 1214053)

	-- Crony (npc 235162)
	self:Log("SPELL_CAST_START", "MoltenCannon", 1214043)
	self:Log("SPELL_PERIODIC_DAMAGE", "FlamingWreckageDamage", 1218153)
	self:Log("SPELL_PERIODIC_MISSED", "FlamingWreckageDamage", 1218153)
end

function mod:OnEngage()
	self:CDBar(1213852, 4.6) -- Crush
	self:CDBar(1217371, 9.5) -- Flamethrower
	self:CDBar(1214147, 13.1) -- Time Bomb Launcher
	self:CDBar(1215521, 17.2) -- Signal Cronies
	self:CDBar(1214052, 45.8) -- Divert Energy to Shields
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Crush(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 20.2)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Flamethrower(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 20.4)
	self:PlaySound(args.spellId, "alarm")
end

function mod:TimeBombLauncher(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 25.5)
	self:PlaySound(args.spellId, "info")
end

function mod:SignalCronies(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 73.5)
	self:PlaySound(args.spellId, "long")
end

function mod:DivertEnergyToShields(args)
	self:Message(args.spellId, "cyan")
	-- TODO timer based off something else?
	self:CDBar(args.spellId, 52.2)
	self:PlaySound(args.spellId, "warning")
end

function mod:RechargeApplied(args)
	self:CastBar(args.spellId, 20)
end

function mod:RechargeRemoved(args)
	-- TODO recharge over message? alert fail/success on shield break?
	self:StopBar(CL.cast:format(args.spellName))
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
