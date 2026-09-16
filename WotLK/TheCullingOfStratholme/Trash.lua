--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Culling of Stratholme Trash", 595)
if not mod then return end
mod:SetTrashModule(true)
mod:RegisterEnableMob(
	26527, 27915, -- Chromie
	26499, -- Arthas
	26528, -- Uther
	26497 -- Jaina
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	custom_on_autotalk = CL.autotalk,
	custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options.",
	custom_on_autotalk_icon = mod:GetMenuIcon("SAY"),

	gossip_available = "Gossip available",
	gossip_timer_trigger = "Glad you could make it, Uther.",
})

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
	if not self:IsSecret(msg) and msg == L.gossip_timer_trigger then
		self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
		self:Bar("warmup", 155.6, L.gossip_available, "inv_sword_01")
	end
end

-- Gossips
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		if C_GossipInfo.GetNumAvailableQuests() > 0 or C_GossipInfo.GetNumActiveQuests() > 0 then return end -- let the player take / turn in the quest
		if self:Retail() then
			if self:GetGossipID(35027) then -- Chromie (skip 1/2)
				-- 35027:Can you skip us all ahead?
				self:SelectGossipID(35027)
				self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
			elseif self:GetGossipID(38140) then -- Chromie (skip 2/2)
				-- 38140:Yes, Please!
				self:SelectGossipID(38140)
			elseif self:GetGossipID(35026) then -- Chromie (skip if you go back to Chromie again)
				-- 35026:Yes, Please!
				self:SelectGossipID(35026)
			elseif self:GetGossipID(35025) then -- Chromie (no skip 1/3)
				-- 35025:Why have I been sent back...
				self:SelectGossipID(35025)
			elseif self:GetGossipID(37031) then -- Chromie (no skip 2/3)
				-- 37031:What was this decision?
				self:SelectGossipID(37031)
			elseif self:GetGossipID(36608) then -- Chromie (no skip 3/3)
				-- 36608:So how does the Infinite Dragonflight plan to interfere?
				self:SelectGossipID(36608)
			elseif self:SelectGossipID(36217) then -- Arthas
				-- 36217:Yes, my prince. We are ready.
				self:SelectGossipID(36217)
			end
		else -- Classic
			local mobId = self:MobId(self:UnitGUID("npc"))
			if mobId == 26527 or mobId == 27915 then -- Chromie (skip 1/2)
				if self:GetGossipID(93130) then
					-- 93130:Can you skip us all ahead?
					self:SelectGossipID(93130)
					self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
				elseif self:GetGossipOptions() then -- fallback
					self:SelectGossipOption(1)
				end
			elseif mobId == 26499 then -- Arthas
				if self:GetGossipOptions() then
					self:SelectGossipOption(1)
				end
			end
		end
	end
end
