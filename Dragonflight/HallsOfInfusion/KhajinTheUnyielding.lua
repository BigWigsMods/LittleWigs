--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Khajin the Unyielding", 2527, 2510)
if not mod then return end
mod:RegisterEnableMob(189727) -- Khajin the Unyielding
mod:SetEncounterID(2617)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		386757, -- Hailstorm
		386559, -- Glacial Surge
		{385963, "DISPEL"}, -- Frost Shock
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Hailstorm", 386757)
	self:Log("SPELL_CAST_START", "GlacialSurge", 386559)
	self:Log("SPELL_CAST_SUCCESS", "FrostShock", 385963)
	self:Log("SPELL_AURA_APPLIED", "FrostShockApplied", 385963)
end

function mod:OnEngage()
	self:Bar(385963, 6) -- Frost Shock
	self:Bar(386757, 10) -- Hailstorm
	self:Bar(386559, 22) -- Glacial Surge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hailstorm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 22)
end

function mod:GlacialSurge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 22)
end

function mod:FrostShock(args)
	self:CDBar(args.spellId, 15.4)
end

function mod:FrostShockApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
