--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harbinger Ul'thul", 2815)
if not mod then return end
mod:RegisterEnableMob(234339) -- Harbinger Ul'thul
mod:SetEncounterID(3096)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.harbinger_ulthul = "Harbinger Ul'thul"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.harbinger_ulthul
	self:SetSpellRename(1213776, CL.curse) -- Hopeless Curse (Curse)
end

function mod:GetOptions()
	return {
		{1213776, "DISPEL"}, -- Hopeless Curse
		1213785, -- Tear It Down
		{1213700, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE", "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Unanswered Call
	},nil,{
		[1213776] = CL.curse, -- Hopeless Curse (Curse)
		[1213700] = CL.fixate, -- Unanswered Call (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HopelessCurse", 1213776)
	self:Log("SPELL_AURA_APPLIED", "HopelessCurseApplied", 1213776)
	self:Log("SPELL_CAST_START", "TearItDown", 1213785)
	self:Log("SPELL_CAST_START", "UnansweredCall", 1213700)
	self:Log("SPELL_AURA_APPLIED", "UnansweredCallApplied", 1213838)
	self:Log("SPELL_AURA_REMOVED", "UnansweredCallRemoved", 1213838)
end

function mod:OnEngage()
	self:CDBar(1213776, 4.7, CL.curse) -- Hopeless Curse
	self:CDBar(1213785, 9.5) -- Tear It Down
	self:CDBar(1213700, 30.4, CL.fixate) -- Unanswered Call
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
	self:CDBar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "info")
end

do
	local prev = nil
	local function printTarget(self, name, guid, elapsed)
		prev = guid
		self:TargetMessage(1213700, "red", name, CL.fixate)
		if self:Me(guid) then
			self:Say(1213700, CL.fixate, nil, "Fixate")
			self:CastBar(1213700, 5-elapsed, CL.fixate)
			self:PlaySound(1213700, "warning", nil, name)
		else
			self:PlaySound(1213700, "alarm", nil, name)
		end
	end

	function mod:UnansweredCall(args)
		prev = nil
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:CDBar(args.spellId, 33.9, CL.fixate)
	end

	function mod:UnansweredCallApplied(args)
		if self:Me(args.destGUID) then
			self:SayCountdown(1213700, 8)
			if not prev or prev ~= args.destGUID then
				self:PersonalMessage(1213700, nil, CL.fixate)
				self:Say(1213700, CL.fixate, nil, "Fixate")
				self:PlaySound(1213700, "warning", nil, args.destGUID)
			end
		end
		self:CastBar(1213700, 8, CL.fixate)
	end

	function mod:UnansweredCallRemoved(args)
		prev = nil
		self:StopCastBar(CL.fixate)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(1213700)
		end
	end
end
