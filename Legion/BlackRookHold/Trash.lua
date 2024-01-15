--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Black Rook Hold Trash", 1501)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	98366, -- Ghostly Retainer
	98368, -- Ghostly Protector
	98370, -- Ghostly Councilor
	98521, -- Lord Etheldrin Ravencrest
	98538, -- Lady Velandras Ravencrest
	98677, -- Rook Spiderling
	98243, -- Soul-Torn Champion
	98691, -- Risen Scout
	98275, -- Risen Archer
	98280, -- Risen Arcanist
	98706, -- Commander Shemdah'sohn
	98792, -- Wyrmtongue Scavenger
	98813, -- Bloodscent Felhound
	102788, -- Felspite Dominator
	102094, -- Risen Swordsman
	102095 -- Risen Lancer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ghostly_retainer = "Ghostly Retainer"
	L.ghostly_protector = "Ghostly Protector"
	L.ghostly_councilor = "Ghostly Councilor"
	L.lord_etheldrin_ravencrest = "Lord Etheldrin Ravencrest"
	L.lady_velandras_ravencrest = "Lady Velandras Ravencrest"
	L.rook_spiderling = "Rook Spiderling"
	L.soultorn_champion = "Soul-Torn Champion"
	L.risen_scout = "Risen Scout"
	L.risen_archer = "Risen Archer"
	L.risen_arcanist = "Risen Arcanist"
	L.wyrmtongue_scavenger = "Wyrmtongue Scavenger"
	L.bloodscent_felhound = "Bloodscent Felhound"
	L.felspite_dominator = "Felspite Dominator"
	L.risen_swordsman = "Risen Swordsman"
	L.risen_lancer = "Risen Lancer"

	L.door_open = CL.door_open
	L.door_open_desc = "Show a bar indicating when the door is opened to the Hidden Passageway."
	L.door_open_icon = "achievement_dungeon_blackrookhold"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- RP Timers
		"door_open",
		-- Ghostly Retainer
		{200084, "DISPEL"}, -- Soul Blade
		-- Ghostly Protector
		200105, -- Sacrifice Soul
		-- Ghostly Councilor
		225573, -- Dark Mending
		-- Lord Etheldrin Ravencrest
		{194966, "SAY"}, -- Soul Echoes
		-- Lady Velandras Ravencrest
		196916, -- Glaive Toss
		-- Rook Spiderling
		{225908, "DISPEL"}, -- Soul Venom
		-- Soul-Torn Champion
		200261, -- Bonebreaking Strike
		-- Risen Scout
		200291, -- Knife Dance
		-- Risen Archer
		200343, -- Arrow Barrage
		-- Risen Arcanist
		200248, -- Arcane Blitz
		-- Wyrmtongue Scavenger
		200784, -- "Drink" Ancient Potion
		200913, -- Indigestion
		-- Bloodscent Felhound
		204896, -- Drain Life
		-- Felspite Dominator
		203163, -- Sic Bats!
		227913, -- Felfrenzy
		-- Risen Swordsman
		{214003, "TANK"}, -- Coup de Grace
		-- Risen Lancer
		214001, -- Raven's Dive
	}, {
		[200084] = L.ghostly_retainer,
		[200105] = L.ghostly_protector,
		[225573] = L.ghostly_councilor,
		[194966] = L.lord_etheldrin_ravencrest,
		[196916] = L.lady_velandras_ravencrest,
		[225908] = L.rook_spiderling,
		[200261] = L.soultorn_champion,
		[200291] = L.risen_scout,
		[200343] = L.risen_archer,
		[200248] = L.risen_arcanist,
		[200784] = L.wyrmtongue_scavenger,
		[204896] = L.bloodscent_felhound,
		[203163] = L.felspite_dominator,
		[214003] = L.risen_swordsman,
		[214001] = L.risen_lancer,
	}
end

