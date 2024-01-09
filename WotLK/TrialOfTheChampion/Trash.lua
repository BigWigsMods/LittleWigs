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
	L.custom_on_autotalk_icon = "ui_chat"
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
	if self:GetOption("custom_on_autotalk") then
		if self:GetGossipID(38517) then -- "I am ready.  However, I'd like to skip the pageantry." (Skips long dialog prior to boss 1)
			self:SelectGossipID(38517) -- This special option only becomes available after clearing the dungeon at least once.
		elseif self:GetGossipID(38514) then -- "I am ready" (prior to boss 1)
			self:SelectGossipID(38514)
		elseif self:GetGossipID(38515) then -- "I am ready for the next challenge." (prior to boss 2)
			self:SelectGossipID(38515)
		elseif self:GetGossipID(38516) then -- "I am ready." (prior to boss 3)
			self:SelectGossipID(38516)
		else
			local tbl = self:GetGossipOptions()
			if tbl then
				for i = 1, #tbl do
					if tbl[i].name and (tbl[i].name):find("I am ready") then
						BigWigs:Error("Unknown gossip ID ".. tostring(tbl[i].gossipOptionID) .." with name: ".. tostring(tbl[i].name))
					end
				end
			end
		end
	end
end
