if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Captain Dailcry", 2649, 2571)
if not mod then return end
mod:RegisterEnableMob(207946) -- Captain Dailcry
mod:SetEncounterID(2847)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		424419, -- Battle Cry
		447270, -- Hurl Spear
		{424414, "TANK"}, -- Pierce Armor
		447439, -- Savage Mauling
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BattleCry", 424419)
	self:Log("SPELL_CAST_START", "HurlSpear", 447270)
	self:Log("SPELL_CAST_START", "PierceArmor", 424414)
	self:Log("SPELL_CAST_SUCCESS", "PierceArmorSuccess", 424414)
	self:Log("SPELL_CAST_SUCCESS", "SavageMauling", 447439)
end

function mod:OnEngage()
	self:CDBar(424414, 5.2) -- Pierce Armor
	self:CDBar(447270, 8.1) -- Hurl Spear
	self:CDBar(424419, 12.1) -- Battle Cry
	self:CDBar(447439, 16.6) -- Savage Mauling
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BattleCry(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 15.8)
end

function mod:HurlSpear(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.4)
end

function mod:PierceArmor(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:PierceArmorSuccess(args)
	-- doesn't go on cooldown if the cast is outranged
	self:CDBar(args.spellId, 7.3)
end

function mod:SavageMauling(args)
	self:CDBar(args.spellId, 33.6)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
