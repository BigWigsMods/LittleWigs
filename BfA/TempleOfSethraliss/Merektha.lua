if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Merektha", 1877, 2143)
if not mod then return end
mod:RegisterEnableMob(135820) -- Merektha
mod.engageId = 2125

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{263957, "TANK_HEALER"}, -- Hadotoxin
		263912, -- Noxious Breath
		263927, -- Toxic Pool
		263914, -- Blinding Sand
		264233, -- Hatch
		264206, -- Burrow
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Hadotoxin", 263957)
	self:Log("SPELL_AURA_APPLIED", "NoxiousBreath", 263912)
	self:Log("SPELL_AURA_APPLIED", "ToxicPool", 263927)
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicPool", 263927)
	self:Log("SPELL_PERIODIC_MISSED", "ToxicPool", 263927)
	self:Log("SPELL_AURA_START", "BlindingSand", 263914)
	self:Log("SPELL_AURA_SUCCESS", "Hatch", 264233)
	self:Log("SPELL_AURA_SUCCESS", "Burrow", 264206)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hadotoxin(args)
	self:TargetMessage(args.spellId, destName, "yellow", "Alert", nil, nil, true)
end

function mod:NoxiousBreath(args)
	self:Message(args.spellId, "yellow", "Alert")
end

do
	local prev = 0
	function mod:ToxicPool(args)
		if self:Me(args.destGUID) and GetTime()-prev > 1.5 then
			prev = GetTime()
			self:Message(args.spellId, "blue", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end

function mod:BlindingSand(args)
	self:Message(args.spellId, "red", "Warning")
end

function mod:Hatch(args)
	self:Message(args.spellId, "cyan", "Long")
end

function mod:Burrow(args)
	self:Message(args.spellId, "orange", "Alarm")
end
