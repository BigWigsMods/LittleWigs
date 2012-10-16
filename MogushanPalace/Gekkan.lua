
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gekkan", 885, 690)
mod:RegisterEnableMob(61243)

local deaths = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "Stop them!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"ej:5921", "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Shank", 118963)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Deaths", 61243, 61337, 61338, 61339, 61340)
end

function mod:OnEngage()
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Shank(player, spellId, _, _, spellName)
	self:TargetMessage("ej:5921", spellName, player, "Attention", spellId)
	self:Bar("ej:5921", CL["other"]:format(spellName, player), 5, spellId)
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 5 then
		self:Win()
	end
end

