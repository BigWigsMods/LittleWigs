--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Pyroguard Emberseer", 229)
if not mod then return end
mod:RegisterEnableMob(9816, 10316) -- Pyroguard Emberseer, Blackhand Incarcerator
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.pyroguard_emberseer = "Pyroguard Emberseer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.pyroguard_emberseer
end

function mod:GetOptions()
	return {
		"warmup",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")

	self:Death("Win", 9816) -- No encounter events
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_EMOTE(event, _, source)
	if source == self.displayName then
		self:UnregisterEvent(event)
		self:Bar("warmup", 66, CL.active, "spell_fire_lavaspawn")
	end
end
