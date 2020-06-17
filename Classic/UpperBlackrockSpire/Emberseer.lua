--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Pyroguard Emberseer", 1583)
if not mod then return end
mod:RegisterEnableMob(9816)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.start_trigger = "begins to regain its strength"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Death("Win", 9816)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg:find(L.start_trigger, nil, true) then
		self:Bar("warmup", 64)
	end
end