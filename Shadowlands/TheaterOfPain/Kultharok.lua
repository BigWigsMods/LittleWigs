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
-- Locals
--

local necroticEruptionCount = 1
local wellOfDarknessCount = 1
local drawSoulCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotOne then -- XXX remove this guard when 11.1 is live
	function mod:GetOptions()
		return {
			474087, -- Necrotic Eruption
			{1223803, "SAY"}, -- Well of Darkness
			-- Heroic
			473513, -- Feast of the Damned
			-- Mythic
			{474298, "ME_ONLY"}, -- Draw Soul
			1215787, -- Death Spiral
		}, {
			[473513] = CL.heroic,
			[474298] = CL.mythic,
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
		self:Log("SPELL_CAST_START", "NecroticEruption", 474087)
		self:Log("SPELL_CAST_START", "WellOfDarkness", 1223803)
		self:Log("SPELL_AURA_APPLIED", "WellOfDarknessApplied", 1223804)

		-- Normal / Heroic
		self:Log("SPELL_CAST_START", "FeastOfTheDamned", 473513)

		-- Mythic
		self:Log("SPELL_CAST_START", "DrawSoul", 474298)
		self:Log("SPELL_CAST_START", "DeathSpiral", 1215787)
		self:Log("SPELL_PERIODIC_DAMAGE", "DeathSpiralDamage", 1223240)
		self:Log("SPELL_PERIODIC_MISSED", "DeathSpiralDamage", 1223240)
	else -- XXX remove this block once 11.1 is live
		self:Log("SPELL_CAST_SUCCESS", "DrawSoulOld", 319521)
		self:Log("SPELL_AURA_APPLIED", "DrawSoulApplied", 319521)
		self:Log("SPELL_AURA_APPLIED", "ReclaimedSoulApplied", 319637)
		self:Log("SPELL_AURA_APPLIED_DOSE", "ReclaimedSoulApplied", 319637)
		self:Log("SPELL_CAST_SUCCESS", "PhantasmalParasite", 319626)
		self:Log("SPELL_AURA_APPLIED", "PhantasmalParasiteApplied", 319626)
		self:Log("SPELL_CAST_START", "SpectralReach", 319669)
	end
end

function mod:OnEngage()
	necroticEruptionCount = 1
	wellOfDarknessCount = 1
	drawSoulCount = 1
	if isElevenDotOne then -- XXX remove check once 11.1 is live
		if self:Mythic() then
			self:CDBar(1215787, 6.1) -- Death Spiral
			self:CDBar(1223803, 10.9) -- Well of Darkness
			self:CDBar(474087, 17.9) -- Necrotic Eruption
			self:CDBar(474298, 49.8, CL.count:format(self:SpellName(474298), drawSoulCount)) -- Draw Soul
		else -- Normal, Heroic
			self:CDBar(1223803, 7.0) -- Well of Darkness
			self:CDBar(474087, 12.5) -- Necrotic Eruption
			self:CDBar(474298, 21.0, CL.count:format(self:SpellName(474298), drawSoulCount)) -- Draw Soul
			self:CDBar(473513, 48.6) -- Feast of the Damned
		end
	else -- XXX remove this block once 11.1 is live
		self:CDBar(319626, 3.3) -- Phantasmal Parasite
		self:CDBar(319521, 15.8) -- Draw Soul
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NecroticEruption(args)
	self:Message(args.spellId, "purple")
	necroticEruptionCount = necroticEruptionCount + 1
	if self:Mythic() then
		if necroticEruptionCount % 2 == 0 then
			self:CDBar(args.spellId, 20.9)
		else
			self:CDBar(args.spellId, 25.4)
		end
	else -- Normal
		self:CDBar(args.spellId, 60.8)
	end
	self:PlaySound(args.spellId, "alarm")
end

do
	local playerList = {}

	function mod:WellOfDarkness(args)
		playerList = {}
		wellOfDarknessCount = wellOfDarknessCount + 1
		if self:Mythic() then
			if wellOfDarknessCount % 2 == 0 then
				self:CDBar(args.spellId, 23.0)
			else
				self:CDBar(args.spellId, 25.5)
			end
		else -- Normal
			self:CDBar(args.spellId, 58.3)
		end
	end

	function mod:WellOfDarknessApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(1223803, "red", playerList, 2)
		if self:Me(args.destGUID) then
			self:Say(1223803, nil, nil, "Well of Darkness")
		end
		self:PlaySound(1223803, "alert", nil, playerList)
	end
end

-- Normal / Heroic

function mod:FeastOfTheDamned(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 60.8)
	self:PlaySound(args.spellId, "long")
end

-- Mythic

function mod:DrawSoul(args)
	self:StopBar(CL.count:format(args.spellName, drawSoulCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, drawSoulCount))
	drawSoulCount = drawSoulCount + 1
	if self:Mythic() then -- TODO this condition shouldn't be needed but Draw Soul is currently cast in Normal
		self:CDBar(1215787, {10.0, 47.3}) -- Death Spiral
		self:CDBar(1223803, {14.5, 25.5}) -- Well of Darkness
		self:CDBar(474087, {20.5, 25.4}) -- Necrotic Eruption
	end
	self:CDBar(args.spellId, 51.0, CL.count:format(args.spellName, drawSoulCount))
	self:PlaySound(args.spellId, "warning")
end

function mod:DeathSpiral(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 47.3)
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:DeathSpiralDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(1215787, "underyou")
			self:PlaySound(1215787, "underyou")
		end
	end
end

-- Legacy

function mod:DrawSoulOld(args) -- XXX removed in 11.1
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 20.6)
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

do
	local playerList = {}

	function mod:PhantasmalParasite(args) -- XXX removed in 11.1
		playerList = {}
		self:CDBar(args.spellId, 25.5)
	end

	function mod:PhantasmalParasiteApplied(args) -- XXX removed in 11.1
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 2, nil, nil, .8)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Phantasmal Parasite")
		end
		self:PlaySound(args.spellId, "alert", nil, playerList)
	end
end
