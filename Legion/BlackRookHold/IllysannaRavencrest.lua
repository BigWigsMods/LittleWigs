--------------------------------------------------------------------------------
-- Module Declaration
--
--TO do List Eye beam is completely missing in transcriptor logs in any means ??
--Dark Rush and Eye beam Say's should be Tested
--Arcane blitz warning message could be changed into "Interrupt (sourceGuid)"
local mod, CL = BigWigs:NewBoss("Illysanna Ravencrest", 1081, 1653)
if not mod then return end
mod:RegisterEnableMob(98696)
--------------------------------------------------------------------------------
-- Initialization
--
function mod:GetOptions()
	return {
	{197418, "TANK"}, --Vengeful Shear
	{197478, "SAY"}, --Dark Rush --
	197546, --Brutal Glaive
	197797, --Arcane Blitz
	197974, --Bonecrushing Strike
	{197696, "SAY"}, --Eye Beam
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BrutalGlaive", 197546)
	self:Log("SPELL_CAST_SUCCESS", "VengefulShear", 197418)
	self:Log("SPELL_CAST_START", "ArcaneBlitz", 197797)
	self:Log("SPELL_CAST_START", "BonecrushingStrike", 197974)
	self:Log("SPELL_AURA_APPLIED", "DarkRushApplied",197478)
	self:Log("SPELL_AURA_APPLIED", "EyeBeams", 197687)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 98696)
end

function mod:OnEngage()
	self:Bar(197546, 5.5)
	self:Bar(197418, 8.3)
	self:CDBar(197478, 14.8)
end
--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:BrutalGlaive(args) -- add timer
	self:CDBar(args.spellId, 14.5)
	self:StopBar(197696)
end

function mod:DarkRushApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellName)
	end
end

function mod:VengefulShear(args)
	self:CDBar(args.spellId, 11)
end

function mod:EyeBeams(args) -- eye beam missing timer xxx fix this
	self:StopBar(197546)
	self:StopBar(197418)
	self:Bar(197696, 15)
	if self:Me(args.destGUID) then
		self:Say(args.spellName)
	end
end

function mod:ArcaneBlitz(args)
	self:Message(args.spellId, "Alarm", self:Interrupter(args.sourceGUID))
end

function mod:BonecrushingStrike(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end
