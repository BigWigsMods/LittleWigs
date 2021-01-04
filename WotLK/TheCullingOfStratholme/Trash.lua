--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Culling of Stratholme Trash", 650)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	26527, 27915, -- Chromie
	26499, -- Arthas
	26528, -- Uther
	26497 -- Jaina
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options."

	L.gossip_available = "Gossip available"
	L.gossip_timer_trigger = "Glad you could make it, Uther."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"custom_on_autotalk", -- Chromie, Arthas
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Timer for the "Glad you could make it, Uther" roleplay
function mod:CHAT_MSG_MONSTER_SAY(_, msg)
	if msg == L.gossip_timer_trigger then
		self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
		self:Bar("warmup", 155.6, L.gossip_available, "inv_sword_01")
	end
end

-- Gossips
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		local mobId = self:MobId(self:UnitGUID("npc"))
		if mobId == 26527 or mobId == 27915 then -- Chromie
			if C_GossipInfo.GetNumAvailableQuests() > 0 or C_GossipInfo.GetNumActiveQuests() > 0 then return end -- let the player take / turn in the quest

			local first, second = self:GetGossipOptions()
			if second then
				self:SelectGossipOption(2) -- skip the roleplay if possible
				self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
			elseif first then
				self:SelectGossipOption(1)
			end
		elseif mobId == 26499 then -- Arthas
			if self:GetGossipOptions() then
				self:SelectGossipOption(1)
			end
		end
	end
end
