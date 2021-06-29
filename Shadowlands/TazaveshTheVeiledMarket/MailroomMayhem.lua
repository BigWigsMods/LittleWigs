
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mailroom Mayhem", 2441, 2436)
if not mod then return end
mod:RegisterEnableMob(175646) -- P.O.S.T. Master
mod:SetEncounterID(2424)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		346286, -- Hazardous Liquids
		346742, -- Fan Mail
		{346962, "SAY", "SAY_COUNTDOWN"}, -- Money Order
		346947, -- Unstable Goods
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "HazardousLiquids", 346286)
	self:Log("SPELL_CAST_START", "FanMail", 346742)
	self:Log("SPELL_AURA_APPLIED", "MoneyOrderApplied", 346962)
	self:Log("SPELL_AURA_REMOVED", "MoneyOrderRemoved", 346962)
	self:Log("SPELL_CAST_SUCCESS", "UnstableGoods", 346947)
end

function mod:OnEngage()
	self:Bar(346286, 6) -- Hazardous Liquids
	self:Bar(346742, 16) -- Fan Mail
	self:Bar(346962, 23.1) -- Money Order
	self:Bar(346947, 32.4) -- Unstable Goods
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HazardousLiquids(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 52.2)
end

function mod:FanMail(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 25.5)
end

function mod:MoneyOrderApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:Bar(args.spellId, 50.5)
	if self:Me(args.destGUID) then
		self:Yell(args.spellId)
		self:YellCountdown(args.spellId, 7)
	end
end

function mod:MoneyOrderRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelYellCountdown(args.spellId)
	end
end

function mod:UnstableGoods(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 52.2)
end
