--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trial of the Champion Trash", 650)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	35005 -- Arelas Brightstar
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly select Arelas's gossip option to start encounters."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk", -- Arelas
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Arelas
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(UnitGUID("npc")) == 35005 then
		local first, _, second = GetGossipOptions()
		if second then
			SelectGossipOption(2) -- skip roleplay on Grand Champions if possible
		elseif first then
			SelectGossipOption(1)
		end
	end
end
