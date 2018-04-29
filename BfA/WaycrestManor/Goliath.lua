if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Soulbound Goliath", 1862, 2126)
if not mod then return end
mod:RegisterEnableMob(131667) -- Soulbound Goliath
mod.engageId = 2114

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260512, -- Soul Harvest
		260551, -- Soul Thorns
		{260508, "TANK"}, -- Crush
		260541, -- Burning Brush
		260569, -- Wildfire
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "SoulHarvest", 260512)
	self:Log("SPELL_CAST_SUCCESS", "SoulThorns", 260551)
	self:Log("SPELL_CAST_START", "Crush", 260508)
	self:Log("SPELL_AURA_APPLIED", "BurningBrush", 260541)
	self:Log("SPELL_AURA_APPLIED", "Wildfire", 260569) -- XXX Is there more events?
end

function mod:OnEngage()
	self:Bar(260508, 6) -- Crush
	self:Bar(260551, 10) -- Soul Thorns
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SoulHarvest(args)
	if args.amount % 3 == 0 then
		self:StackMessage(args.spellId, args.destName, args.amount, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SoulThorns(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 22)
end

function mod:Crush(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17)
end

function mod:BurningBrush(args)
	self:TargetMessage2(args.spellId, "cyan", args.destName)
	self:PlaySound(args.spellId, "long")
end

function mod:Wildfire(args)
	if self:Me(args.destGUID) then
		self:TargetMessage2(args.spellId, "blue", args.destName)
		self:PlaySound(args.spellId, "alarm")
	end
end
