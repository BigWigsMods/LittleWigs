local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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
-- Locals
--

local resonantQuakeCount = 1
local tectonicSmashCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self:SetSpellRename(257582, CL.fixate) -- Raging Gaze (Fixate)
end

function mod:GetOptions()
	return {
		271698, -- Azerite Infusion
		258622, -- Resonant Quake
		257593, -- Call Earthrager
		{257582, "SAY", "NAMEPLATE"}, -- Raging Gaze
		275907, -- Tectonic Smash
	}, {
		[257582] = CL.fixate, -- Raging Gaze (Fixate)
	}
end

function mod:OnBossEnable()
	if isElevenDotOne then
		self:Log("SPELL_CAST_SUCCESS", "AzeriteInfusionCheck", 257596)
		self:Log("SPELL_CAST_START", "AzeriteInfusion", 271698)
	else -- XXX remove in 11.1
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- for Azerite Infusion timer
		self:Log("SPELL_CAST_SUCCESS", "AzeriteInfusion", 271698)
	end
	self:Log("SPELL_CAST_START", "ResonantQuake", 258622)
	self:Log("SPELL_PERIODIC_DAMAGE", "ResonantQuakeDamage", 258628)
	self:Log("SPELL_PERIODIC_MISSED", "ResonantQuakeDamage", 258628)
	self:Log("SPELL_CAST_START", "CallEarthrager", 257593)
	self:Log("SPELL_AURA_APPLIED", "RagingGazeApplied", 257582)
	self:Log("SPELL_AURA_REMOVED", "RagingGazeRemoved", 257582)
	self:Log("SPELL_CAST_START", "TectonicSmash", 275907)
end

function mod:OnEngage()
	resonantQuakeCount = 1
	tectonicSmashCount = 1
	if isElevenDotOne then
		-- XXX on 11.1 PTR the Dungeon Journal says Azerite Infusion is Heroic+ but it's still cast in Normal
		self:CDBar(271698, 5.2) -- Azerite Infusion
		self:CDBar(275907, 12.1) -- Tectonic Smash
		self:CDBar(258622, 32.7, CL.count:format(self:SpellName(258622), resonantQuakeCount)) -- Resonant Quake
		self:CDBar(257593, 40.2) -- Call Earthrager
	else -- XXX remove in 11.1
		self:Bar(258622, 9.5, CL.count:format(self:SpellName(258622), resonantQuakeCount)) -- Resonant Pulse
		self:Bar(271698, 20) -- Azerite Infusion
		self:Bar(257593, 64) -- Call Earthrager
		if not self:Normal() then
			self:Bar(275907, 5) -- Tectonic Smash
		end
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId) -- XXX remove in 11.1
	if spellId == 257596 then -- Azerite Infusion
		-- the timer for Azerite Infusion is based off of 257596, but if there are no Earthragers alive
		-- then 271698 won't be cast.
		self:CDBar(271698, 17) -- Azerite Infusion
	end
end

function mod:AzeriteInfusionCheck()
	-- the timer for Azerite Infusion is based off of 257596, but if there are no Earthragers alive
	-- then 271698 won't be cast.
	self:CDBar(271698, 41.3) -- Azerite Infusion
end

function mod:AzeriteInfusion(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:ResonantQuake(args)
	self:StopBar(CL.count:format(args.spellName, resonantQuakeCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, resonantQuakeCount))
	resonantQuakeCount = resonantQuakeCount + 1
	if isElevenDotOne then
		self:CDBar(args.spellId, 40.1, CL.count:format(args.spellName, resonantQuakeCount))
	else -- XXX remove in 11.1
		self:CDBar(args.spellId, 34, CL.count:format(args.spellName, resonantQuakeCount))
	end
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:ResonantQuakeDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(258622, "underyou")
			self:PlaySound(258622, "underyou")
		end
	end
end

function mod:CallEarthrager(args)
	self:Message(args.spellId, "cyan")
	if isElevenDotOne then
		self:CDBar(args.spellId, 41.2)
	--else -- XXX remove in 11.1
		-- The boss casts "Set Energy to 0" (280479) every 60 sec.
		-- There is a chance that the boss will cast Call Earthrager afterwards,
		-- but it is not guaranteed, so a timer for this can't be accurate.
	end
	self:PlaySound(args.spellId, "info")
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
			if t - prev > 1.5 then -- you can be fixated more than once
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

function mod:TectonicSmash(args)
	self:Message(args.spellId, "red")
	tectonicSmashCount = tectonicSmashCount + 1
	if isElevenDotOne then
		if tectonicSmashCount % 2 == 0 then
			self:CDBar(args.spellId, 15.4)
		elseif tectonicSmashCount == 3 then
			self:CDBar(args.spellId, 24.3)
		else
			self:CDBar(args.spellId, 26.7)
		end
	else -- XXX remove in 11.1
		self:CDBar(args.spellId, 21)
	end
	self:PlaySound(args.spellId, "alarm")
end
