-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Commander Springvale", 764)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(4278)
mod.toggleOptions = {
	93687, -- Desecration
	93844, -- Empowerment
	93736, -- Shield of the Perfidious
	93852, -- Word of Shame
	"bosskill",
}

--------------------------------------------------------------------------------
-- Locals
--

local empowerTime = 0

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Desecration", 93687)
	self:Log("SPELL_CAST_START", "Empowerment", 93844)
	self:Log("SPELL_AURA_APPLIED", "Shield", 93736, 93737) -- XXX What's doing the damage on players?
	self:Log("SPELL_AURA_APPLIED", "Word", 93852)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 4278)
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

function mod:OnEngage()
	empowerTime = 0
end
-------------------------------------------------------------------------------
--  Event Handlers

function mod:Desecration(_, spellId, _, _, spellName)
	self:Message(93687, spellName, "Attention", spellId)
end

function mod:Empowerment(_, spellId, _, _, spellName)
	if (GetTime() - empowerTime) > 2 then
		self:Message(93844, LW_CL["casting"]:format(spellName), "Urgent", spellId, "Alarm")
		empowerTime = GetTime()
	end
end

function mod:Shield(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(93736, LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(spellName), "Personal", spellId)
	end
end

function mod:Word(player, spellId, _, _, spellName)
	self:TargetMessage(93852, spellName, player, "Important", spellId)
end

