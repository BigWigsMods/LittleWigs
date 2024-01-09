--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Culling of Stratholme Trash", 595)
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
	L.custom_on_autotalk_icon = "ui_chat"

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

			if self:Classic() then
				if self:GetGossipID(93130) then
					self:SelectGossipID(93130) -- Can you skip us all ahead? (skip 1/2)
					self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
				elseif self:GetGossipOptions() then
					self:SelectGossipOption(1) -- fallback
				end
			else -- retail
				if self:GetGossipID(35027) then
					self:SelectGossipID(35027) -- Can you skip us all ahead? (skip 1/2)
					self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
				elseif self:GetGossipID(38140) then
					self:SelectGossipID(38140) -- Yes, Please! (skip 2/2)
				elseif self:GetGossipID(35026) then
					self:SelectGossipID(35026) -- Yes, Please! (skip if you go back to Chromie again)
				elseif self:GetGossipID(35025) then
					self:SelectGossipID(35025) -- Why have I been sent back... (no skip 1/3)
				elseif self:GetGossipID(37031) then
					self:SelectGossipID(37031) -- What was this decision? (no skip 2/3)
				elseif self:GetGossipID(36608) then
					self:SelectGossipID(36608) -- So how does the Infinite Dragonflight plan to interfere? (no skip 3/3)
				end
			end
		elseif mobId == 26499 then -- Arthas
			if self:GetGossipOptions() then
				self:SelectGossipOption(1)
			end
		end
	end
end
