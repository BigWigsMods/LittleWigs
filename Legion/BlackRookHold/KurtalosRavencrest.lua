--------------------------------------------------------------------------------
-- Module Declaration
--
--TO DO List
--Timers work fine couldnt test Say mechanic stinging swarm due to rng targetting.
local mod, CL = BigWigs:NewBoss("Kurtalos Ravencrest", 1081, 1672)
if not mod then return end
mod:RegisterEnableMob(98965, 98970)
--------------------------------------------------------------------------------
-- Locals
--
local ShadowBoltCount = 1;
--------------------------------------------------------------------------------
-- Initialization
--
function mod:GetOptions()
  return {
    {198635, "TANK"}, --Unerring Sheer
    198820, --Dark Blast
    198641, --Whirling Blade
    199193, -- Dreadlords Guise
    202019, --Shadow Bolt Valley Care first one!!
    {201733, "SAY"}, --Stinging Swarm
    199143  --Cloud of Hypnosis
  }
end

function mod:OnBossEnable()
  self:Log("SPELL_CAST_START", "DarkBlast", 198820)
  self:Log("SPELL_CAST_START", "WhirlingBlade", 198641)
  self:Log("SPELL_CAST_START", "ShadowBoltValley", 202019)
  self:Log("SPELL_CAST_START", "StingingSwarm", 201733)
  self:Log("SPELL_CAST_SUCCESS", "CloudOfHypnosis", 199143)
  self:Log("SPELL_CAST_START", "DreadlordsGuise", 199193)
  self:Log("SPELL_AURA_APPLIED", "StingingSwarmApplied", 201733)
  self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:OnEngage()
  ShadowBoltCount = 1;
  self:CDBar(198635,5.5)
  self:CDBar(198641,11)
  self:CDBar(198641,12)
end
--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:DarkBlast(args)
  self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
end

function mod:WhirlingBlade(args)
  self:Message(args.spellId, "Attention", "Info", CL.incoming:format(args.spellName))
end

function mod:ShadowBoltValley(args)
  if ShadowBoltCount == 1 then
    self:Message(args.spellId, "Important", "Warning", CL.incoming:format(args.spellName))
  else
    self:Message(args.spellId, "Attention", "Info", CL.incoming:format(args.spellName))
  end
  self:Bar(args.spellId, 8.5)
  ShadowBoltCount = ShadowBoltCount + 1
end

function mod:DreadlordsGuise(args)
  self:StopBar(201733)
  self:StopBar(198641)
  self:StopBar(202019)
  self:StopBar(199143)
  if mod:Mythic() then
    self:Bar(args.spellId, 22) -- 27 on normal
    self:ScheduleTimer("CDBar", 22, 201733, 5,5)
  else
    self:Bar(args.spellId, 27) -- longer than 23 on Norm/hc
  end
end

function mod:CloudOfHypnosis(args)
  self:Bar(args.spellId, 30.8)
end

function mod:StingingSwarm(args)
  self:CDBar(args.spellId, 17)
end

function mod:StingingSwarmApplied(args)
  if self:Me(args.destGUID) then
    self:Say(args.spellName)
  end
end
