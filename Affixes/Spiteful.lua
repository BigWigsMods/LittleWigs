--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewDungeonAffix("Spiteful", 123, {1195, 1208, 1456, 1458, 1466, 1493, 1501, 1571, 1651, 2097, 2284, 2285, 2286, 2287, 2289, 2290, 2291, 2293, 2441, 2520, 2527, 2519, 2521, 2526, 2515, 2516, 2451})
if not mod then return end

--------------------------------------------------------------------------------
-- Locals
--

local spitefulCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		350209, -- Spiteful Fixation
	}, {
		[350209] = self.displayName,
	}
end

function mod:OnBossEnable()
	spitefulCount = 0
	self:Log("SPELL_AURA_APPLIED", "SpitefulFixate", 350209) -- Spiteful Fixation
	self:Log("SPELL_AURA_REMOVED", "SpitefulRemoved", 350209) -- Spiteful Fixation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:SpitefulFixate(args)
		if self:Me(args.destGUID) then
			spitefulCount = spitefulCount + 1
			local t = args.time
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "blue", CL.you:format(args.spellName))
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

function mod:SpitefulRemoved(args)
	if self:Me(args.destGUID) then
		spitefulCount = spitefulCount - 1
		if spitefulCount == 0 then
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end
