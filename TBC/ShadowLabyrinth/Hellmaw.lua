-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ambassador Hellmaw", 724, 544)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18731)
mod.toggleOptions = {
	"berserk",
	33547, -- Fear
}
mod.optionHeaders = {
	berserk = "heroic",
	[33547] = "general",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["fear_bar"] = "~Fear Cooldown"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Fear", 33547)
	self:Death("Win", 18731)
end

function mod:OnEngage()
	self:Bar(33547, L["fear_bar"], 15, 33547)
	if self:Difficulty() == 2 then self:Berserk(180) end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Fear()
	self:Bar(33547, L["fear_bar"], 30, 33547)
	self:DelayedMessage(33547, 25, L["fear_bar"], "Attention")
end
