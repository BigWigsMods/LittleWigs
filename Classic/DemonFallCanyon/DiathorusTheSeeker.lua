--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Diathorus the Seeker", 2784)
if not mod then return end
mod:RegisterEnableMob(227019) -- Diathorus the Seeker
mod:SetEncounterID(3024)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.diathorus_the_seeker = "Diathorus the Seeker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.diathorus_the_seeker
end

function mod:GetOptions()
	return {
		460755, -- Veil of Shadow
		"stages",
		460756, -- Sleep
		460766, -- Berserker Charge
	},nil,{
		[460755] = CL.plus:format(CL.curse, CL.interruptible), -- Veil of Shadow (Curse + Interruptible)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VeilOfShadow", 460755)
	self:Log("SPELL_INTERRUPT", "VeilOfShadowInterrupted", "*")
	self:Log("SPELL_CAST_SUCCESS", "MannorothsFury", 460764)
	self:Log("SPELL_AURA_APPLIED", "SleepApplied", 460756) -- Stage 1 Sleep (single target)
	self:Log("SPELL_CAST_SUCCESS", "Sleep", 462058) -- Stage 2 Sleep (entire group)
	self:Log("SPELL_CAST_SUCCESS", "BerserkerCharge", 460766)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(460755, 11.3, CL.curse) -- Veil of Shadow
	self:CDBar(460756, 24.3) -- Sleep
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VeilOfShadow(args)
	self:Message(args.spellId, "red", CL.extra:format(CL.incoming:format(CL.curse), CL.interruptible))
	self:CDBar(args.spellId, 22.6, CL.curse)
	self:PlaySound(args.spellId, "alarm")
end

function mod:VeilOfShadowInterrupted(args)
	if args.extraSpellName == self:SpellName(460755) then
		self:Message(460755, "green", CL.interrupted_by:format(CL.curse, self:ColorName(args.sourceName)))
	end
end

function mod:MannorothsFury(args)
	self:StopBar(CL.curse) -- Veil of Shadow
	self:SetStage(2)
	self:Message("stages", "cyan", CL.other:format(CL.stage:format(2), args.spellName), args.spellId)
	self:PlaySound("stages", "long")
end

function mod:SleepApplied(args) -- Stage 1 Sleep (single target)
	self:CDBar(args.spellId, 23.9)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:Sleep(args) -- Stage 2 Sleep (entire group)
	self:Message(460756, "yellow", CL.on_group:format(args.spellName))
	self:CDBar(460756, 38.4)
	self:PlaySound(460756, "alert")
end

function mod:BerserkerCharge(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:Bar(args.spellId, 11.4)
	self:PlaySound(args.spellId, "info")
end
