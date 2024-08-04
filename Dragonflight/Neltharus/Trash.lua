--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharus Trash", 2519)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	189342, -- Burning Chain
	193293, -- Qalashi Warden
	189227, -- Qalashi Hunter
	189669, -- Binding Spear
	189235, -- Overseer Lahar
	189266, -- Qalashi Trainee
	189265, -- Qalashi Bonetender
	189219, -- Qalashi Goulash
	189464, -- Qalashi Irontorch
	189467, -- Qalashi Bonesplitter
	189472, -- Qalashi Lavabearer
	189466, -- Irontorch Commander
	189471, -- Qalashi Blacksmith
	194816, -- Forgewrought Monstrosity
	189786, -- Blazing Aegis
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
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip options to get profession buffs."
	L.custom_on_autotalk_icon = "ui_chat"

	L.burning_chain = "Burning Chain"
	L.qalashi_warden = "Qalashi Warden"
	L.qalashi_hunter = "Qalashi Hunter"
	L.overseer_lahar = "Overseer Lahar"
	L.qalashi_trainee = "Qalashi Trainee"
	L.qalashi_bonetender = "Qalashi Bonetender"
	L.qalashi_irontorch = "Qalashi Irontorch"
	L.qalashi_bonesplitter = "Qalashi Bonesplitter"
	L.qalashi_lavabearer = "Qalashi Lavabearer"
	L.irontorch_commander = "Irontorch Commander"
	L.qalashi_blacksmith = "Qalashi Blacksmith"
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
		-- General
		"custom_on_autotalk",
		-- Burning Chain
		374451, -- Burning Chain
		-- Qalashi Warden
		382708, -- Volcanic Guard
		{384597, "TANK_HEALER"}, -- Blazing Slash
		-- Qalashi Hunter
		372561, -- Binding Spear
		-- Overseer Lahar
		395427, -- Burning Roar
		376186, -- Eruptive Crush
		{372461, "DISPEL"}, -- Imbued Magma
		-- Qalashi Trainee
		372311, -- Magma Fist
		-- Qalashi Bonetender
		372223, -- Mending Clay
		-- Qalashi Irontorch
		372201, -- Scorching Breath
		{384161, "DISPEL"}, -- Mote of Combustion
		-- Qalashi Bonesplitter
		372225, -- Dragonbone Axe
		-- Qalashi Lavabearer
		379406, -- Throw Lava
		-- Irontorch Commander
		372296, -- Conflagrant Battery
		373084, -- Scorching Fusillade
		-- Qalashi Blacksmith
		{372971, "TANK_HEALER"}, -- Reverberating Slam
		-- Forgewrought Monstrosity
		376200, -- Blazing Detonation
		-- Qalashi Plunderer
		378827, -- Explosive Concoction
		-- Qalashi Thaumaturge
		378282, -- Molten Core
		378818, -- Magma Conflagration
		-- Apex Blazewing
		381663, -- Candescent Tempest
		-- Qalashi Lavamancer
		382791, -- Molten Barrier
		383651, -- Molten Army
	}, {
		["custom_on_autotalk"] = CL.general,
		[374451] = L.burning_chain,
		[382708] = L.qalashi_warden,
		[372561] = L.qalashi_hunter,
		[395427] = L.overseer_lahar,
		[372311] = L.qalashi_trainee,
		[372223] = L.qalashi_bonetender,
		[372201] = L.qalashi_irontorch,
		[372225] = L.qalashi_bonesplitter,
		[379406] = L.qalashi_lavabearer,
		[372296] = L.irontorch_commander,
		[372971] = L.qalashi_blacksmith,
		[376200] = L.forgewrought_monstrosity,
		[378827] = L.qalashi_plunderer,
		[378282] = L.qalashi_thaumaturge,
		[381663] = L.apex_blazewing,
		[382791] = L.qalashi_lavamancer,
	}
end

