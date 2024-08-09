--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mistcaller", 2290, 2402)
if not mod then return end
mod:RegisterEnableMob(164501) -- Mistcaller
mod:SetEncounterID(2392)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local guessingGameHp = 100

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vulpin = "Vulpin"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		336499, -- Guessing Game
		321834, -- Dodge Ball
		{321828, "ME_ONLY_EMPHASIZE"}, -- Patty Cake
		341709, -- Freeze Tag
		{321891, "SAY", "ME_ONLY_EMPHASIZE"}, -- Freeze Tag Fixation
	},nil,{
		[341709] = L.vulpin, -- Freeze Tag (Vulpin)
		[321891] = CL.fixate, -- Freeze Tag Fixation (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GuessingGame", 336499, 321471) -- Mythic, Heroic/Normal
	self:Log("SPELL_CAST_START", "DodgeBall", 321834)
	self:Log("SPELL_CAST_START", "PattyCake", 321828)
	self:Log("SPELL_CAST_START", "FreezeTag", 341709)
	self:Log("SPELL_AURA_APPLIED", "FreezeTagFixation", 321891)
end

function mod:OnEngage()
	guessingGameHp = 100
	self:CDBar(321834, 6.0) -- Dodge Ball
	self:CDBar(321828, 13.1) -- Patty Cake
	self:CDBar(341709, 17.0, L.vulpin) -- Freeze Tag
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GuessingGame(args)
	guessingGameHp = guessingGameHp - 30 -- 70, 40, 10
	self:Message(336499, "cyan", CL.percent:format(guessingGameHp, args.spellName))
	self:PlaySound(336499, "long")
end

function mod:DodgeBall(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 13.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:PattyCake(args)
	self:CDBar(args.spellId, 20.6)
	local bossUnit = self:GetBossId(args.sourceGUID)
	if bossUnit and self:Tanking(bossUnit) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:FreezeTag(args)
	self:Message(args.spellId, "yellow", CL.incoming:format(L.vulpin))
	self:CDBar(args.spellId, 21.8, L.vulpin)
	self:PlaySound(args.spellId, "alert")
end

function mod:FreezeTagFixation(args)
	self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId, CL.fixate, nil, "Fixate")
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
