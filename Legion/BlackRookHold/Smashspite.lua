--------------------------------------------------------------------------------
-- Module Declaration
--

--TO do List
--Brutal Haymaker should be tested tank POV
--Fel vomit cd reduces on every cast 0.64~ multiplier still could be tested a few more tries
local mod, CL = BigWigs:NewBoss("Smashspite", 1081, 1664)
if not mod then return end
mod:RegisterEnableMob(98949)

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
		198079, -- Hateful Gaze
		198446, -- Fel Vomit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FelVomit", 198446)
	self:Log("SPELL_CAST_SUCCESS", "EarthshakingStomp", 198073)
	self:Log("SPELL_CAST_SUCCESS", "HatefulGaze", 198079)
	self:Log("SPELL_CAST_START", "BrutalHaymaker", 198245)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 98949)
end

function mod:OnEngage()
	felVomitCD = 35
	self:Bar(198079, 5.8) -- Hateful Gaze
	self:Bar(198073, 13.1) -- Earthshaking Stomp
	self:Bar(198446, felVomitCD) -- Fel Vomit
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BrutalHaymaker(args)
	if self:Tank() then
		self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
	end
end

function mod:EarthshakingStomp(args)
	self:Bar(args.spellId, 24.3)
end

function mod:HatefulGaze(args)
	self:Bar(args.spellId, 25.4)
end

function mod:FelVomit(args)
	self:Message(args.spellId, "Attention", "Info", CL.incoming:format(args.spellName))
	felVomitCD = felVomitCD * 0.64
	self:CDBar(args.spellId, felVomitCD)
end

