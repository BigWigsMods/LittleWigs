--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warlord Sargha", 2519, 2501)
if not mod then return end
mod:RegisterEnableMob(189901) -- Warlord Sargha
mod:SetEncounterID(2611)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local magmaShieldCount = 0
local burningEmberRemaining = 1
local theDragonsKilnRemaining = 2
local moltenGoldRemaining = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.magical_implements = -25983 -- Magical Implements
	L.magical_implements_desc = "The surrounding treasure piles contain magic items that can help to deplete Magma Shield."
	L.magical_implements_icon = "inv_wand_06"
	L.magma_shield = "Magma Shield - Get items from gold piles"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Warlord Sargha
		376780, -- Magma Shield
		377014, -- Backdraft
		377477, -- Burning Ember
		377204, -- The Dragon's Kiln
		377018, -- Molten Gold
		-- Raging Ember
		377522, -- Burning Pursuit
		-- Magical Implements
		"magical_implements",
		{391762, "DISPEL"}, -- Curse of the Dragon Hoard
	}, {
		[376780] = self.displayName, -- Warlord Sargha
		[377522] = -25270, -- Raging Ember
		["magical_implements"] = -25983, -- Magical Implements
	}, {
		[377522] = CL.fixate, -- Burning Pursuit (Fixate)
	}
end

function mod:OnBossEnable()
	-- Warlord Sargha
	self:Log("SPELL_CAST_START", "MagmaShield", 376780)
	self:Log("SPELL_AURA_APPLIED", "MagmaShieldApplied", 376780)
	self:Log("SPELL_AURA_REMOVED", "MagmaShieldRemoved", 376780)
	self:Log("SPELL_CAST_START", "BurningEmber", 377473)
	self:Log("SPELL_CAST_START", "TheDragonsKiln", 377204)
	self:Log("SPELL_CAST_START", "MoltenGold", 377017)

	-- Raging Ember
	self:Log("SPELL_AURA_APPLIED", "BurningPursuit", 377522)
	
	-- Magical Implements
	-- 376762 Wand of Negation
	-- 384595 Anti-Magic Bomb
	-- 392164 Azure Stone of Might
	-- 392170 Rose of the Vale
	-- 392258 Seismic Boots
	self:Log("SPELL_AURA_APPLIED", "MagicalImplementsPickedUp", 376762, 384595, 392164, 392170, 392258)
	self:Log("SPELL_AURA_APPLIED", "CurseOfTheDragonHoardApplied", 391762)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CurseOfTheDragonHoardApplied", 391762)
end

function mod:OnEngage()
	magmaShieldCount = 0
	burningEmberRemaining = 1
	theDragonsKilnRemaining = 2
	moltenGoldRemaining = 1
	self:Bar(377204, 7.1) -- The Dragon's Kiln
	self:Bar(377018, 14.2) -- Molten Gold
	self:Bar(377477, 21.5) -- Burning Ember
	-- cast at 100 energy: 30s energy gain + 2.5s cast + ~4s delay
	self:Bar(376780, 37.7, CL.count:format(self:SpellName(376780), 1)) -- Magma Shield (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MagmaShield(args)
	magmaShieldCount = magmaShieldCount + 1
	self:StopBar(377477) -- Burning Ember
	self:StopBar(377204) -- The Dragon's Kiln
	self:StopBar(377018) -- Molten Gold
end

do
	local magmaShieldStart = 0

	function mod:MagmaShieldApplied(args)
		magmaShieldStart = args.time
		self:StopBar(CL.count:format(args.spellName, magmaShieldCount)) -- Magma Shield (n)
		self:Message(args.spellId, "orange", L.magma_shield)
		self:PlaySound(args.spellId, "long")
	end

	function mod:MagmaShieldRemoved(args)
		local duration = args.time - magmaShieldStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, duration))
		self:PlaySound(args.spellId, "info")

		-- cast at 100 energy: 30s energy gain + 2.5s cast time + ~.1s delay
		self:Bar(args.spellId, 32.6, CL.count:format(args.spellName, magmaShieldCount + 1))

		-- timers are based off the shield being removed
		if args.amount == 0 then
			burningEmberRemaining = 1
			theDragonsKilnRemaining = 1
			moltenGoldRemaining = 1
			-- boss is stunned for 10s
			self:Bar(377014, 10, CL.onboss:format(self:SpellName(377014))) -- Backdraft
			self:Bar(377018, 10.0) -- Molten Gold
			self:Bar(377477, 15.3) -- Burning Ember
			self:Bar(377204, 20.0) -- The Dragon's Kiln
		else
			-- or shield just expires and boss is not stunned
			burningEmberRemaining = 1
			theDragonsKilnRemaining = 2
			moltenGoldRemaining = 2
			self:CDBar(377477, 13.3) -- Burning Ember
		end
	end
end

function mod:BurningEmber(args)
	burningEmberRemaining = burningEmberRemaining - 1
	self:Message(377477, "yellow")
	self:PlaySound(377477, "alert")
end

function mod:TheDragonsKiln(args)
	theDragonsKilnRemaining = theDragonsKilnRemaining - 1
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	if theDragonsKilnRemaining > 0 then
		self:CDBar(args.spellId, magmaShieldCount == 0 and 21.5 or 25.5)
	else
		self:StopBar(args.spellId)
	end
	-- soonest ability can be is 6.1
	if moltenGoldRemaining > 0 and self:BarTimeLeft(377018) < 6.1 then -- Molten Gold
		self:CDBar(377018, {6.1, 26.7})
	end
	if burningEmberRemaining > 0 and self:BarTimeLeft(377477) < 6.1 then -- Burning Ember
		self:CDBar(377477, {6.1, 13.3})
	end
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(377018, "orange", name)
			self:PlaySound(377018, "alert", nil, name)
		end
	end

	function mod:MoltenGold(args)
		moltenGoldRemaining = moltenGoldRemaining - 1
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		if moltenGoldRemaining > 0 then
			self:CDBar(377018, 26.7)
		else
			self:StopBar(377018)
		end
		-- soonest ability can be is 4.7
		if theDragonsKilnRemaining > 0 and self:BarTimeLeft(377204) < 4.7 then -- The Dragon's Kiln
			self:CDBar(377204, {4.7, 25.5})
		end
		if burningEmberRemaining > 0 and self:BarTimeLeft(377477) < 4.7 then -- Burning Ember
			self:CDBar(377477, {4.7, 13.3})
		end
	end
end

-- Raging Ember

function mod:BurningPursuit(args)
	self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
end

-- Magical Implements

function mod:MagicalImplementsPickedUp(args)
	if self:Me(args.destGUID) then
		self:TargetMessage("magical_implements", "green", args.destName, args.spellId, args.spellId)
		self:PlaySound("magical_implements", "info", nil, args.destName)
	end
end

function mod:CurseOfTheDragonHoardApplied(args)
	local stacks = args.amount or 1
	if stacks % 2 == 1 and (self:Me(args.destGUID) or self:Dispeller("curse", false, args.spellId)) then
		self:StackMessage(args.spellId, "orange", args.destName, stacks, 3)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
