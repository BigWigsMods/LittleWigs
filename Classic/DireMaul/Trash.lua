--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dire Maul Trash", 429)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	11491 -- Ironbark the Redeemed (gossip NPC)
)

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		-- Autotalk
		autotalk,
	}, {
		[autotalk] = CL.general,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) and self:GetGossipID(29281) then
		-- 29281:Thank you, Ironbark. We are ready for you to open the door.
		self:SelectGossipID(29281)
	end
end
