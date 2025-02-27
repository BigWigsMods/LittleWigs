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
end

function mod:GetOptions()
	return {
		{1213776, "DISPEL"}, -- Hopeless Curse
		1213785, -- Tear It Down
		1213700, -- Unanswered Call
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HopelessCurse", 1213776)
	self:Log("SPELL_AURA_APPLIED", "HopelessCurseApplied", 1213776)
	self:Log("SPELL_CAST_START", "TearItDown", 1213785)
	self:Log("SPELL_CAST_START", "UnansweredCall", 1213700)
	self:Log("SPELL_AURA_APPLIED", "UnansweredCallApplied", 1213838)
end

function mod:OnEngage()
	self:CDBar(1213776, 4.7) -- Hopeless Curse
	self:CDBar(1213785, 9.5) -- Tear It Down
	self:CDBar(1213700, 30.4) -- Unanswered Call
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HopelessCurse(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 21.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:HopelessCurseApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
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

function mod:UnansweredCall(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 33.9)
	self:PlaySound(args.spellId, "alarm")
end

function mod:UnansweredCallApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(1213700)
		self:PlaySound(1213700, "warning")
	end
end
