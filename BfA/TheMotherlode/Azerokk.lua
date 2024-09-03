--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Azerokk", 1594, 2114)
if not mod then return end
mod:RegisterEnableMob(
	129227, -- Azerokk
	129802 -- Earthrager
)
mod:SetEncounterID(2106)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self:SetSpellRename(257582, CL.fixate) -- Raging Gaze (Fixate)
end

function mod:GetOptions()
	return {
		-- General
		271698, -- Azerite Infusion
		258622, -- Resonant Pulse
		257593, -- Call Earthrager
		{257582, "SAY", "NAMEPLATE"}, -- Raging Gaze
		-- Heroic
		275907, -- Tectonic Smash
	}, {
		[271698] = "general",
		[275907] = "heroic",
	}, {
		[257582] = CL.fixate, -- Raging Gaze (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallEarthrager", 257593)
	self:Log("SPELL_AURA_APPLIED", "RagingGazeApplied", 257582)
	self:Log("SPELL_AURA_REMOVED", "RagingGazeRemoved", 257582)
	self:Log("SPELL_CAST_SUCCESS", "AzeriteInfusion", 271698)
	self:Log("SPELL_CAST_START", "ResonantPulse", 258622)
	self:Log("SPELL_CAST_START", "TectonicSmash", 275907)
end

function mod:OnEngage()
	self:Bar(258622, 9.5) -- Resonant Pulse
	self:Bar(271698, 20) -- Azerite Infusion
	self:Bar(257593, 64) -- Call Earthrager
	if not self:Normal() then
		self:Bar(275907, 5) -- Tectonic Smash
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallEarthrager(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "mobsoon")
	-- The boss casts "Set Energy to 0" (280479) every 60 sec.
	-- There is a chance that the boss will cast Call Earthrager afterwards,
	-- but it is not guaranteed, so a timer for this can't be accurate.
end

do
	local playerList = {}
	local prev = 0
	function mod:RagingGazeApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 4, CL.fixate)
		if self:Me(args.destGUID) then
			self:Nameplate(args.spellId, 60, args.sourceGUID, CL.fixate)
			local t = args.time
			if t - prev > 1 then -- you can be fixated more than once
				prev = t
				self:PlaySound(args.spellId, "warning")
				self:Say(args.spellId, CL.fixate, nil, "Fixate")
			end
		end
	end
end

function mod:RagingGazeRemoved(args)
	if self:Me(args.destGUID) then
		self:StopNameplate(args.spellId, args.sourceGUID, CL.fixate)
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

function mod:TectonicSmash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21)
end
