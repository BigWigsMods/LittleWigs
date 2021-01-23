--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trial of the Champion Trash", 650)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	35005, -- Arelas Brightstar (Alliance)
	35004 -- Jaeren Sunsworn (Horde)
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly select gossip option to start encounters."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	local mobId = self:MobId(self:UnitGUID("npc"))
	if self:GetOption("custom_on_autotalk") and (mobId == 35004 or mobId == 35005) then
		local first, second = self:GetGossipOptions()
		if second then
			self:SelectGossipOption(2) -- skip roleplay on Grand Champions if possible
		elseif first then
			self:SelectGossipOption(1)
		end
	end
end
