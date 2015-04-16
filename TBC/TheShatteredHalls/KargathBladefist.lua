
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Warchief Kargath Bladefist", 710, 569)
if not mod then return end
mod:RegisterEnableMob(16808)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_trigger1 = "I am called"
	L.engage_trigger2 = "I'll carve"
	L.engage_trigger3 = "Ours is"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		30739, -- Blade Dance, XXX fake id
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Death("Win", 16808)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local handle = nil
	function mod:CHAT_MSG_MONSTER_YELL(event, msg)
		if msg:find(L.engage_trigger1) or msg:find(L.engage_trigger2) or msg:find(L.engage_trigger3) then
			self:Engage()
			self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
			self:DanceRepeater()
		end
	end
end

function mod:DanceRepeater()
	self:ScheduleTimer("DanceRepeater", 35)
	self:DelayedMessage(30739, 25, "Urgent")
	self:CDBar(30739, 30)
end

