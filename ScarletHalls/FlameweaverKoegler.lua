
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Flameweaver Koegler", 871, 656)
mod:RegisterEnableMob(59150)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "yell"


end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"bosskill"}
end

function mod:OnBossEnable()


	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59150)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
--[[
function mod:Smash(player, spellId)
	self:TargetMessage(spellId, smash, player, "Urgent", spellId, "Alarm")
	self:Bar(spellId, CL["other"]:format(smash, player), 4, spellId)
	self:Bar(spellId, "~"..smash, 17, spellId) -- 17-19
end

function mod:Enrage(_, spellId, _, _, spellName)
	self:Message("enrage", spellName, "Important", spellId, "Alert")
	self:Bar("enrage", spellName, 30, spellId)
end

function mod:EnrageRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

function mod:BossDeath(...)
	local dGUID = select(10, ...)
	if self:GetCID(dGUID) == 56719 then
		self:Win()
	end
end

function mod:UNIT_HEALTH_FREQUENT(_, unitId)
	if unitId == "boss1" then
		local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
		if hp < 25 then
			self:Message("enrage", CL["soon"]:format((GetSpellInfo(38166))), "Positive", 38166, "Info")
			self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		end
	end
end
]]
