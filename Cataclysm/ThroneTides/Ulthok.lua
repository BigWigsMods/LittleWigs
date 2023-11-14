--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Ulthok", 643, 102)
if not mod then return end
mod:RegisterEnableMob(40765) -- Commander Ulthok
mod:SetEncounterID(1044)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local festeringShockwaveCount = 1
local crushingClawCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427672, -- Bubbling Fissure
		427456, -- Awaken Ooze
		427668, -- Festering Shockwave
		{427670, "TANK_HEALER"}, -- Crushing Claw
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BubblingFissure", 427672)
	self:Log("SPELL_CAST_START", "AwakenOoze", 427456)
	self:Log("SPELL_CAST_START", "FesteringShockwave", 427668)
	self:Log("SPELL_CAST_START", "CrushingClaw", 427670)
end

function mod:OnEngage()
	festeringShockwaveCount = 1
	crushingClawCount = 1
	self:CDBar(427670, 8.2) -- Crushing Claw
	self:CDBar(427672, 17.5) -- Bubbling Fissure
	self:CDBar(427668, 25.2, CL.count:format(self:SpellName(427668), festeringShockwaveCount)) -- Festering Shockwave
	self:CDBar(427456, 30.1) -- Awaken Ooze
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
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
	end

	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BubblingFissure(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 32.7)
end

function mod:AwakenOoze(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 48.5)
end

function mod:FesteringShockwave(args)
	self:StopBar(CL.count:format(args.spellName, festeringShockwaveCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, festeringShockwaveCount))
	self:PlaySound(args.spellId, "alarm")
	festeringShockwaveCount = festeringShockwaveCount + 1
	self:CDBar(args.spellId, 32.8, CL.count:format(args.spellName, festeringShockwaveCount))
end

function mod:CrushingClaw(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	crushingClawCount = crushingClawCount + 1
	if crushingClawCount == 2 then
		self:CDBar(args.spellId, 26.7)
	elseif crushingClawCount == 3 then
		self:CDBar(args.spellId, 29.1)
	else
		self:CDBar(args.spellId, 31.5)
	end
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:DarkFissure(args)
	self:Message(args.spellId, "red")
end

function mod:Squeeze(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SqueezeRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:CurseOfFatigue(args)
	if self:Me(args.destGUID) or self:Dispeller("curse") then
		self:TargetMessage(args.spellId, "yellow", args.destName)
	end
end

function mod:Enrage(args)
	self:Message(args.spellId, "yellow")
end
