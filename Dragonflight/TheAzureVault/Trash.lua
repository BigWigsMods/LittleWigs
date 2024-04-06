--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Azure Vault Trash", 2515)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	194602, -- Book of Translocation (Proceed to Upper Chambers)
	194618, -- Book of Translocation (Return from Upper Chambers)
	194712, -- Book of Translocation (Proceed to Middle Chambers)
	195434, -- Book of Translocation (Return from Middle Chambers)
	194713, -- Book of Translocation (Proceed to Mausoleum of Legends)
	195432, -- Book of Translocation (Return from Mausoleum of Legends)
	194714, -- Book of Translocation (Proceed to Lower Chambers)
	199545, -- Book of Translocation (Return from Lower Chambers)
	194715, -- Book of Translocation (Proceed to Crystal Chambers)
	187159, -- Shrieking Whelp
	188100, -- Shrieking Whelp
	196102, -- Conjured Lasher
	191164, -- Arcane Tender
	196115, -- Arcane Tender
	186741, -- Arcane Elemental
	187154, -- Unstable Curator
	187155, -- Rune Seal Keeper
	196116, -- Crystal Fury
	196117, -- Crystal Thrasher
	186740, -- Arcane Construct
	191739, -- Scalebane Lieutenant
	187240  -- Drakonid Breaker
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.book_of_translocation = "Book of Translocation"
	L.custom_on_book_autotalk = "Autotalk"
	L.custom_on_book_autotalk_desc = "Instantly proceed to the next area when talking to Books of Translocation."
	L.custom_on_book_autotalk_icon = "ui_chat"

	L.shrieking_whelp = "Shrieking Whelp"
	L.conjured_lasher = "Conjured Lasher"
	L.arcane_tender = "Arcane Tender"
	L.arcane_elemental = "Arcane Elemental"
	L.unstable_curator = "Unstable Curator"
	L.rune_seal_keeper = "Rune Seal Keeper"
	L.crystal_fury = "Crystal Fury"
	L.crystal_thrasher = "Crystal Thrasher"
	L.arcane_construct = "Arcane Construct"
	L.scalebane_lieutenant = "Scalebane Lieutenant"
	L.drakonid_breaker = "Drakonid Breaker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Book of Translocation
		"custom_on_book_autotalk",
		-- Shrieking Whelp
		397726, -- Shriek
		-- Conjured Lasher
		387564, -- Mystic Vapors
		-- Arcane Tender
		{375596, "SAY"}, -- Erratic Growth
		375652, -- Wild Eruption
		375649, -- Infused Ground
		-- Arcane Elemental
		386546, -- Waking Bane
		-- Unstable Curator
		371358, -- Forbidden Knowledge
		-- Rune Seal Keeper
		377488, -- Icy Bindings
		-- Crystal Fury
		370764, -- Piercing Shards
		-- Crystal Thrasher
		370766, -- Crystalline Rupture
		-- Arcane Construct
		387067, -- Arcane Bash
		-- Scalebane Lieutenant
		391118, -- Spellfrost Breath
		-- Drakonid Breaker
		396991, -- Bestial Roar
		{391136, "SAY"}, -- Shoulder Slam
	}, {
		["custom_on_book_autotalk"] = L.book_of_translocation,
		[397726] = L.shrieking_whelp,
		[387564] = L.conjured_lasher,
		[375596] = L.arcane_tender,
		[386546] = L.arcane_elemental,
		[371358] = L.unstable_curator,
		[377488] = L.rune_seal_keeper,
		[370764] = L.crystal_fury,
		[370766] = L.crystal_thrasher,
		[387067] = L.arcane_construct,
		[391118] = L.scalebane_lieutenant,
		[396991] = L.drakonid_breaker,
	}
end

