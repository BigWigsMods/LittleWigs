if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tik'ali", 1594, 2114)
if not mod then return end
mod:RegisterEnableMob(131225, 129227) -- XXX Wont need Both
mod.engageId = 2106

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		257593, -- Call Earthrager
		{257582, "SAY"}, -- Raging Gaze
		257597, -- Azerite Infusion
		258622, -- Resonant Pulse
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallEarthrager", 257593)
	self:Log("SPELL_AURA_APPLIED", "RagingGaze", 257582)
	self:Log("SPELL_CAST_START", "AzeriteInfusion", 257597)
	self:Log("SPELL_CAST_START", "ResonantPulse", 258622)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallEarthrager(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "mobsoon")
end

function mod:RagingGaze(args)
	self:TargetMessage(args.spellId, args.destName, "red")
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", "fixate")
		self:Say(args.spellId)
	end
end

function mod:AzeriteInfusion(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "killmob")
end

function mod:ResonantPulse(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long", "aesoon")
end
