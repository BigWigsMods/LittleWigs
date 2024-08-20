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

local magmaShieldCount = 1
local burningEmberRemaining = 1
local theDragonsKilnRemaining = 2
local moltenGoldRemaining = 1
local magicalImplementsList = {}

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
		{"magical_implements", "INFOBOX"},
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
	-- 392170 Rose of the Vale
	self:Log("SPELL_AURA_APPLIED", "MagicalImplementsPickedUp", 376762, 384595, 392170)
	self:Log("SPELL_AURA_REMOVED", "MagicalImplementsRemoved", 376762, 384595, 392170)
	self:Log("SPELL_AURA_APPLIED", "CurseOfTheDragonHoardApplied", 391762)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CurseOfTheDragonHoardApplied", 391762)
end

function mod:OnEngage()
	magmaShieldCount = 1
	burningEmberRemaining = 1
	theDragonsKilnRemaining = 2
	moltenGoldRemaining = 1
	self:CDBar(377204, 7.1) -- The Dragon's Kiln
	self:CDBar(377018, 14.2) -- Molten Gold
	self:CDBar(377477, 21.5) -- Burning Ember
	-- cast at 100 energy: 30s energy gain + 2.5s cast + ~4s delay
	self:CDBar(376780, 37.7, CL.count:format(self:SpellName(376780), magmaShieldCount)) -- Magma Shield
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MagmaShield(args)
	self:StopBar(377477) -- Burning Ember
	self:StopBar(377204) -- The Dragon's Kiln
	self:StopBar(377018) -- Molten Gold
end

do
	local magmaShieldStart = 0

	function mod:MagmaShieldApplied(args)
		magmaShieldStart = args.time
		self:StopBar(CL.count:format(args.spellName, magmaShieldCount)) -- Magma Shield (n)
		if self:Normal() then
			-- there are no Magical Implements in Normal
			self:Message(args.spellId, "orange")
		else
			self:Message(args.spellId, "orange", L.magma_shield)
		end
		self:PlaySound(args.spellId, "long")
	end

	function mod:MagmaShieldRemoved(args)
		local duration = args.time - magmaShieldStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, duration))
		self:PlaySound(args.spellId, "info")
		magmaShieldCount = magmaShieldCount + 1
		-- timers are based off the shield being removed
		if args.amount == 0 then
			burningEmberRemaining = 1
			theDragonsKilnRemaining = 1
			moltenGoldRemaining = 2
			-- boss is stunned for 10s
			self:Bar(377014, 10, CL.onboss:format(self:SpellName(377014))) -- Backdraft
			-- cast at 100 energy: 10s stun + 30s energy gain + ~.1s delay + 2.5s cast time
			self:Bar(args.spellId, 42.6, CL.count:format(args.spellName, magmaShieldCount))
			if magmaShieldCount == 2 then
				self:CDBar(377018, 15.5) -- Molten Gold
				self:CDBar(377477, 24.8) -- Burning Ember
				self:CDBar(377204, 28.4) -- The Dragon's Kiln
			else
				self:CDBar(377018, 11.0) -- Molten Gold
				self:CDBar(377477, 14.8) -- Burning Ember
				self:CDBar(377204, 19.3) -- The Dragon's Kiln
			end
		else
			-- or shield just expires and boss is not stunned
			burningEmberRemaining = 1
			theDragonsKilnRemaining = 2
			moltenGoldRemaining = 2
			self:CDBar(377018, 2.4) -- Molten Gold
			self:CDBar(377477, 2.4) -- Burning Ember
			self:CDBar(377204, 2.4) -- The Dragon's Kiln
			-- cast at 100 energy: 30s energy gain + ~.1s delay + 2.5s cast time
			self:Bar(args.spellId, 32.6, CL.count:format(args.spellName, magmaShieldCount))
		end
	end
end

function mod:BurningEmber()
	self:StopBar(377477)
	burningEmberRemaining = burningEmberRemaining - 1
	self:Message(377477, "yellow")
	self:PlaySound(377477, "alert")
	-- soonest ability can be is 4.86
	if theDragonsKilnRemaining > 0 and self:BarTimeLeft(377204) < 4.86 then -- The Dragon's Kiln
		self:CDBar(377204, {4.86, 19.3})
	end
	if moltenGoldRemaining > 0 and self:BarTimeLeft(377018) < 4.86 then -- Molten Gold
		self:CDBar(377018, {4.86, 11.0})
	end
end

function mod:TheDragonsKiln(args)
	theDragonsKilnRemaining = theDragonsKilnRemaining - 1
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	if theDragonsKilnRemaining > 0 then
		self:CDBar(args.spellId, 21.9)
	else
		self:StopBar(args.spellId)
	end
	-- soonest ability can be is 6.06
	if moltenGoldRemaining > 0 and self:BarTimeLeft(377018) < 6.06 then -- Molten Gold
		self:CDBar(377018, {6.06, 11.0})
	end
	if burningEmberRemaining > 0 and self:BarTimeLeft(377477) < 6.06 then -- Burning Ember
		self:CDBar(377477, {6.06, 15.9})
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
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		if moltenGoldRemaining > 0 then
			self:CDBar(377018, 26.7)
		else
			self:StopBar(377018)
		end
		-- soonest ability can be is 4.7
		if theDragonsKilnRemaining > 0 and self:BarTimeLeft(377204) < 4.7 then -- The Dragon's Kiln
			self:CDBar(377204, {4.7, 19.3})
		end
		if burningEmberRemaining > 0 and self:BarTimeLeft(377477) < 4.7 then -- Burning Ember
			self:CDBar(377477, {4.7, 15.9})
		end
	end
end

-- Raging Ember

function mod:BurningPursuit(args)
	self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

-- Magical Implements

function mod:MagicalImplementsPickedUp(args)
	if self:Me(args.destGUID) then
		self:TargetMessage("magical_implements", "green", args.destName, args.spellId, args.spellId)
		self:PlaySound("magical_implements", "info", nil, args.destName)
	end
	if not next(magicalImplementsList) then
		self:OpenInfo("magical_implements", self:SpellName(-25983)) -- Magical Implements
	end
	local magicalImplementsForPlayer = magicalImplementsList[args.destName]
	if not magicalImplementsForPlayer then
		magicalImplementsList[args.destName] = 1
	else
		-- can have more than 1 weapon each
		magicalImplementsList[args.destName] = magicalImplementsForPlayer + 1
	end
	self:SetInfoByTable("magical_implements", magicalImplementsList)
end

function mod:MagicalImplementsRemoved(args)
	local magicalImplementsForPlayer = magicalImplementsList[args.destName]
	if magicalImplementsForPlayer then
		if magicalImplementsForPlayer == 1 then
			magicalImplementsList[args.destName] = nil
		else
			magicalImplementsList[args.destName] = magicalImplementsForPlayer - 1
		end
	end
	if not next(magicalImplementsList) then
		self:CloseInfo("magical_implements")
	else
		self:SetInfoByTable("magical_implements", magicalImplementsList)
	end
end

function mod:CurseOfTheDragonHoardApplied(args)
	-- no need to alert when on you because this is always accompanied by picking up a Magical Implement
	if not self:Me(args.destGUID) and self:Dispeller("curse", nil, args.spellId) then
		self:StackMessage(args.spellId, "orange", args.destName, args.amount, 2)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
