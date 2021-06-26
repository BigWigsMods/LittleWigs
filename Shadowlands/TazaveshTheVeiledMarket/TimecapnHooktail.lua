
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Timecap'n Hooktail", 2441, 2449)
if not mod then return end
mod:RegisterEnableMob(175546) -- Timecap'n Hooktail
mod:SetEncounterID(2419)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		347149, -- Infinite Breath
		347151, -- Hook Swipe
		354334, -- Hook'd!
		{352345, "ME_ONLY"}, -- Anchor Shot
		347371, -- Grapeshot
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "InfiniteBreath", 347149)
	self:Log("SPELL_CAST_START", "HookSwipe", 347151)
	self:Log("SPELL_AURA_APPLIED", "HookdApplied", 354334)
	self:Log("SPELL_AURA_APPLIED", "AnchorShotApplied", 352345)
	self:Log("SPELL_CAST_SUCCESS", "Grapeshot", 347371)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InfiniteBreath(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:HookSwipe(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:HookdApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:AnchorShotApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

do
	local prev = 0
	function mod:Grapeshot(args)
		local t = args.time
		if t-prev > 5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end
