-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("High Priestess Kilnara", 793)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52059)
mod.toggleOptions = {
	"stages",
	96435, -- Tears of Blood
	96958, -- Lash of Anguish
	96592, -- Ravage
	96594, -- Vengeful Smash
	96457, -- Wave of Agony
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local lastphase = 0
local wave = GetSpellInfo(96457)

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Tears", 96435)
	self:Log("SPELL_AURA_REMOVED", "TearsRemoved", 96435)
	self:Log("SPELL_AURA_APPLIED", "Phase2", 97380)
	self:Log("SPELL_AURA_APPLIED", "Lash", 96958)
	self:Log("SPELL_AURA_REMOVED", "LashRemoved", 96958)
	self:Log("SPELL_AURA_APPLIED", "Ravage", 96592)
	self:Log("SPELL_AURA_APPLIED", "Camouflage", 96594)
	self:Log("SPELL_CAST_SUCCESS", "WaveAgony", 96457)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 52059)
end

function mod:OnEngage()
	lastphase = 0
end

-------------------------------------------------------------------------------
--  Event Handlers
do
	function mod:Tears(_, spellId, _, _, spellName)
		self:Message(96435, spellName, "Important", spellId, "Alert")
		self:Bar(96435, spellName, 6, spellId)
	end

	function mod:TearsRemoved(_, _, _, _, spellName)
		self:SendMessage("BigWigs_StopBar", self, spellName)
	end
end

do
	function mod:Lash(player, spellId, _, _, spellName)
		self:TargetMessage(96958, spellName, player, "Attention", spellId, "Alert")
		self:Bar(96958, spellName..": "..player, 10, spellId)
	end

	function mod:LashRemoved(player, _, _, _, spellName)
		self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
	end
end

function mod:Ravage(player, spellId, _, _, spellName)
	self:TargetMessage(96592, spellName, player, "Attention", spellId, "Alert")
	self:Bar(96592, spellName..": "..player, 10, spellId)
end

function mod:Camouflage(_, spellId, _, _, spellName)
	self:Message(96594, spellName, "Important", spellId, "Alert")
end

function mod:WaveAgony(_, spellId, _, _, spellName)
	self:Message(96457, spellName, "Important", spellId)
	self:Bar(96457, LW_CL["next"]:format(wave), 32, spellId)
end

function mod:Phase2(_, spellId, _, _, spellName)
	if (GetTime() - lastphase) >= 5 then
		self:Message("stages", CL.phase:format(2), "Attention", spellId, "Info")
	end
	lastphase = GetTime()
end

