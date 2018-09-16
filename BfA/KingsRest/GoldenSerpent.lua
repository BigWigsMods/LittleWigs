
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Golden Serpent", 1762, 2165)
if not mod then return end
mod:RegisterEnableMob(135322) -- The Golden Serpent
mod.engageId = 2139

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{265773, "SAY", "SAY_COUNTDOWN"}, -- Spit Gold
		265923, -- Lucre's Call
		265781, -- Serpentine Gust
		{265910, "TANK_HEALER"}, -- Tail Thrash
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SpitGoldApplied", 265773)
	self:Log("SPELL_AURA_REMOVED", "SpitGoldRemoved", 265773)
	self:Log("SPELL_CAST_START", "LucresCall", 265923)
	self:Log("SPELL_CAST_START", "SerpentineGust", 265781)
	self:Log("SPELL_CAST_START", "TailThrash", 265910)
end

function mod:OnEngage()
	self:CDBar(265773, 11) -- Spit Gold
	self:CDBar(265923, 40) -- Lucre's Call
	self:CDBar(265781, 12.5) -- Serpentine Gust
	self:CDBar(265910, 15.5) -- Tail Thrash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpitGoldApplied(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 9)
	end
	self:CDBar(args.spellId, 11)
end

function mod:SpitGoldRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:LucresCall(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 41.5)
end

function mod:SerpentineGust(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.5)
end

function mod:TailThrash(args)
	self:Message2(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17)
end
