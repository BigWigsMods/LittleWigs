if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tik'ali", 1594, 2114)
if not mod then return end
mod:RegisterEnableMob(129227)
mod.engageId = 2106

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		257593, -- Call Earthrager
		{257582, "SAY"}, -- Raging Gaze
		271698, -- Azerite Infusion
		258622, -- Resonant Pulse
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallEarthrager", 257593)
	self:Log("SPELL_AURA_APPLIED", "RagingGaze", 257582)
	self:Log("SPELL_CAST_SUCCESS", "AzeriteInfusion", 271698)
	self:Log("SPELL_CAST_START", "ResonantPulse", 258622)
end

function mod:OnEngage()
	self:Bar(258622, 9.5) -- Resonant Pulse
	self:Bar(271698, 20) -- Azerite Infusion
	self:Bar(257593, 64) -- Call Earthrager
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallEarthrager(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "mobsoon")
	--self:Bar(args.spellId, 64) -- XXX Only seen it once
end

do
	local playerList = mod:NewTargetList()
	function mod:RagingGaze(args)
		playerList[#playerList+1] = args.destName
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning", "fixate")
			self:Say(args.spellId)
		end
		self:TargetsMessage(args.spellId, "red", playerList)
	end
end

function mod:AzeriteInfusion(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "killmob")
	self:Bar(args.spellId, 17)
end

function mod:ResonantPulse(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long", "aesoon")
	self:Bar(args.spellId, 34)
end
