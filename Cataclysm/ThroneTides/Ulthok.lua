
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Commander Ulthok", 643, 102)
if not mod then return end
mod:RegisterEnableMob(40765)
mod.engageId = 1044
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		76047, -- Dark Fissure
		{76026, "ICON"}, -- Squeeze
		76094, -- Curse of Fatigue
		76100, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DarkFissure", 76047)
	self:Log("SPELL_AURA_APPLIED", "Squeeze", 76026)
	self:Log("SPELL_AURA_REMOVED", "SqueezeRemoved", 76026)
	self:Log("SPELL_AURA_APPLIED", "CurseOfFatigue", 76094)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 76100)
	self:Death("Win", 40765)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkFissure(args)
	self:MessageOld(args.spellId, "red", nil, CL.casting:format(args.spellName))
end

function mod:Squeeze(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SqueezeRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:CurseOfFatigue(args)
	if self:Me(args.destGUID) or self:Dispeller("curse") then
		self:TargetMessageOld(args.spellId, args.destName, "yellow")
	end
end

function mod:Enrage(args)
	self:MessageOld(args.spellId, "yellow")
end
