-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Mekgineer Steamrigger", 727, 574)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17796)
mod.toggleOptions = {
	"mech",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["mech"] = "Steamrigger Mechanics"
	L["mech_desc"] = "Warn for incoming mechanics."
	L["mech_trigger"] = "Tune 'em up good, boys!"
	L["mech_message"] = "Steamrigger Mechanics coming soon!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 17796)
	self:Yell("Mech", L["mech_trigger"])
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Mech()
	self:Message("mech", L["mech_message"], "Attention")
end
