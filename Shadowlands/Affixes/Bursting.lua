--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewDungeonAffix("Bursting", 11, {2284, 2285, 2286, 2287, 2289, 2290, 2291, 2293, 2441})
if not mod then return end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		240443, -- Burst
	}, {
		[240443] = CL.general,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "BurstApplied", 240443) -- Burst
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BurstApplied(args)
    if self:Me(args.destGUID) and args.amount >= 4 then
        self:StackMessage(args.spellId, args.destName, args.amount, "yellow")
        self:PlaySound(args.spellId, args.amount >= 6 and "warning" or "alert", nil, args.destName)
    end
end