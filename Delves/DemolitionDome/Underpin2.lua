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
		1213950, -- Disperse Crowd
		1218153, -- Flaming Wreckage
	}, {
		[1214043] = L.crony,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Crush", 1213852)
	self:Log("SPELL_CAST_START", "Flamethrower", 1217371)
	self:Log("SPELL_CAST_SUCCESS", "TimeBombLauncher", 1214147)
	self:Log("SPELL_CAST_START", "SignalCronies", 1217661)
	self:Log("SPELL_CAST_START", "DivertEnergyToShields", 1217667)
	self:Log("SPELL_AURA_APPLIED", "RechargeApplied", 1217666)
	self:Log("SPELL_AURA_REMOVED", "RechargeRemoved", 1217666)

	-- Crony (npc 237432)
	self:Log("SPELL_CAST_START", "MoltenCannon", 1214043)
	self:Log("SPELL_CAST_START", "DisperseCrowd", 1213950) -- TODO not cast? Stage 2?
	self:Log("SPELL_PERIODIC_DAMAGE", "FlamingWreckageDamage", 1218153)
	self:Log("SPELL_PERIODIC_MISSED", "FlamingWreckageDamage", 1218153)
end

function mod:OnEngage()
	self:CDBar(1213852, 4.6) -- Crush
	self:CDBar(1217371, 9.4) -- Flamethrower
	self:CDBar(1214147, 17.9) -- Time Bomb Launcher
	self:CDBar(1217661, 22.0) -- Signal Cronies
	self:CDBar(1217667, 73.8) -- Divert Energy to Shields
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Crush(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Flamethrower(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 15.1)
	self:PlaySound(args.spellId, "alarm")
end

function mod:TimeBombLauncher(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 20.6)
	self:PlaySound(args.spellId, "info")
end

function mod:SignalCronies(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 48.2)
	self:PlaySound(args.spellId, "long")
end

function mod:DivertEnergyToShields(args)
	self:Message(args.spellId, "cyan")
	-- TODO timer based off something else?
	self:CDBar(args.spellId, 64.6)
	self:PlaySound(args.spellId, "warning")
end

function mod:RechargeApplied(args)
	self:CastBar(args.spellId, 15)
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
	function mod:DisperseCrowd(args) -- TODO not cast?
		if args.time - prev > 4 then -- temporary throttle
			prev = args.time
			self:Message(args.spellId, "yellow")
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
