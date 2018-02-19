-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("High Priestess Kilnara", 859, 181)
if not mod then return end
mod:RegisterEnableMob(52059)

--------------------------------------------------------------------------------
--  Locals

local lastphase = 0

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"stages",
		96435, -- Tears of Blood
		96958, -- Lash of Anguish
		96592, -- Ravage
		96594, -- Camouflage
		96457, -- Wave of Agony
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TearsOfBlood", 96435)
	self:Log("SPELL_AURA_REMOVED", "TearsOfBloodRemoved", 96435)
	self:Log("SPELL_AURA_APPLIED", "Phase2", 97380) -- Cave In
	self:Log("SPELL_AURA_APPLIED", "LashOfAnguish", 96958)
	self:Log("SPELL_AURA_REMOVED", "LashOfAnguishRemoved", 96958)
	self:Log("SPELL_AURA_APPLIED", "Ravage", 96592)
	self:Log("SPELL_AURA_APPLIED", "Camouflage", 96594)
	self:Log("SPELL_CAST_SUCCESS", "WaveOfAgony", 96457)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 52059)
end

function mod:OnEngage()
	lastphase = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:TearsOfBlood(args)
	self:Message(args.spellId, spellName, "Important", spellId, "Alert")
	self:Bar(args.spellId, 6)
end

function mod:TearsOfBloodRemoved(args)
	self:StopBar(args.spellId)
end

function mod:Phase2()
	local t = GetTime()
	if t - lastphase >= 5 then
		self:Message("stages", "Attention", "Info", CL.stage:format(2))
	end
	lastphase = t
end

function mod:LashOfAnguish(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:LashOfAnguishRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:Ravage(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:Camouflage(args)
	self:Message(args.spellId, "Important", "Alert")
end

function mod:WaveOfAgony(args)
	self:Message(args.spellId, "Important")
	self:CDBar(args.spellId, 32)
end
