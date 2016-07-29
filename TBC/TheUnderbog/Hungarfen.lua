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

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Hungarfen", "enUS", true)
if L then
	--@do-not-package@
	L["spores"] = "Foul Spores"
	L["spores_desc"] = "Warn when Hungarfen is about to root himself and casts Foul Spores"
	L["spores_message"] = "Foul Spores Soon!"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Coilfang/Hungarfen", format="lua_additive_table", handle-unlocalized="ignore")@
end

L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Hungarfen")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	if bit.band(self.db.profile.spores, BigWigs.C.MESSAGE) == BigWigs.C.MESSAGE then
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
