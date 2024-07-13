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
		460764, -- Mannoroth's Fury
		{460756, "DISPEL"}, -- Sleep
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VeilOfShadow", 460755)
	self:Log("SPELL_CAST_SUCCESS", "MannorothsFury", 460764)
	self:Log("SPELL_AURA_APPLIED", "SleepApplied", 460756) -- Stage 1 Sleep (single target)
	self:Log("SPELL_CAST_SUCCESS", "Sleep", 462058) -- Stage 2 Sleep (entire group)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(460755, 11.3) -- Veil of Shadow
	self:CDBar(460756, 24.3) -- Sleep
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VeilOfShadow(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 22.6)
end

function mod:MannorothsFury(args)
	self:StopBar(460755) -- Veil of Shadow
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.other:format(CL.stage:format(2), args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:SleepApplied(args)
	if self:Dispeller("magic", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:CDBar(args.spellId, 23.9)
end

function mod:Sleep(args)
	self:Message(460756, "yellow", CL.on_group:format(args.spellName))
	self:PlaySound(460756, "alert")
	self:CDBar(460756, 38.4)
end
