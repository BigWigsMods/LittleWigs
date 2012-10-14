
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brother Korloff", 874, 671)
mod:RegisterEnableMob(59223)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_say = "yell"


end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"bosskill"}
end

function mod:OnBossEnable()
	--self:Log("SPELL_AURA_APPLIED", "BloodyRage", 116140)
	--self:Log("SPELL_CAST_SUCCESS", "CallDog", 114259)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59223)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
--[[
function mod:CallDog(_, spellId, _, _, spellName)
	self:Message(spellId, ("%d%% - %s"):format(percent, spellName), "Urgent", spellId, "Alert")
	percent = percent - 10
end

function mod:BloodyRage(player, spellId, _, _, spellName)
	self:Message("rage", "50% - "..spellName, "Attention", spellId)
end

function mod:UNIT_HEALTH_FREQUENT(_, unitId)
	if unitId == "boss1" then
		local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
		if hp < 55 then
			self:Message("rage", CL["soon"]:format((GetSpellInfo(116140))), "Positive", nil, "Info")
			self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		end
	end
end
]]
