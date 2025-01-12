local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kul'tharok", 2293, 2389)
if not mod then return end
mod:RegisterEnableMob(162309) -- Kul'tharok
mod:SetEncounterID(2364)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotOne then -- XXX remove this guard when 11.1 is live
	function mod:GetOptions()
		return {
			{474431, "SAY"}, -- Phantasmal Parasite
			474087, -- Poltergeist Dash
			-- Normal / Heroic
			473513, -- Feast of the Damned
			-- Mythic
			{473959, "ME_ONLY"}, -- Draw Soul
			1215787, -- March of the Damned
		}
	end
else -- XXX remove the block below when 11.1 is live
	function mod:GetOptions()
		return {
			{319521, "ME_ONLY"}, -- Draw Soul
			{319637, "ME_ONLY"}, -- Reclaimed Soul
			{319626, "SAY"}, -- Phantasmal Parasite
			319669, -- Spectral Reach
		}
	end
end

function mod:OnBossEnable()
	if isElevenDotOne then -- XXX remove check once 11.1 is live
		self:Log("SPELL_CAST_START", "PhantasmalParasite", 474431)
		self:Log("SPELL_AURA_APPLIED", "PhantasmalParasiteApplied", 473943)
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- for odd Poltergeist Dash casts
		self:Log("SPELL_CAST_SUCCESS", "PoltergeistDashEven", 474085) -- TODO we're missing a SPELL_CAST_START

		-- Normal / Heroic
		self:Log("SPELL_CAST_START", "FeastOfTheDamned", 473513)

		-- Mythic
		self:Log("SPELL_CAST_SUCCESS", "DrawSoul", 473959) -- TODO verify spellId
		self:Log("SPELL_CAST_START", "MarchOfTheDamned", 1215787) -- TODO verify spellId
	else -- XXX remove this block once 11.1 is live
		self:Log("SPELL_CAST_SUCCESS", "DrawSoul", 319521)
		self:Log("SPELL_AURA_APPLIED", "DrawSoulApplied", 319521)
		self:Log("SPELL_AURA_APPLIED", "ReclaimedSoulApplied", 319637)
		self:Log("SPELL_AURA_APPLIED_DOSE", "ReclaimedSoulApplied", 319637)
		self:Log("SPELL_CAST_SUCCESS", "PhantasmalParasite", 319626)
		self:Log("SPELL_AURA_APPLIED", "PhantasmalParasiteAppliedOld", 319626)
		self:Log("SPELL_CAST_START", "SpectralReach", 319669)
	end
end

function mod:OnEngage()
	if isElevenDotOne then -- XXX remove check once 11.1 is live
		self:CDBar(474431, 6.4) -- Phantasmal Parasite
		self:ScheduleTimer("PoltergeistDash", 12.2)
		self:CDBar(474087, 12.2) -- Poltergeist Dash
		if self:Mythic() then -- TODO verify mythic timers
			self:CDBar(319521, 15.8) -- Draw Soul
			self:CDBar(1215787, 50.0) -- March of the Damned
		else -- Normal / Heroic
			self:CDBar(473513, 50.0) -- Feast of the Damned
		end
	else -- XXX remove this block once 11.1 is live
		self:CDBar(319626, 3.3) -- Phantasmal Parasite
		self:CDBar(319521, 15.8) -- Draw Soul
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}

	function mod:PhantasmalParasite(args)
		playerList = {}
		if isElevenDotOne then -- XXX remove this check 11.1 is live
			self:CDBar(args.spellId, 60.6)
		else -- XXX remove this block 11.1 is live
			self:CDBar(args.spellId, 25.5)
		end
	end

	function mod:PhantasmalParasiteApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(474431, "red", playerList, 2) -- TODO guessed 2 players
		if self:Me(args.destGUID) then
			self:Say(474431, nil, nil, "Phantasmal Parasite")
		end
		self:PlaySound(474431, "alert", nil, playerList)
	end

	function mod:PhantasmalParasiteAppliedOld(args) -- XXX remove in 11.1
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 2, nil, nil, .8)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Phantasmal Parasite")
		end
		self:PlaySound(args.spellId, "alert", nil, playerList)
	end
end

function mod:PoltergeistDash()
	self:Message(474087, "purple")
	self:CDBar(474087, 30.3)
	self:PlaySound(474087, "alarm")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 474087 then -- Poltergeist Dash (odd casts)
		-- the only event we have is at the end of the cast, the visual for the even
		-- casts will appear in approximately ~27s, so schedule an alert for then.
		self:ScheduleTimer("PoltergeistDash", 27)
		self:CDBar(spellId, {27, 30.3})
	end
end

function mod:PoltergeistDashEven(args)
	-- the only event we have is at the end of the cast, the visual for the odd
	-- casts will appear in approximately ~28s, so schedule an alert for then.
	self:ScheduleTimer("PoltergeistDash", 28)
	self:CDBar(474087, {28, 30.3}) -- Poltergeist Dash
end

-- Normal / Heroic

function mod:FeastOfTheDamned(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 60.6)
	self:PlaySound(args.spellId, "long")
end

-- Mythic

function mod:MarchOfTheDamned(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 60.6)
	self:PlaySound(args.spellId, "long")
end

function mod:DrawSoul(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 60.6) -- TODO guessed
	self:PlaySound(args.spellId, "info")
end

function mod:DrawSoulApplied(args) -- XXX removed in 11.1
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:ReclaimedSoulApplied(args) -- XXX removed in 11.1
	self:StackMessageOld(args.spellId, args.destName, args.amount, "green")
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:SpectralReach(args) -- XXX removed in 11.1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end
