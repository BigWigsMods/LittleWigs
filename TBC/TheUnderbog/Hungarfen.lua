-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Hungarfen", 726, 576)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17770)
mod.toggleOptions = {"spores"}

-------------------------------------------------------------------------------
--  Locals

local sporesannounced = nil

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["spores"] = "Foul Spores"
	L["spores_desc"] = "Warn when Hungarfen is about to root himself and casts Foul Spores"
	L["spores_message"] = "Foul Spores Soon!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	if self:CheckOption("spores", "MESSAGE") then
		self:RegisterEvent("UNIT_HEALTH")
	end
	self:Death("Win", 17770)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

function mod:OnEnable()
	sporesannounced = nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(event, msg)
	if UnitName(msg) ~= mod.displayName then return end
	local health = UnitHealth(msg)
	if health > 18 and health <= 24 and not sporesannounced then
		sporesannounced = true
		self:Message(L["spores_message"], "Urgent", nil, nil, nil, 31673)
	elseif health > 28 and sporesannounced then
		sporesannounced = nil
	end
end
