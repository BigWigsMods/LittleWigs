--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharus Trash", 2519)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	193293, -- Qalashi Warden
	189235, -- Overseer Lahar
	189265, -- Qalashi Bonetender
	189464, -- Qalashi Irontorch
	189466, -- Irontorch Commander
	194816, -- Forgewrought Monstrosity
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
	L.overseer_lahar = "Overseer Lahar"
	L.qalashi_bonetender = "Qalashi Bonetender"
	L.qalashi_irontorch = "Qalashi Irontorch"
	L.irontorch_commander = "Irontorch Commander"
	L.forgewrought_monstrosity = "Forgewrought Monstrosity"
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
		-- Overseer Lahar
		395427, -- Burning Roar
		376186, -- Eruptive Crush
		-- Qalashi Bonetender
		372223, -- Mending Clay
		-- Qalashi Irontorch
		372201, -- Scorching Breath
		-- Irontorch Commander
		372296, -- Conflagrant Battery
		373084, -- Scorching Fusillade
		-- Forgewrought Monstrosity
		376200, -- Blazing Detonation
		-- Qalashi Thaumaturge
		378282, -- Molten Core
		-- Apex Blazewing
		381663, -- Candescent Tempest
		-- Qalashi Lavamancer
		383651, -- Molten Army
	}, {
		[382708] = L.qalashi_warden,
		[395427] = L.overseer_lahar,
		[372223] = L.qalashi_bonetender,
		[372201] = L.qalashi_irontorch,
		[372296] = L.irontorch_commander,
		[376200] = L.forgewrought_monstrosity,
		[378282] = L.qalashi_thaumaturge,
		[381663] = L.apex_blazewing,
		[383651] = L.qalashi_lavamancer,
	}
end

function mod:OnBossEnable()
	-- Qalashi Warden
	self:Log("SPELL_CAST_START", "VolcanicGuard", 382708)

	-- Overseer Lahar
	self:Log("SPELL_CAST_START", "BurningRoar", 395427)
	self:Log("SPELL_CAST_START", "EruptiveCrush", 376186)
	
	-- Qalashi Bonetender
	self:Log("SPELL_CAST_START", "MendingClay", 372223)

	-- Qalashi Irontorch
	self:Log("SPELL_CAST_START", "ScorchingBreath", 372201)

	-- Irontorch Commander
	self:Log("SPELL_CAST_SUCCESS", "ConflagrantBattery", 372296)
	self:Log("SPELL_CAST_START", "ScorchingFusillade", 373084)
	
	-- Forgewrought Monstrosity
	self:Log("SPELL_CAST_START", "BlazingDetonation", 376200)
	
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

-- Qalashi Warden

function mod:VolcanicGuard(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
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

-- Irontorch Commander

function mod:ConflagrantBattery(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:ScorchingFusillade(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Forgewrought Monstrosity

function mod:BlazingDetonation(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
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
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
