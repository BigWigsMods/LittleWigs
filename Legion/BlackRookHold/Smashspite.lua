--------------------------------------------------------------------------------
-- Module Declaration
--

--TO do List
--Brutal Haymaker should be tested tank POV
--Fel vomit cd reduces on every cast 0.64~ multiplier still could be tested a few more tries
local mod, CL = BigWigs:NewBoss("Smashspite", 1501, 1664)
if not mod then return end
mod:RegisterEnableMob(98949)
mod.engageId = 1834

--------------------------------------------------------------------------------
-- Locals
--

local felVomitCD = 35

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198073, -- Earthshaking Stomp
		{198245, "TANK"}, -- Brutal Haymaker
		{198079, "SAY"}, -- Hateful Gaze
		198446, -- Fel Vomit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FelVomit", 198446)
	self:Log("SPELL_CAST_START", "EarthshakingStomp", 198073)
	self:Log("SPELL_CAST_SUCCESS", "HatefulGaze", 198079)
	self:Log("SPELL_CAST_START", "BrutalHaymaker", 198245)
end

function mod:OnEngage()
	felVomitCD = 35
	self:CDBar(198079, 5.8) -- Hateful Gaze
	self:CDBar(198073, 12) -- Earthshaking Stomp
	self:CDBar(198446, 31) -- Fel Vomit
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BrutalHaymaker(args)
	self:MessageOld(args.spellId, "green", "alarm", CL.incoming:format(args.spellName))
end

function mod:EarthshakingStomp(args)
	self:MessageOld(args.spellId, "orange", "info")
	self:Bar(args.spellId, 24.3)
end

function mod:HatefulGaze(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:Bar(args.spellId, 25.4)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "warning", nil, nil, true)
end

function mod:FelVomit(args)
	self:MessageOld(args.spellId, "red", "alert", CL.incoming:format(args.spellName))
	felVomitCD = felVomitCD * 0.64
	self:CDBar(args.spellId, felVomitCD)
end