function mod:OnBossEnable()
	-- Book of Translocation
	self:RegisterEvent("GOSSIP_SHOW")

	-- Shrieking Whelp
	self:Log("SPELL_CAST_START", "Shriek", 370225, 397726) -- normal/heroic, mythic
	self:Log("SPELL_CAST_SUCCESS", "ShriekSuccess", 370225, 397726) -- normal/heroic, mythic

	-- Conjured Lasher
	self:Log("SPELL_CAST_START", "MysticVapors", 387564)

	-- Arcane Tender
	self:Log("SPELL_CAST_SUCCESS", "ErraticGrowth", 375596)
	self:Log("SPELL_AURA_APPLIED", "ErraticGrowthApplied", 375602)
	self:Log("SPELL_CAST_SUCCESS", "WildEruption", 375652)
	self:Log("SPELL_AURA_APPLIED", "InfusedGroundDamage", 375649)
	self:Log("SPELL_PERIODIC_DAMAGE", "InfusedGroundDamage", 375649)
	self:Log("SPELL_PERIODIC_MISSED", "InfusedGroundDamage", 375649)

	-- Arcane Elemental
	self:Log("SPELL_CAST_START", "WakingBane", 386546)

	-- Unstable Curator
	self:Log("SPELL_CAST_SUCCESS", "ForbiddenKnowledge", 371358)

	-- Rune Seal Keeper
	self:Log("SPELL_CAST_START", "IcyBindings", 377488)

	-- Crystal Fury
	self:Log("SPELL_CAST_START", "PiercingShards", 370764)

	-- Crystal Thrasher
	self:Log("SPELL_CAST_START", "CrystallineRupture", 370766)

	-- Arcane Construct
	self:Log("SPELL_CAST_START", "ArcaneBash", 387067)

	-- Scalebane Lieutenant
	self:Log("SPELL_CAST_START", "SpellfrostBreath", 391118)

	-- Drakonid Breaker
	self:Log("SPELL_CAST_START", "BestialRoar", 396991)
	self:Log("SPELL_CAST_START", "ShoulderSlam", 391136)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Book of Translocation

function mod:GOSSIP_SHOW(event)
	if self:GetOption("custom_on_book_autotalk") then
		if self:GetGossipID(56056) then
			-- Proceed to Upper Chambers
			self:SelectGossipID(56056)
		elseif self:GetGossipID(56247) then
			-- Proceed to Middle Chambers
			self:SelectGossipID(56247)
		elseif self:GetGossipID(56248) then
			-- Proceed to Mausoleum of Legends
			self:SelectGossipID(56248)
		elseif self:GetGossipID(56250) then
			-- Proceed to Lower Chambers
			self:SelectGossipID(56250)
		elseif self:GetGossipID(56251) then
			-- Proceed to Crystal Chambers
			self:SelectGossipID(56251)
		elseif self:GetGossipID(56378) then
			-- Return from Mausoleum of Legends
			self:SelectGossipID(56378)
		end
	end
end

-- Shrieking Whelp

do
	local prev = 0

	function mod:Shriek(args)
		-- no need to alert on Shriek if adds were already activated in the last 5 seconds
		if args.time - prev > 5 then
			self:Message(397726, "red", CL.casting:format(args.spellName))
			self:PlaySound(397726, "warning")
		end
	end

	function mod:ShriekSuccess(args)
		local t = args.time
		if t - prev > 8 then
			prev = t
			self:Message(397726, "cyan", CL.incoming:format(CL.adds))
			self:PlaySound(397726, "long")
		end
	end
end

-- Conjured Lasher

do
	local prev = 0
	function mod:MysticVapors(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Arcane Tender

function mod:ErraticGrowth(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:ErraticGrowthApplied(args)
	local onMe = self:Me(args.destGUID)
	if onMe or self:Dispeller("magic") then
		self:TargetMessage(375596, "orange", args.destName)
		self:PlaySound(375596, "alarm", nil, args.destName)
		if onMe then
			self:Say(375596, nil, nil, "Erratic Growth")
		end
	end
end

function mod:WildEruption(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:InfusedGroundDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Arcane Elemental

function mod:WakingBane(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Unstable Curator

function mod:ForbiddenKnowledge(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

-- Rune Seal Keeper

function mod:IcyBindings(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Crystal Fury

function mod:PiercingShards(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

-- Crystal Thrasher

function mod:CrystallineRupture(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Arcane Construct

function mod:ArcaneBash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Scalebane Lieutenant

function mod:SpellfrostBreath(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

-- Drakonid Breaker

function mod:BestialRoar(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(391136, "orange", name)
		self:PlaySound(391136, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(391136, nil, nil, "Shoulder Slam")
		end
	end

	function mod:ShoulderSlam(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end
