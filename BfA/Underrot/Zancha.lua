if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sporecaller Zancha", 1841, 2130)
if not mod then return end
mod:RegisterEnableMob(131383)
mod.engageId = 2112

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		259732, -- Festering Harvest
		259830, -- Boundless Rot
		272457, -- Shockwave
		{259718, "SAY"}, -- Upheaval
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FesteringHarvest", 259732)
	self:Log("SPELL_CAST_SUCCESS", "BoundlessRot", 259830)
	self:Log("SPELL_CAST_START", "Shockwave", 272457)
	self:Log("SPELL_AURA_APPLIED", "Upheaval", 259718)
	self:Log("SPELL_AURA_REMOVED", "UpheavalRemoved", 259718)
end

function mod:OnEngage()
	self:Bar(272457, 10) -- Shockwave
	self:Bar(259718, 18) -- Upheaval
	self:Bar(259732, 60) -- Festering Harvest
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FesteringHarvest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:BoundlessRot(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "watchstep")
end

function mod:Shockwave(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 20)
end

function mod:Upheaval(args)
	self:TargetMessage(args.spellId, args.destName, "orange")
	self:Bar(args.spellId, 20)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", "runout")
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 6)
		self:Flash(args.spellId)
	end
end

function mod:UpheavalRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end
