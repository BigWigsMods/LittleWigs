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
	if self:Classic() then
		local mobId = self:MobId(self:UnitGUID("npc"))
		if self:GetOption("custom_on_autotalk") and (mobId == 35004 or mobId == 35005) then
			local gossipTbl = self:GetGossipOptions()
			if gossipTbl then
				if gossipTbl[2] then
					self:SelectGossipOption(2) -- skip roleplay on Grand Champions if possible
				elseif gossipTbl[1] then
					self:SelectGossipOption(1)
				end
			end
		end
	else
		if self:GetOption("custom_on_autotalk") then
			if self:GetGossipID(38517) then -- "I am ready.  However, I'd like to skip the pageantry." (Skips long dialog prior to boss 1)
				self:SelectGossipID(38517) -- This special option only becomes available after clearing the dungeon at least once.
			elseif self:GetGossipID(38514) then -- "I am ready" (prior to boss 1)
				self:SelectGossipID(38514)
			elseif self:GetGossipID(38515) then -- "I am ready for the next challenge." (prior to boss 2)
				self:SelectGossipID(38515)
			elseif self:GetGossipID(38516) then -- "I am ready." (prior to boss 3)
				self:SelectGossipID(38516)
			end
		end
	end
end
