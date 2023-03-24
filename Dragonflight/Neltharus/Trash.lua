--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharus Trash", 2519)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	193293, -- Qalashi Warden
	189227, -- Qalashi Hunter
	189669, -- Binding Spear
	189235, -- Overseer Lahar
	189266, -- Qalashi Trainee
	189265, -- Qalashi Bonetender
	189464, -- Qalashi Irontorch
	189472, -- Qalashi Lavabearer
	189466, -- Irontorch Commander
	194816, -- Forgewrought Monstrosity
	192786, -- Qalashi Plunderer
	192788, -- Qalashi Thaumaturge
	193291, -- Apex Blazewing
	193944  -- Qalashi Lavamancer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.qalashi_warden = "Qalashi Warden"
	L.qalashi_hunter = "Qalashi Hunter"
	L.overseer_lahar = "Overseer Lahar"
	L.qalashi_trainee = "Qalashi Trainee"
	L.qalashi_bonetender = "Qalashi Bonetender"
	L.qalashi_irontorch = "Qalashi Irontorch"
	L.qalashi_lavabearer = "Qalashi Lavabearer"
	L.irontorch_commander = "Irontorch Commander"
	L.forgewrought_monstrosity = "Forgewrought Monstrosity"
	L.qalashi_plunderer = "Qalashi Plunderer"
	L.qalashi_thaumaturge = "Qalashi Thaumaturge"
	L.apex_blazewing = "Apex Blazewing"
	L.qalashi_lavamancer = "Qalahsi Lavamancer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Qalashi Warden
		382708, -- Volcanic Guard
		-- Qalashi Hunter
		372561, -- Binding Spear
		-- Overseer Lahar
		395427, -- Burning Roar
		376186, -- Eruptive Crush
		-- Qalashi Trainee
		372311, -- Magma Fist
		-- Qalashi Bonetender
		372223, -- Mending Clay
		-- Qalashi Irontorch
		372201, -- Scorching Breath
		384161, -- Mote of Combustion
		-- Qalashi Lavabearer
		379406, -- Throw Lava
		-- Irontorch Commander
		372296, -- Conflagrant Battery
		373084, -- Scorching Fusillade
		-- Forgewrought Monstrosity
		376200, -- Blazing Detonation
		-- Qalashi Plunderer
		378827, -- Explosive Concoction
		-- Qalashi Thaumaturge
		378282, -- Molten Core
		-- Apex Blazewing
		381663, -- Candescent Tempest
		-- Qalashi Lavamancer
		383651, -- Molten Army
	}, {
		[382708] = L.qalashi_warden,
		[372561] = L.qalashi_hunter,
		[395427] = L.overseer_lahar,
		[372311] = L.qalashi_trainee,
		[372223] = L.qalashi_bonetender,
		[372201] = L.qalashi_irontorch,
		[379406] = L.qalashi_lavabearer,
		[372296] = L.irontorch_commander,
		[376200] = L.forgewrought_monstrosity,
		[378827] = L.qalashi_plunderer,
		[378282] = L.qalashi_thaumaturge,
		[381663] = L.apex_blazewing,
		[383651] = L.qalashi_lavamancer,
	}
end

function mod:OnBossEnable()
	-- General
	self:Log("SPELL_CAST_START", "ThrowExperimentalConcoction", 376169)

	-- Qalashi Warden
	self:Log("SPELL_CAST_START", "VolcanicGuard", 382708)

	-- Qalashi Hunter
	self:Log("SPELL_CAST_START", "BindingSpear", 372561)
	self:Log("SPELL_AURA_APPLIED", "BindingSpearApplied", 373540)

	-- Overseer Lahar
	self:Log("SPELL_CAST_START", "BurningRoar", 395427)
	self:Log("SPELL_CAST_START", "EruptiveCrush", 376186)

	-- Qalashi Trainee
	self:Log("SPELL_CAST_START", "MagmaFist", 372311)
	
	-- Qalashi Bonetender
	self:Log("SPELL_CAST_START", "MendingClay", 372223)

	-- Qalashi Irontorch
	self:Log("SPELL_CAST_START", "ScorchingBreath", 372201)
	self:Log("SPELL_CAST_START", "MoteOfCombustion", 384161)
	self:Log("SPELL_AURA_APPLIED", "MoteOfCombustionApplied", 384161)

	-- Qalashi Lavabearer
	self:Log("SPELL_CAST_START", "ThrowLava", 379406)

	-- Irontorch Commander
	self:Log("SPELL_CAST_SUCCESS", "ConflagrantBattery", 372296)
	self:Log("SPELL_CAST_START", "ScorchingFusillade", 373084)
	self:Death("IrontorchCommanderDeath", 189466)
	
	-- Forgewrought Monstrosity
	self:Log("SPELL_CAST_START", "BlazingDetonation", 376200)

	-- Qalashi Plunderer
	self:Log("SPELL_CAST_START", "ExplosiveConcoction", 378827)
	
	-- Qalashi Thaumaturge
	self:Log("SPELL_CAST_START", "MoltenCore", 378282)
	
	-- Apex Blazewing
	self:Log("SPELL_AURA_APPLIED", "CandescentTempest", 381663)
	
	-- Qalashi Lavamancer
	self:Log("SPELL_CAST_START", "MoltenArmy", 383651)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:ThrowExperimentalConcoction(args)
	-- Magmatusk warmup
	local magmatuskModule = BigWigs:GetBossModule("Magmatusk", true)
	if magmatuskModule then
		magmatuskModule:Enable()
		magmatuskModule:Warmup()
	end
end

-- Qalashi Warden

function mod:VolcanicGuard(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Qalashi Hunter

do
	local prev = 0
	function mod:BindingSpear(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:BindingSpearApplied(args)
	-- must kill the Binding Spear to free the affected player
	self:TargetMessage(372561, "yellow", args.destName)
	self:PlaySound(372561, "alert", nil, args.destName)
end

-- Overseer Lahar

function mod:BurningRoar(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:EruptiveCrush(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Qalashi Trainee

do
	local prev = 0
	function mod:MagmaFist(args)
		-- this is cast during RP fighting, filter unless in combat
		local unit = self:GetUnitIdByGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(args.spellId, "yellow")
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

-- Qalashi Bonetender

function mod:MendingClay(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Qalashi Irontorch

do
	local prev = 0
	function mod:ScorchingBreath(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:MoteOfCombustion(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:MoteOfCombustionApplied(args)
	if self:Dispeller("magic") and self:Friendly(args.destFlags) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Qalashi Lavabearer

do
	local prev = 0
	function mod:ThrowLava(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Irontorch Commander

function mod:ConflagrantBattery(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 23.1)
end

function mod:ScorchingFusillade(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 23.1)
end

function mod:IrontorchCommanderDeath(args)
	self:StopBar(372296) -- Conflagrant Battery
	self:StopBar(373084) -- Scorching Fusillade
end

-- Forgewrought Monstrosity

function mod:BlazingDetonation(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

-- Qalashi Plunderer

function mod:ExplosiveConcoction(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Qalashi Thaumaturge

function mod:MoltenCore(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Apex Blazewing

function mod:CandescentTempest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

-- Qalashi Lavamancer

function mod:MoltenArmy(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