function mod:OnBossEnable()
	-- Ghostly Retainer
	self:Log("SPELL_CAST_START", "SoulBlade", 200084)
	self:Log("SPELL_AURA_APPLIED", "SoulBladeApplied", 200084)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SoulBladeApplied", 200084)

	-- Ghostly Protector
	self:Log("SPELL_CAST_SUCCESS", "SacrificeSoul", 200105)

	-- Ghostly Councilor
	self:Log("SPELL_CAST_START", "DarkMending", 225573)

	-- Lord Etheldrin Ravencrest
	self:Log("SPELL_AURA_APPLIED", "SoulEchoesApplied", 194966)

	-- Lady Velandras Ravencrest
	self:Log("SPELL_CAST_START", "GlaiveToss", 196916)

	-- Rook Spiderling
	self:Log("SPELL_AURA_APPLIED_DOSE", "SoulVenomApplied", 225909)

	-- Soul-Torn Champion
	self:Log("SPELL_CAST_START", "BonebreakingStrike", 200261)

	-- Risen Scout
	self:Log("SPELL_CAST_START", "KnifeDance", 200291)

	-- Risen Archer
	self:Log("SPELL_CAST_SUCCESS", "ArrowBarrage", 200343)

	-- Risen Arcanist
	self:Log("SPELL_CAST_START", "ArcaneBlitz", 200248)
	self:Log("SPELL_AURA_APPLIED", "ArcaneBlitzApplied", 200248)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ArcaneBlitzApplied", 200248)
	self:Log("SPELL_AURA_REMOVED", "ArcaneBlitzRemoved", 200248)

	-- Wyrmtongue Scavenger
	self:Log("SPELL_CAST_START", "DrinkAncientPotion", 200784)
	-- TODO other potion effects? (Hyperactive, Frenzy Potion)
	self:Log("SPELL_CAST_START", "Indigestion", 200913)

	-- Bloodscent Felhound
	self:Log("SPELL_CAST_SUCCESS", "DrainLife", 204896)

	-- Felspite Dominator
	self:Log("SPELL_AURA_APPLIED", "SicBats", 203163)
	self:Log("SPELL_CAST_START", "Felfrenzy", 227913)

	-- Risen Swordsman
	self:Log("SPELL_CAST_START", "CoupDeGrace", 214003)

	-- Risen Lancer
	self:Log("SPELL_CAST_START", "RavensDive", 214001)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- RP Timers

-- triggered from Amalgam of Souls OnWin
function mod:AmalgamOfSoulsDefeated()
	self:Bar("door_open", 35, L.door_open, L.door_open_icon)
end

-- Ghostly Retainer

do
	local prev = 0
	function mod:SoulBlade(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:SoulBladeApplied(args)
		if not self:Player(args.destFlags) then -- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
			return
		end
		local t = args.time
		if t - prev > 3 and (self:Dispeller("magic", nil, args.spellId) or self:Me(args.destGUID)) then
			prev = t
			self:StackMessage(args.spellId, "orange", args.destName, args.amount, 2)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

-- Ghostly Protector

function mod:SacrificeSoul(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

-- Ghostly Councilor

function mod:DarkMending(args)
	-- non-Mythic+ only
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Lord Etheldrin Ravencrest

function mod:SoulEchoesApplied(args)
	if self:MobId(args.sourceGUID) ~= 98521 then -- Lord Etheldrin Ravencrest
		-- this is also cast by the first boss
		return
	end
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Soul Echoes")
	end
end

-- Lady Velandras Ravencrest

function mod:GlaiveToss(args)
	-- TODO possible to get target?
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Rook Spiderling

do
	local prev = 0
	function mod:SoulVenomApplied(args)
		local amount = args.amount
		local t = args.time
		-- stacks very quickly on the tank
		if t - prev > 3 and amount % 5 == 0 and (self:Me(args.destGUID) or self:Dispeller("magic", nil, 225908)) then
			prev = t
			self:StackMessage(225908, "yellow", args.destName, amount, 10)
			if amount >= 15 then
				self:PlaySound(225908, "warning", nil, args.destName)
			else
				self:PlaySound(225908, "alert", nil, args.destName)
			end
		end
	end
end

-- Soul-Torn Champion

do
	local prev = 0
	function mod:BonebreakingStrike(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Risen Scout

do
	local prev = 0
	function mod:KnifeDance(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Risen Archer

do
	local prev = 0
	function mod:ArrowBarrage(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Risen Arcanist

do
	local blitzTracker = {}

	function mod:ArcaneBlitz(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		local amount = blitzTracker[args.sourceGUID] or 0
		local _, interruptReady = self:Interrupter()
		if interruptReady or (self:Dispeller("magic") and amount >= 2) then
			if amount >= 1 then
				self:Message(args.spellId, "yellow", CL.casting:format(CL.count:format(args.spellName, amount)))
			else
				self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			end
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:ArcaneBlitzApplied(args)
		blitzTracker[args.destGUID] = args.amount or 1
	end

	function mod:ArcaneBlitzRemoved(args)
		blitzTracker[args.destGUID] = nil
	end
end

-- Wyrmtongue Scavenger

do
	local prev = 0
	function mod:DrinkAncientPotion(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:Indigestion(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Bloodscent Felhound

function mod:DrainLife(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Felspite Dominator

do
	local prev = 0
	function mod:SicBats(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:TargetMessage(args.spellId, "orange", args.destName)
			if self:Me(args.destGUID) then
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			else
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

function mod:Felfrenzy(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Risen Swordsman

do
	local prev = 0
	function mod:CoupDeGrace(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Risen Lancer

do
	local prev = 0
	function mod:RavensDive(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
