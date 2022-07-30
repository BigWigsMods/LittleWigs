--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewDungeonAffix("Bursting", 11, {1195, 1208, 1456, 1458, 1466, 1493, 1501, 1571, 1651, 2097, 2284, 2285, 2286, 2287, 2289, 2290, 2291, 2293, 2441, 2520, 2527, 2519, 2521, 2526, 2515, 2516, 2451})
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