function mod:OnBossEnable()
	-- General
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_CAST_START", "ThrowExperimentalConcoction", 376169)

	-- Burning Chain
	self:Log("SPELL_CAST_SUCCESS", "BurningChainPickedUp", 374451)

	-- Qalashi Warden
	self:Log("SPELL_CAST_START", "VolcanicGuard", 382708)
	self:Log("SPELL_CAST_START", "BlazingSlash", 384597)

	-- Qalashi Hunter
	self:Log("SPELL_CAST_START", "BindingSpear", 372561)
	self:Log("SPELL_AURA_APPLIED", "BindingSpearApplied", 373540)

	-- Overseer Lahar
	self:Log("SPELL_CAST_START", "BurningRoar", 395427)
	self:Log("SPELL_CAST_START", "EruptiveCrush", 376186)
	self:Log("SPELL_AURA_APPLIED", "ImbuedMagmaApplied", 372461)
	self:Death("OverseerLaharDeath", 189235)

	-- Qalashi Trainee
	self:Log("SPELL_CAST_START", "MagmaFist", 372311)

	-- Qalashi Bonetender
	self:Log("SPELL_CAST_START", "MendingClay", 372223)

	-- Qalashi Irontorch
	self:Log("SPELL_CAST_START", "ScorchingBreath", 372201)
	self:Log("SPELL_CAST_START", "MoteOfCombustion", 384161)
	self:Log("SPELL_AURA_APPLIED", "MoteOfCombustionApplied", 384161)

	-- Qalashi Bonesplitter
	self:Log("SPELL_CAST_START", "DragonboneAxe", 372225)

	-- Qalashi Lavabearer
	self:Log("SPELL_CAST_START", "ThrowLava", 379406)

	-- Irontorch Commander
	self:Log("SPELL_CAST_SUCCESS", "ConflagrantBattery", 372296)
	self:Log("SPELL_CAST_START", "ScorchingFusillade", 373084)
	self:Death("IrontorchCommanderDeath", 189466)

	-- Qalashi Blacksmith
	self:Log("SPELL_CAST_START", "ReverberatingSlam", 372971)

	-- Forgewrought Monstrosity
	self:Log("SPELL_CAST_START", "BlazingDetonation", 376200)

	-- Qalashi Plunderer
	self:Log("SPELL_CAST_START", "ExplosiveConcoction", 378827)

	-- Qalashi Thaumaturge
	self:Log("SPELL_CAST_START", "MoltenCore", 378282)
	self:Log("SPELL_CAST_START", "MagmaConflagration", 378818)

	-- Apex Blazewing
	self:Log("SPELL_AURA_APPLIED", "CandescentTempest", 381663)

	-- Qalashi Lavamancer
	self:Log("SPELL_CAST_START", "MoltenBarrier", 382791)
	self:Log("SPELL_AURA_REMOVED", "MoltenBarrierRemoved", 382791)
	self:Log("SPELL_CAST_START", "MoltenArmy", 383651)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		if self:GetGossipID(55886) then
			-- Qalashi Goulash (gives Qalashi Goulash buff, three-use extra action button)
			-- give entire party an ability to increase movement speed until next combat
			-- requires 25 skill in Dragon Isles Cooking
			self:SelectGossipID(55886)
		elseif self:GetGossipID(107310) then
			-- Blazing Aegis (gives Blazing Aegis buff, one-use extra action button)
			-- gives the Blacksmith an ability which does damage
			-- requires 25 skill in Dragon Isles Blacksmithing
			self:SelectGossipID(107310)
		end
	end
end

function mod:ThrowExperimentalConcoction(args)
	-- Magmatusk warmup
	local magmatuskModule = BigWigs:GetBossModule("Magmatusk", true)
	if magmatuskModule then
		magmatuskModule:Enable()
		magmatuskModule:Warmup()
	end
end

-- Burning Chain

function mod:BurningChainPickedUp(args)
	self:TargetMessage(args.spellId, "green", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

-- Qalashi Warden

function mod:VolcanicGuard(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 25.5, args.sourceGUID)
end

do
	local prev = 0
	function mod:BlazingSlash(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
		-- technically outrangeable if you're fast and it won't go on CD unless it hits, so
		-- if this is uncommented it should probably be moved to SUCCESS.
		--self:Nameplate(args.spellId, 13.4, args.sourceGUID)
	end
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

do
	local timer

	function mod:BurningRoar(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
		self:CDBar(args.spellId, 20.6)
		timer = self:ScheduleTimer("OverseerLaharDeath", 30)
	end

	function mod:EruptiveCrush(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 20.6)
		timer = self:ScheduleTimer("OverseerLaharDeath", 30)
	end

	function mod:ImbuedMagmaApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end

	function mod:OverseerLaharDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(395427) -- Burning Roar
		self:StopBar(376186) -- Eruptive Crush
	end
end

-- Qalashi Trainee

do
	local prev = 0
	function mod:MagmaFist(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		-- this is cast during RP fighting, filter unless in combat
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
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
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Qalashi Irontorch

do
	local prev = 0
	function mod:ScorchingBreath(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:MoteOfCombustion(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:MoteOfCombustionApplied(args)
	if self:Me(args.destGUID) or (self:Dispeller("magic", nil, args.spellId) and self:Friendly(args.destFlags)) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Qalashi Bonesplitter

do
	local prev = 0
	function mod:DragonboneAxe(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
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


do
	local timer

	function mod:ConflagrantBattery(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "long")
		self:CDBar(args.spellId, 23.1)
		timer = self:ScheduleTimer("IrontorchCommanderDeath", 30)
	end

	function mod:ScorchingFusillade(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 23.1)
		timer = self:ScheduleTimer("IrontorchCommanderDeath", 30)
	end

	function mod:IrontorchCommanderDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(372296) -- Conflagrant Battery
		self:StopBar(373084) -- Scorching Fusillade
	end
end

-- Qalashi Blacksmith

function mod:ReverberatingSlam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	-- technically outrangeable if you're fast and it won't go on CD unless it hits, so
	-- if this is uncommented it should probably be moved to SUCCESS.
	--self:Nameplate(args.spellId, 17.0, args.sourceGUID)
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
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:MagmaConflagration(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Apex Blazewing

function mod:CandescentTempest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

-- Qalashi Lavamancer

function mod:MoltenBarrier(args)
	-- cast just once at 50% health, must burn shield to interrupt Molten Army
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "info")
end

function mod:MoltenBarrierRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:MoltenArmy(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
