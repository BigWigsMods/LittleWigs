--------------------------------------------------------------------------------
-- Module Declaration
--
local mod, CL = BigWigs:NewBoss("Smashspite", 1081, 1664)
if not mod then return end
mod:RegisterEnableMob(98949)
--------------------------------------------------------------------------------
-- Locals
--
local FelVomitCD = 35
--------------------------------------------------------------------------------
-- Initialization
--
function mod:GetOptions()
	return {
		198073, --Earthshaking stomp-25.4
		{198245, "TANK"}, --Brutal Haymaker nvm the cd probably wont proc twice
    	198079, --Hateful Gaze 25.4
    	198446, --Fel Vomit 33.8 after pull 33.8 22.8 15.4 10.3
	}
end

function mod:OnBossEnable()
  self:Log("SPELL_CAST_START", "FelVomit", 198446)
  self:Log("SPELL_CAST_SUCCESS", "EarthshakingStomp", 198073)
  self:Log("SPELL_CAST_SUCCESS", "HatefulGaze", 198079)
  self:Log("SPELL_CAST_START", "BrutalHaymaker", 198245)
  self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
  self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
  self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

function mod:OnEngage()
	FelVomitCD = 35
  self:Bar(198079, 5.8)
  self:Bar(198073, 13.1)
	self:Bar(198446, FelVomitCD)
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
  FelVomitCD = FelVomitCD * 0.67
  self:CDBar(args.spellId, FelVomitCD)
end
