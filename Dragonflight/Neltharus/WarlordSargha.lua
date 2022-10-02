if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warlord Sargha", 2519, 2501)
if not mod then return end
mod:RegisterEnableMob(189901) -- Warlord Sargha
mod:SetEncounterID(2611)
mod:SetRespawnTime(30)

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
		"magical_implements",
		376780, -- Magma Shield
		377014, -- Backdraft
		377477, -- Burning Ember
		377204, -- Berserk Barrage
		377018, -- Molten Gold
		377522, -- Burning Pursuit
	}, {
		["magical_implements"] = self.displayName, -- Warlord Sargha
		[377522] = -25270, -- Raging Ember
	}, {
		[377522] = CL.fixate, -- Burning Pursuit (Fixate)
	}
end

function mod:OnBossEnable()
	-- Magical Implements:
	-- 376762 Wand of Negation
	-- 384595 Anti-Magic Bomb
	-- 392164 Azure Stone of Might
	-- 392170 Rose of the Vale
	-- 392258 Seismic Boots
	self:Log("SPELL_AURA_APPLIED", "MagicalImplementsPickedUp", 376762, 384595, 392164, 392170, 392258)

	self:Log("SPELL_AURA_APPLIED", "MagmaShieldApplied", 376780)
	self:Log("SPELL_AURA_REMOVED", "MagmaShieldRemoved", 376780)
	self:Log("SPELL_CAST_START", "BerserkBarrage", 377204)
	self:Log("SPELL_CAST_START", "MoltenGold", 377017)
	self:Log("SPELL_CAST_START", "BurningEmber", 377473)
	self:Log("SPELL_AURA_APPLIED", "BurningPursuit", 377522)
end

function mod:OnEngage()
	self:CDBar(377204, 7.1) -- Berserk Barrage
	self:CDBar(377018, 14.2) -- Molten Gold
	self:CDBar(377477, 21.5) -- Burning Ember
	self:CDBar(376780, 37.7) -- Magma Shield
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MagicalImplementsPickedUp(args)
	self:TargetMessage("magical_implements", "green", args.destName, args.spellId, args.spellId)
	self:PlaySound("magical_implements", "info", nil, args.destName)
end

do
	local magmaShieldStart = 0

	function mod:MagmaShieldApplied(args)
		magmaShieldStart = args.time
		self:Message(args.spellId, "orange", L.magma_shield)
		self:PlaySound(args.spellId, "long")
	end

	function mod:MagmaShieldRemoved(args)
		local duration = args.time - magmaShieldStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, duration))
		self:PlaySound(args.spellId, "info")
		self:Bar(args.spellId, 32.6) -- 30s energy gain, 2.5s cast time, ~.1s delay
		self:Bar(377014, 10) -- Backdraft
	end
end

function mod:BerserkBarrage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.8)
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(377018, "orange", name)
			self:PlaySound(377018, "alert", nil, name)
		end
	end

	function mod:MoltenGold(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(377018, 42.8)
	end
end

function mod:BurningEmber(args)
	self:Message(377477, "yellow")
	self:PlaySound(377477, "alert")
	self:CDBar(377477, 45)
end

function mod:BurningPursuit(args)
	self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
end
