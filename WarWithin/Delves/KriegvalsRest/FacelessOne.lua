--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Faceless One Kriegval's Rest", 2681)
if not mod then return end
mod:RegisterEnableMob(244498) -- Faceless One
mod:SetEncounterID(3284)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.faceless_one = "Faceless One"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.faceless_one
	self:SetSpellRename(1213776, CL.curse) -- Hopeless Curse (Curse)
	self:SetSpellRename(1213700, CL.fixate) -- Unanswered Call (Fixate)
	self:SetSpellRename(1213838, CL.fixate) -- Unanswered Call (Fixate)
end

function mod:GetOptions()
	return {
		{1213776, "DISPEL"}, -- Hopeless Curse
		1213785, -- Tear it Down
		{1213700, "ME_ONLY_EMPHASIZE", "CASTBAR", "CASTBAR_COUNTDOWN", "SAY", "SAY_COUNTDOWN"}, -- Unanswered Call
	}, nil, {
		[1213776] = CL.curse, -- Hopeless Curse (Curse)
		[1213700] = CL.fixate, -- Unanswered Call (Fixate)
	}
end

function mod:OnBossEnable()
	-- this boss likely has the same encounter script as Harbinger Ul'thul from Excavation Site 9
	self:Log("SPELL_CAST_START", "HopelessCurse", 1213776)
	self:Log("SPELL_AURA_APPLIED", "HopelessCurseApplied", 1213776)
	self:Log("SPELL_CAST_START", "TearItDown", 1213785)
	self:Log("SPELL_CAST_SUCCESS", "TearItDownSuccess", 1213785)
	self:Log("SPELL_CAST_START", "UnansweredCall", 1213700)
	self:Log("SPELL_AURA_APPLIED", "UnansweredCallApplied", 1213838)
	self:Log("SPELL_AURA_REMOVED", "UnansweredCallRemoved", 1213838)
end

function mod:OnEngage()
	self:CDBar(1213776, 4.5, CL.curse) -- Hopeless Curse
	self:CDBar(1213785, 5.7) -- Tear it Down
	self:CDBar(1213700, 31.2, CL.fixate) -- Unanswered Call
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HopelessCurse(args)
	self:Message(args.spellId, "orange", CL.casting:format(CL.curse))
	self:CDBar(args.spellId, 21.1, CL.curse)
	self:PlaySound(args.spellId, "alert")
end

function mod:HopelessCurseApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName, CL.curse)
		if self:Dispeller("curse") then
			self:PlaySound(args.spellId, "warning", nil, args.destName)
		else
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:TearItDown(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:TearItDownSuccess(args)
	self:CDBar(args.spellId, 10.0)
end

function mod:UnansweredCall(args)
	self:Message(args.spellId, "red", CL.custom_sec:format(CL.fixate, 5))
	self:CDBar(args.spellId, 33.9, CL.fixate)
	self:CastBar(args.spellId, 5, CL.fixate)
	self:PlaySound(args.spellId, "warning")
end

function mod:UnansweredCallApplied(args)
	self:TargetMessage(1213700, "red", args.destName, CL.fixate)
	self:CastBar(1213700, 8, CL.fixate)
	if self:Me(args.destGUID) then
		self:Say(1213700, CL.fixate, nil, "Fixate")
		self:SayCountdown(1213700, 8)
		self:PlaySound(1213700, "warning", nil, args.destName)
	else
		self:PlaySound(1213700, "alarm", nil, args.destName)
	end
end

function mod:UnansweredCallRemoved(args)
	self:StopCastBar(CL.fixate)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(1213700)
	end
end
