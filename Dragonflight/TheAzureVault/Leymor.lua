--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Leymor", 2515, 2492)
if not mod then return end
mod:RegisterEnableMob(186644) -- Leymor
mod:SetEncounterID(2582)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local consumingStompCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		374364, -- Ley-Line Sprouts
		374567, -- Explosive Brand
		386660, -- Erupting Fissure
		374720, -- Consuming Stomp
		{374789, "TANK_HEALER"}, -- Infused Strike
	}, nil, {
		[374567] = CL.explosion, -- Explosive Brand (Explosion)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LeyLineSprouts", 374364)
	self:Log("SPELL_CAST_START", "ExplosiveBrand", 374567)
	self:Log("SPELL_AURA_APPLIED", "ExplosiveBrandApplied", 374567)
	self:Log("SPELL_CAST_SUCCESS", "ConsumingStomp", 374720)
	self:Log("SPELL_CAST_START", "EruptingFissure", 386660)
	self:Log("SPELL_CAST_START", "InfusedStrike", 374789)
end

function mod:OnEngage()
	consumingStompCount = 0
	self:Bar(374364, 3.6) -- Ley-Line Sprouts
	self:Bar(374789, 10.6) -- Infused Strike
	self:Bar(386660, 20.3) -- Erupting Fissure
	self:Bar(374567, 30.1) -- Explosive Brand
	self:Bar(374720, 45.8, CL.count:format(self:SpellName(374720), 1)) -- Consuming Stomp (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LeyLineSprouts(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 48.7)
end

function mod:ExplosiveBrand(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 48.7)
end

function mod:ExplosiveBrandApplied(args)
	if self:Me(args.destGUID) then
		self:Bar(args.spellId, 6, CL.explosion)
	end
end

function mod:EruptingFissure(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 48.7)
end

function mod:ConsumingStomp(args)
	consumingStompCount = consumingStompCount + 1
	local consumingStompMessage = CL.count:format(args.spellName, consumingStompCount)
	self:StopBar(consumingStompMessage)
	self:Message(args.spellId, "red", consumingStompMessage)
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 48.7, CL.count:format(args.spellName, consumingStompCount + 1))
end

function mod:InfusedStrike(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 48.7)
end
