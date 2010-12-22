-- XXX Ulic: Other suggestions?  Perhaps if there is a timer between phases?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Drahga Shadowburner", "Grim Batol")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40319)
mod.toggleOptions = {
	{75218, "FLASHSHAKE"}, -- Invocation of Flame
	--{75321, "FLASHSHAKE"}, -- Valiona's Flame / Devouring Flames
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Fixate", 82850)
	--self:Log("SPELL_AURA_APPLIED", "Flame", 75321)

	self:Death("Win", 40319)
end

function mod:VerifyEnable()
	if not UnitInVehicle("player") then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Fixate(player, _, _, _, spellName)
	self:TargetMessage(75218, spellName, player, "Personal", spellId, "Alarm")
	if UnitIsUnit(player, "player") then
		self:FlashShake(75218)
	end
end

--[[
	This is wrong, her flame attack is a frontal cone
	We should warn for it but need a log or wait till next time I'm there
function mod:Flame(player, _, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(75321, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(75321)
	end
end
]]--

