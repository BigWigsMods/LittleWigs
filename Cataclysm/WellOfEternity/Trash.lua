--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Well Of Eternity Trash", 939)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	55500 -- Illidan Stormrage
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly select Illidan's gossip option."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk", -- Illidan
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Illidan
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 55500 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1)
		end
	end
end
