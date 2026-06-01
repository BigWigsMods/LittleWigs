--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Degentrius", 2811, 2662)
if not mod then return end
mod:SetEncounterID(3074)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1215161, sound = "none", note = CL.other:format(CL.bouncing_ball, CL.debuffFailureNote)}, -- Void Destruction
	{1215897, sound = "warning", note = CL.orbs}, -- Devouring Entropy
	{1269631, sound = "none", note = CL.other:format(CL.orbs , CL.debuffFailureNote)}, -- Entropy Orb
	{1284627, sound = "none", note = CL.debuffTankAfterCastNote:format(CL.extra:format(mod:SpellName(1280113), CL.tank_debuff))}, -- Umbral Splinters
	{1284633, sound = "underyou", note = CL.debuffUnderYouNote}, -- Stygian Ichor
})

--------------------------------------------------------------------------------
-- Locals
--

local hulkingFragmentCount = 1
local devouringEntropyCount = 1
local unstableVoidEssenceCount = 1
local count24 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1280113] = {CL.tank_debuff}, -- Hulking Fragment (Tank Debuff)
	[1215897] = { -- Devouring Entropy (Debuffs (Orbs))
		CL.extra:format(CL.debuffs, CL.orbs), CL.you:format(CL.orbs),
		notes = {CL.generalNote, CL.messageOnYouNote},
		original = {1215897, CL.you:format(mod:SpellName(1215897))}
	},
	[1215087] = { -- Unstable Void Essence (Bouncing Ball)
		CL.bouncing_ball, CL.incoming:format(CL.bouncing_ball),
		notes = {CL.generalNote, CL.messageCastStartNote},
		original = {1215087, CL.incoming:format(mod:SpellName(1215087))}
	},
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1280113, -- Hulking Fragment
		{1215897, "ME_ONLY_EMPHASIZE"}, -- Devouring Entropy
		1215087, -- Unstable Void Essence
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	hulkingFragmentCount = 1
	devouringEntropyCount = 1
	unstableVoidEssenceCount = 1
	count24 = 1
	activeBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if self:Mythic() then
		if duration == 3 or ((duration == 24 or duration == 22) and count24 % 3 == 1) then -- Hulking Fragment
			barInfo = self:HulkingFragmentTimeline(eventInfo)
		elseif duration == 9 or ((duration == 24 or duration == 22) and count24 % 3 == 2) then -- Devouring Entropy
			barInfo = self:DevouringEntropyTimeline(eventInfo)
		elseif duration == 15 or ((duration == 24 or duration == 22) and count24 % 3 == 0) then -- Unstable Void Essence
			barInfo = self:UnstableVoidEssenceTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
		end
		-- TODO presumed hotfix 22 -> 24, confirm and clean up old timer
		if duration == 24 or duration == 22 then
			count24 = count24 + 1
		end
	else -- Normal
		if duration == 7 or duration == 15 then -- Hulking Fragment
			barInfo = self:HulkingFragmentTimeline(eventInfo)
		elseif duration == 13 or duration == 20 then -- Devouring Entropy
			barInfo = self:DevouringEntropyTimeline(eventInfo)
		elseif duration == 16 or duration == 31 then -- Unstable Void Essence
			barInfo = self:UnstableVoidEssenceTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
		end
	end
	if barInfo then
		activeBars[eventInfo.id] = barInfo
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		local state = C_EncounterTimeline.GetEventState(eventID)
		if state == 0 then -- Active
			self:ResumeBar(barInfo.key, barInfo.msg)
		elseif state == 1 then -- Paused
			self:PauseBar(barInfo.key, barInfo.msg)
		elseif state == 2 then -- Finished
			self:StopBar(barInfo.msg)
			if barInfo.callback then
				barInfo.callback()
			end
			activeBars[eventID] = nil
		elseif state == 3 then -- Canceled
			self:StopBar(barInfo.msg)
			activeBars[eventID] = nil
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_REMOVED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		self:StopBar(barInfo.msg)
		activeBars[eventID] = nil
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:HulkingFragmentTimeline(eventInfo) -- Tank Debuff
	local barText = CL.count:format(self:GetRename(1280113), hulkingFragmentCount)
	self:CDBar(1280113, eventInfo.duration, barText, nil, eventInfo.id)
	hulkingFragmentCount = hulkingFragmentCount + 1
	return {
		msg = barText,
		key = 1280113,
		callback = function()
			self:Message(1280113, "purple", barText)
			self:PlaySound(1280113, "alarm")
		end
	}
end

do
	local function IfOnMe(self)
		self:PlaySound(1215897, "warning", nil, self:UnitName("player")) -- Debuff was demoted from being a PA
	end
	function mod:DevouringEntropyTimeline(eventInfo) -- Orbs
		local barText = CL.count:format(self:GetRename(1215897), devouringEntropyCount)
		self:CDBar(1215897, eventInfo.duration, barText, nil, eventInfo.id)
		devouringEntropyCount = devouringEntropyCount + 1
		return {
			msg = barText,
			key = 1215897,
			callback = function()
				self:PersonalMessageFromBlizzMessage(1215897, 2, false, self:GetRename(1215897, 2), nil, nil, IfOnMe)
				--self:PlaySound(1215897, "warning") -- PA sound
			end
		}
	end
end

function mod:UnstableVoidEssenceTimeline(eventInfo) -- Bouncing Ball
	local barText = CL.count:format(self:GetRename(1215087), unstableVoidEssenceCount)
	local messageText = CL.count:format(self:GetRename(1215087, 2), unstableVoidEssenceCount)
	self:CDBar(1215087, eventInfo.duration, barText, nil, eventInfo.id)
	unstableVoidEssenceCount = unstableVoidEssenceCount + 1
	return {
		msg = barText,
		key = 1215087,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1215087, "red", messageText)
			self:PlaySound(1215087, "info")
		end
	}
end
