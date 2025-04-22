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

local azeriteInfusionMarker = mod:AddMarkerOption(true, "npc_aura", 8, 271698, 8) -- Azerite Infusion
function mod:GetOptions()
	return {
		271698, -- Azerite Infusion
		azeriteInfusionMarker,
		258622, -- Resonant Quake
		257593, -- Call Earthrager
		{257582, "SAY", "NAMEPLATE"}, -- Raging Gaze
		275907, -- Tectonic Smash
	}, {
		[257582] = CL.fixate, -- Raging Gaze (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AzeriteInfusionCheck", 257596)
	self:Log("SPELL_CAST_START", "AzeriteInfusion", 271698)
	self:Log("SPELL_CAST_SUCCESS", "AzeriteInfusionSuccess", 271698)
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
	self:CDBar(271698, 5.2) -- Azerite Infusion
	self:CDBar(275907, 12.1) -- Tectonic Smash
	self:CDBar(258622, 32.7, CL.count:format(self:SpellName(258622), resonantQuakeCount)) -- Resonant Quake
	self:CDBar(257593, 40.2) -- Call Earthrager
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AzeriteInfusionCheck()
	-- the timer for Azerite Infusion is based off of 257596, but if there are no Earthragers alive
	-- then 271698 won't be cast.
	self:CDBar(271698, 41.3) -- Azerite Infusion
end

function mod:AzeriteInfusion(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

do
	local azeriteInfusionGUID = nil

	function mod:AzeriteInfusionSuccess(args)
		if self:GetOption(azeriteInfusionMarker) then
			azeriteInfusionGUID = args.destGUID
			self:RegisterTargetEvents("MarkAzeriteInfusion")
		end
	end

	function mod:MarkAzeriteInfusion(_, unit, guid)
		if azeriteInfusionGUID == guid then
			azeriteInfusionGUID = nil
			self:CustomIcon(azeriteInfusionMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:ResonantQuake(args)
	self:StopBar(CL.count:format(args.spellName, resonantQuakeCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, resonantQuakeCount))
	resonantQuakeCount = resonantQuakeCount + 1
	self:CDBar(args.spellId, 40.1, CL.count:format(args.spellName, resonantQuakeCount))
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
	self:CDBar(args.spellId, 41.2)
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
	if tectonicSmashCount % 2 == 0 then
		self:CDBar(args.spellId, 15.4)
	elseif tectonicSmashCount == 3 then
		self:CDBar(args.spellId, 24.3)
	else
		self:CDBar(args.spellId, 26.7)
	end
	self:PlaySound(args.spellId, "alarm")
end
