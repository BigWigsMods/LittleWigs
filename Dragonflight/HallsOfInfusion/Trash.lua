--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Infusion Trash", 2527)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	190348, -- Primalist Ravager
	190345, -- Primalist Geomancer
	190342, -- Containment Apparatus
	190340, -- Refti Defender
	197560, -- Limited Immortality Device
	190362, -- Dazzling Dragonfly
	190366, -- Curious Swoglet
	199037, -- Primalist Shocktrooper
	190368, -- Flamecaller Aymi
	190370, -- Squallbringer Cyraz
	197654, -- Infused Mushroom
	190371, -- Primalist Earthshaker
	190373, -- Primalist Galesinger
	190377, -- Primalist Icecaller
	190401, -- Gusting Proto-Dragon
	190403, -- Glacial Proto-Dragon
	190404, -- Subterranean Proto-Dragon
	190407, -- Aqua Rager
	190405  -- Infuser Sariya
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip options to get profession buffs."
	L.custom_on_autotalk_icon = "ui_chat"

	L.primalist_ravager = "Primalist Ravager"
	L.primalist_geomancer = "Primalist Geomancer"
	L.containment_apparatus = "Containment Apparatus"
	L.refti_defender = "Refti Defender"
	L.dazzling_dragonfly = "Dazzling Dragonfly"
	L.curious_swoglet = "Curious Swoglet"
	L.primalist_shocktrooper = "Primalist Shocktrooper"
	L.flamecaller_aymi = "Flamecaller Aymi"
	L.squallbringer_cyraz = "Squallbringer Cyraz"
	L.primalist_earthshaker = "Primalist Earthshaker"
	L.primalist_galesinger = "Primalist Galesinger"
	L.primalist_icecaller = "Primalist Icecaller"
	L.gusting_protodragon = "Gusting Proto-Dragon"
	L.glacial_protodragon = "Glacial Proto-Dragon"
	L.subterranean_protodragon = "Subterranean Proto-Dragon"
	L.aqua_rager = "Aqua Rager"
	L.infuser_sariya = "Infuser Sariya"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"custom_on_autotalk",
		391241, -- Limited Immortality
		391471, -- Cleansing Spores
		-- Primalist Geomancer
		374073, -- Seismic Slam
		-- Containment Apparatus
		374045, -- Expulse
		-- Refti Defender
		374339, -- Demoralizing Shout
		393432, -- Spear Flurry
		-- Dazzling Dragonfly
		374563, -- Dazzle
		-- Curious Swoglet
		{374389, "DISPEL"}, -- Gulp Swog Toxin
		-- Primalist Shocktrooper
		{395694, "DISPEL"}, -- Elemental Focus
		-- Flamecaller Aymi
		374724, -- Molten Subduction
		374741, -- Magma Crush
		374699, -- Cauterize
		-- Squallbringer Cyraz
		375079, -- Whirling Fury
		374823, -- Zephyr's Call
		-- Primalist Earthshaker
		375384, -- Rumbling Earth
		-- Primalist Galesinger
		437719, -- Thunderstrike
		-- Primalist Icecaller
		376171, -- Refreshing Tides
		-- Glacial Proto-Dragon
		375351, -- Oceanic Breath
		391634, -- Deep Chill
		-- Aqua Rager
		377341, -- Tidal Divergence
		-- Infuser Sariya
		377402, -- Aqueous Barrier
		390290, -- Flash Flood
	}, {
		["custom_on_autotalk"] = CL.general,
		[374073] = L.primalist_geomancer,
		[374045] = L.containment_apparatus,
		[374339] = L.refti_defender,
		[374563] = L.dazzling_dragonfly,
		[374389] = L.curious_swoglet,
		[395694] = L.primalist_shocktrooper,
		[374724] = L.flamecaller_aymi,
		[375079] = L.squallbringer_cyraz,
		[375384] = L.primalist_earthshaker,
		[437719] = L.primalist_galesinger,
		[376171] = L.primalist_icecaller,
		[375351] = L.glacial_protodragon,
		[377341] = L.aqua_rager,
		[377402] = L.infuser_sariya,
	}
end

