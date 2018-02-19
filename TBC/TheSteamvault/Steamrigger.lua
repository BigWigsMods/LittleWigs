-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Mekgineer Steamrigger", 545, 574)
if not mod then return end
--mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17796)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.mech_trigger = "Tune 'em up good, boys!"
	L.mech_message = "%s coming soon!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		-5999, -- Steamrigger Mechanics
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Mech")
	self:Death("Win", 17796)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Mech(_, msg)
	if msg == L.mech_trigger or msg:find(L.mech_trigger, nil, true) then
		self:Message(-5999, "Attention", nil, L.mech_message:format(self:SpellName(-5999)))
	end
end
