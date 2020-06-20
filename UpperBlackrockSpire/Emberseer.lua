--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Pyroguard Emberseer", 229)
if not mod then return end
mod:RegisterEnableMob(9816)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "Pyroguard Emberseer"

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

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Death("Win", 9816)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg:find(L.start_trigger, nil, true) then
		self:Bar("warmup", 64)
	end
end
