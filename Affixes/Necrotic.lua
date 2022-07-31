--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewDungeonAffix("Necrotic", 4, {1195, 1208, 1456, 1458, 1466, 1493, 1501, 1571, 1651, 2097, 2284, 2285, 2286, 2287, 2289, 2290, 2291, 2293, 2441, 2520, 2527, 2519, 2521, 2526, 2515, 2516, 2451})
if not mod then return end

--------------------------------------------------------------------------------
-- Locals
--

local stacks = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{209858, "TANK_HEALER"}, -- Necrotic Wound
	}, {
		[209858] = CL.general,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "NecroticApplied", 209858) -- Necrotic Wound
	self:Log("SPELL_AURA_REMOVED", "NecroticRemoved", 209858) -- Necrotic Wound
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:NecroticApplied(args)
		stacks = args.amount
		local warningThreshold = 30
		if self:Player(args.destFlags) and args.amount > 10 and args.amount % 5 == 0 then
			local t = args.time
			if t-prev > 1 or args.amount == warningThreshold then
				prev = t
				self:StackMessage(args.spellId, args.destName, args.amount, "purple")
				self:PlaySound(args.spellId, args.amount >= warningThreshold and "warning" or "alert", nil, args.destName)
			end
		end
	end
end

function mod:NecroticRemoved(args)
	if self:Player(args.destFlags) and stacks >= 10 then
		self:Message(args.spellId, "green", CL.removed_from:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
	stacks = 0
end
