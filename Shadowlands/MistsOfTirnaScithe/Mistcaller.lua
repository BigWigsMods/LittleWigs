
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mistcaller", 2290, 2402)
if not mod then return end
mod:RegisterEnableMob(164501) -- Mistcaller
mod.engageId = 2392
--mod.respawnTime = 30

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
	self:CDBar(321834, 7) -- Dodge Ball
	self:CDBar(321828, 13.7) -- Patty Cake
	self:CDBar(341709, 18.1, L.vulpin) -- Freeze Tag
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
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 13.5)
end

function mod:PattyCake(args)
	local bossUnit = self:GetBossId(args.sourceGUID)
	if bossUnit and self:Tanking(bossUnit) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "warning")
	end
	self:CDBar(args.spellId, 19.3) -- 19-23
end

function mod:FreezeTag(args)
	self:Message(args.spellId, "yellow", CL.incoming:format(L.vulpin))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23, L.vulpin)
end

function mod:FreezeTagFixation(args)
	self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId)
	end
end
