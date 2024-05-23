--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Instructor Chillheart", 1007, 659)
if not mod then return end
mod:RegisterEnableMob(58633) -- Instructor Chillheart
mod:SetEncounterID(1426)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locales
--

local L = mod:GetLocale()
if L then
	L["111209_desc"] = -5515 -- Frigid Grasp
	L["111441_icon"] = "inv_misc_urn_01"
	L["111441_desc"] = -5516 -- Stage Two: Second Lesson
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Stage One: First Lesson
		111854, -- Ice Wave
		111631, -- Wrack Soul
		{111610, "SAY", "ME_ONLY_EMPHASIZE"}, -- Ice Wrath
		111209, -- Frigid Grasp
		-- Stage Two: Second Lesson
		111441, -- Fill Phylactery
	}, {
		[111854] = -5524, -- Stage One: First Lesson
		[111441] = -5516, -- Stage Two: Second Lesson
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Fill Phylactery, Frigid Grasp
	self:Log("SPELL_CAST_START", "IceWave", 111854)
	self:Log("SPELL_AURA_APPLIED", "WrackSoulApplied", 111631)
	self:Log("SPELL_CAST_SUCCESS", "IceWrath", 111610)
	self:Log("SPELL_AURA_APPLIED", "IceWrathApplied", 111610)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(111209, 10.6) -- Frigid Grasp
	self:CDBar(111610, 19.5) -- Ice Wrath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 111209 then -- Frigid Grasp
		self:Message(spellId, "orange")
		self:PlaySound(spellId, "alarm")
		self:CDBar(spellId, 10.9)
	elseif spellId == 111441 then -- Fill Phylactery
		self:StopBar(111610) -- Ice Wrath
		self:StopBar(111209) -- Frigid Grasp
		self:SetStage(2)
		self:Message(spellId, "cyan", nil, L["111441_icon"])
		self:PlaySound(spellId, "long")
	end
end

function mod:IceWave(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:WrackSoulApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:IceWrath(args)
	self:CDBar(args.spellId, 17.0)
end

function mod:IceWrathApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Ice Wrath")
	end
end