function mod:OnBossEnable()
	-- General
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "LimitedImmortalityApplied", 391241)
	self:Log("SPELL_AURA_REMOVED", "LimitedImmortalityRemoved", 391241)
	self:Log("SPELL_AURA_APPLIED", "CleansingSporesApplied", 391471)

	-- Primalist Geomancer
	self:Log("SPELL_CAST_SUCCESS", "SeismicSlam", 374073)

	-- Containment Apparatus
	self:Log("SPELL_CAST_START", "Expulse", 374045)

	-- Refti Defender
	self:Log("SPELL_CAST_START", "DemoralizingShout", 374339)
	self:Log("SPELL_CAST_START", "SpearFlurry", 393432)

	-- Dazzling Dragonfly
	self:Log("SPELL_CAST_START", "Dazzle", 374563)

	-- Curious Swoglet
	self:Log("SPELL_AURA_APPLIED_DOSE", "GulpSwogToxinApplied", 374389)

	-- Primalist Shocktrooper
	self:Log("SPELL_CAST_START", "ElementalFocus", 395694)
	self:Log("SPELL_AURA_APPLIED", "ElementalFocusApplied", 395694)

	-- Flamecaller Aymi
	self:Log("SPELL_AURA_APPLIED", "MoltenSubductionApplied", 374724)
	self:Log("SPELL_CAST_SUCCESS", "MagmaCrush", 374735)
	self:Log("SPELL_CAST_START", "Cauterize", 374699)
	self:Death("FlamecallerAymiDeath", 190368)

	-- Squallbringer Cyraz
	self:Log("SPELL_CAST_START", "WhirlingFury", 375079)
	self:Log("SPELL_CAST_START", "ZephyrsCall", 374823)
	self:Death("SquallbringerCyrazDeath", 190370)

	-- Primalist Earthshaker
	self:Log("SPELL_CAST_SUCCESS", "RumblingEarth", 408388)

	-- Primalist Galesinger
	self:Log("SPELL_CAST_START", "Thunderstrike", 437719)

	-- Primalist Icecaller
	self:Log("SPELL_CAST_START", "RefreshingTides", 376171)

	-- Glacial Proto-Dragon
	self:Log("SPELL_CAST_START", "OceanicBreath", 375351)
	self:Log("SPELL_CAST_START", "DeepChill", 391634)

	-- Aqua Rager
	self:Log("SPELL_CAST_START", "TidalDivergence", 377341)

	-- Infuser Sariya
	self:Log("SPELL_CAST_START", "AqueousBarrier", 377402)
	self:Log("SPELL_AURA_APPLIED", "AqueousBarrierApplied", 377402)
	self:Log("SPELL_CAST_START", "FlashFlood", 390290)
	self:Death("InfuserSariyaDeath", 190405)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		if self:GetGossipID(107192) then
			-- Limited Immortality Device (gives Limited Immortality buff, prevents next death)
			-- requires 25 skill in Dragon Isles Engineering
			self:SelectGossipID(107192)
		elseif self:GetGossipID(107206) then
			-- Infused Mushroom (gives Cleansing Spores buff, auto-poison/disease dispel)
			-- requires 25 skill in Dragon Isles Herbalism
			self:SelectGossipID(107206)
		end
	end
end

function mod:LimitedImmortalityApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:LimitedImmortalityRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "cyan", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:CleansingSporesApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Primalist Geomancer

do
	local prev = 0
	function mod:SeismicSlam(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:NameplateCDBar(args.spellId, 17.0, args.sourceGUID)
	end
end

-- Containment Apparatus

do
	local prev = 0
	function mod:Expulse(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Refti Defender

do
	local prev = 0
	function mod:DemoralizingShout(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		--self:NameplateCDBar(args.spellId, 30.3, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:SpearFlurry(args)
		local t = args.time
		if t - prev > (self:Tank() and 1 or 2) then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:NameplateCDBar(args.spellId, 18.2, args.sourceGUID)
	end
end

-- Dazzling Dragonfly

do
	local prev = 0
	function mod:Dazzle(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Curious Swoglet

do
	local prev = 0
	function mod:GulpSwogToxinApplied(args)
		if self:MobId(args.sourceGUID) == 190366 then -- only handle trash version
			local amount = args.amount
			if amount >= 6 and (self:Dispeller("poison", nil, args.spellId) or self:Me(args.destGUID)) then
				local t = args.time
				-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
				-- but always display the 9 stack warning for each player since 10 stacks kills instantly.
				if amount == 9 or t - prev > 1 then
					prev = t
					-- insta-kill at 10 stacks
					self:StackMessage(args.spellId, "red", args.destName, amount, 8)
					if amount < 8 then
						self:PlaySound(args.spellId, "alert", nil, args.destName)
					else
						self:PlaySound(args.spellId, "warning", nil, args.destName)
					end
				end
			end
		end
	end
end

-- Primalist Shocktrooper

function mod:ElementalFocus(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:ElementalFocusApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Friendly(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Flamecaller Aymi

function mod:MoltenSubductionApplied(args)
	-- either movement dispel the target, target immunes/moves out, or everyone stacks on target (meteor)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:CDBar(args.spellId, 19.4)
end

function mod:MagmaCrush(args)
	self:Message(374741, "orange")
	self:PlaySound(374741, "alarm")
end

function mod:Cauterize(args)
	-- this only starts being cast when one of the mini-bosses gets low (~40%)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 18.2)
end

function mod:FlamecallerAymiDeath(args)
	self:StopBar(374724) -- Molten Subduction
	self:StopBar(374699) -- Cauterize
end

-- Squallbringer Cyraz

function mod:WhirlingFury(args)
	-- this is cast immediately after Gale Force Charge
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 16.9)
end

function mod:ZephyrsCall(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 24.2)
end

function mod:SquallbringerCyrazDeath(args)
	self:StopBar(375079) -- Whirling Fury
	self:StopBar(374823) -- Zephyr's Call
end

-- Primalist Earthshaker

do
	local prev = 0
	function mod:RumblingEarth(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(375384, "orange")
			self:PlaySound(375384, "alarm")
		end
	end
end

-- Primalist Galesinger

function mod:Thunderstrike(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 23.1, args.sourceGUID)
end

-- Primalist Icecaller

function mod:RefreshingTides(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 30.3, args.sourceGUID)
end

-- Glacial Proto-Dragon

function mod:OceanicBreath(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 18.2, args.sourceGUID)
end

function mod:DeepChill(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	--self:NameplateCDBar(args.spellId, 32.8, args.sourceGUID)
end

-- Aqua Rager

do
	local prev = 0
	function mod:TidalDivergence(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Infuser Sariya

function mod:AqueousBarrier(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 19.4)
end

function mod:AqueousBarrierApplied(args)
	if self:Dispeller("magic", true) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:FlashFlood(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.1)
end

function mod:InfuserSariyaDeath(args)
	self:StopBar(377402) -- Aqueous Barrier
	self:StopBar(390290) -- Flash Flood
end
