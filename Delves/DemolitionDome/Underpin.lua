--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Underpin", 2831)
if not mod then return end
mod:RegisterEnableMob(236626, 234168, 236537, 236942, 234356, 234340, 236948) -- The Underpin (Tier 8)
--mod:SetEncounterID(3138) TODO temp until which ID goes with which encounter is determined
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
		1217667, -- Divert Energy to Shields
		1216333, -- Oil Spill
		1217371, -- Flamethrower
		1214147, -- Time Bomb Launcher
		1215521, -- Signal Cronies
		-- Crony
		1213950, -- Disperse Crowd
		1214043, -- Molten Cannon
		1218153, -- Flaming Wreckage
	}, {
		[1213950] = L.crony,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") -- XXX until encounter ids can be identified
	self:RegisterEvent("ENCOUNTER_END") -- XXX until encounter ids can be identified
	self:Log("SPELL_CAST_START", "Crush", 1213852)
	self:Log("SPELL_CAST_START", "DivertEnergyToShields", 1217667, 1214052) -- TODO which
	self:Log("SPELL_CAST_SUCCESS", "OilSpill", 1216333)
	self:Log("SPELL_CAST_START", "Flamethrower", 1217371, 1213869, 1213866) -- TODO which
	self:Log("SPELL_CAST_SUCCESS", "TimeBombLauncher", 1214147, 1214149, 1214148) -- TODO which
	self:Log("SPELL_CAST_START", "SignalCronies", 1215521, 1217661) -- TODO which

	-- Crony
	-- TODO any summon event? or just RegisterEngageMob
	self:Log("SPELL_CAST_START", "DisperseCrowd", 1213950)
	self:Log("SPELL_CAST_START", "MoltenCannon", 1214043)
	self:Log("SPELL_PERIODIC_DAMAGE", "FlamingWreckageDamage", 1218153)
	self:Log("SPELL_PERIODIC_MISSED", "FlamingWreckageDamage", 1218153)
	self:Death("CronyDeath", 235162, 237432) -- TODO which
end

function mod:OnEngage()
	--self:CDBar(1213852, 100) -- Crush
	--self:CDBar(1217667, 100) -- Divert Energy to Shields
	--self:CDBar(1216333, 100) -- Oil Spill
	--self:CDBar(1217371, 100) -- Flamethrower
	--self:CDBar(1214147, 100) -- Time Bomb Launcher
	--self:CDBar(1215521, 100) -- Signal Cronies
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, id)
	if id == 3138 or id == 3126 then -- XXX don't know which is which, use this module for both for now
		self:Engage()
		local easyWidget = self:GetWidgetInfo("delve", 6184)
		local hardWidget = self:GetWidgetInfo("delve", 6185)
		local tierText = ""
		if type(easyWidget) == "table" and easyWidget.shownState == 1 then
			tierText = easyWidget.tierText or "nil"
		elseif type(hardWidget) == "table" and hardWidget.shownState == 1 then
			tierText = hardWidget.tierText or "nil"
		end
		local mobId = ""
		for enableMob in next, self.enableMobs do
			if self:GetUnitIdByGUID(enableMob) then
				mobId = enableMob
				break
			end
		end
		self:Error("Please report to the devs: "..id.." - "..mobId.." (Tier "..tierText..")")
	end
end

function mod:ENCOUNTER_END(_, id, _, _, _, status)
	if id == 3138 or id == 3126 then -- XXX don't know which is which, use this module for both for now
		if status == 0 then
			self:Wipe()
		else
			self:Win()
		end
	end
end

function mod:Crush(args)
	self:Message(args.spellId, "orange")
	--self:CDBar(args.spellId, 100)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:DivertEnergyToShields(args)
		if args.time - prev > 10 then -- temporary throttle
			prev = args.time
			self:Message(1217667, "cyan")
			--self:CastBar(1217667, 10, 1217666) -- Recharge
			--self:CDBar(1217667, 100)
			self:PlaySound(1217667, "long")
		end
	end
end

function mod:OilSpill(args)
	--self:StopBar(CL.cast:format(self:SpellName(1217666))) -- Recharge
	self:Message(args.spellId, "green")
	--self:CDBar(args.spellId, 100)
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:Flamethrower(args)
		if args.time - prev > 10 then -- temporary throttle
			prev = args.time
			self:Message(1217371, "red")
			--self:CDBar(1217371, 100)
			self:PlaySound(1217371, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:TimeBombLauncher(args)
		if args.time - prev > 10 then -- temporary throttle
			prev = args.time
			self:Message(1214147, "yellow")
			--self:CDBar(1214147, 100)
			self:PlaySound(1214147, "info")
		end
	end
end

do
	local prev = 0
	function mod:SignalCronies(args)
		if args.time - prev > 10 then -- temporary throttle
			prev = args.time
			self:Message(1215521, "cyan")
			--self:CDBar(1215521, 100)
			self:PlaySound(1215521, "long")
		end
	end
end

-- Underpin's Crony

do
	local prev = 0
	function mod:DisperseCrowd(args)
		--self:Nameplate(args.spellId, 100, args.sourceGUID)
		if args.time - prev > 2 then -- temporary throttle
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:MoltenCannon(args)
		--self:Nameplate(args.spellId, 100, args.sourceGUID)
		if args.time - prev > 2 then -- temporary throttle
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

function mod:CronyDeath(args)
	self:ClearNameplate(args.destGUID)
end
