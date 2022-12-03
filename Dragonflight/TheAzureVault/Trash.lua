--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Azure Vault Trash", 2515)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	197300, -- TODO book of translocation npc IDs (which ones are right)
	194714,
	194602,
	194618,
	194712,
	194713,
	194715,
	195432,
	195434,
	199545,
	196115, -- Arcane Tender
	186741, -- Arcane Elemental
	187155  -- Rune Seal Keeper
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.book_of_translocation = "Book of Translocation"
	L.book_autotalk = "Autotalk"
	L.book_autotalk_desc = "Instantly proceed to the next area when talking to Books of Translocation."
	
	L.arcane_tender = "Arcane Tender"
	L.arcane_elemental = "Arcane Elemental"
	L.rune_seal_keeper = "Rune Seal Keeper"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Book of Translocation
		"book_autotalk",
		-- Arcane Tender
		375596, -- Erratic Growth
		-- Arcane Elemental
		386546, -- Waking Bane
		-- Rune Seal Keeper
		377488, -- Icy Bindings
	}, {
		["book_autotalk"] = L.book_of_translocation,
		[386546] = L.arcane_elemental,
		[377488] = L.rune_seal_keeper,
	}
end

function mod:OnBossEnable()
	-- Book of Translocation
	self:RegisterEvent("GOSSIP_SHOW")

	-- Arcane Tender
	self:Log("SPELL_CAST_START", "ErraticGrowth", 375596)

	-- Arcane Elemental
	self:Log("SPELL_CAST_START", "WakingBane", 386546)

	-- Rune Seal Keeper
	self:Log("SPELL_CAST_START", "IcyBindings", 377488)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Book of Translocation

function mod:GOSSIP_SHOW(event)
	if self:GetOption("book_autotalk") then
		if self:GetGossipID(56056) then
			-- after first boss, to ring
			self:SelectGossipID(56056)
		elseif self:GetGossipID(56247) then
			-- ring layer 1, to ring layer 2
			self:SelectGossipID(56247)
		elseif self:GetGossipID(56248) then
			-- ring layer 2 book, to next area
			self:SelectGossipID(56248)
		elseif self:GetGossipID(56250) then
			-- to third boss platform
			self:SelectGossipID(56250)
		elseif self:GetGossipID(56251) then
			-- to leave third boss platform
			self:SelectGossipID(56251)
		end
	end
end

-- Arcane Tender

function mod:ErraticGrowth(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Arcane Elemental

function mod:WakingBane(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Rune Seal Keeper

function mod:IcyBindings(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
