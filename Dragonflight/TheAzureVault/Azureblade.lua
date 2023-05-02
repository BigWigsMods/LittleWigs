--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Azureblade", 2515, 2505)
if not mod then return end
mod:RegisterEnableMob(186739) -- Azureblade
mod:SetEncounterID(2585)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local overwhelmingEnergyCount = 0
local summonDraconicImageRemaining = 3
local ancientOrbRemaining = 4
local arcaneCleaveRemaining = 5

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		384132, -- Overwhelming Energy
		384223, -- Summon Draconic Image
		385578, -- Ancient Orb
		372222, -- Arcane Cleave
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "OverwhelmingEnergy", 384132)
	self:Death("DraconicIllusionDeath", 192955)
	self:Log("SPELL_CAST_START", "SummonDraconicImage", 384223)
	self:Log("SPELL_CAST_START", "AncientOrb", 385578)
	self:Log("SPELL_CAST_START", "ArcaneCleave", 372222)
end

function mod:OnEngage()
	overwhelmingEnergyCount = 0
	summonDraconicImageRemaining = 2
	ancientOrbRemaining = 2
	arcaneCleaveRemaining = 2
	self:SetStage(1)
	self:CDBar(384223, 3.3) -- Summon Draconic Image
	self:CDBar(372222, 5.2) -- Arcane Cleave
	self:CDBar(385578, 10.6) -- Ancient Orb
	-- 30s energy loss + ~2.9s delay
	self:CDBar(384132, 32.9, CL.count:format(self:SpellName(384132), 1)) -- Overwhelming Energy (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 378734 then -- Draconic Ritual
		-- this is cast when the boss runs to the center, we can clean up extra
		-- timers for skipped abilities a little early
		self:StopBar(384223) -- Summon Draconic Image
		self:StopBar(372222) -- Arcane Cleave
		self:StopBar(385578) -- Ancient Orb
	end
end

do
	local addKills = 0

	function mod:OverwhelmingEnergy(args)
		overwhelmingEnergyCount = overwhelmingEnergyCount + 1
		addKills = 0
		summonDraconicImageRemaining = 3
		ancientOrbRemaining = 4
		arcaneCleaveRemaining = 5
		local overwhelmingEnergyMessage = CL.count:format(args.spellName, overwhelmingEnergyCount)
		self:SetStage(2)
		self:Message(args.spellId, "cyan", overwhelmingEnergyMessage)
		self:PlaySound(args.spellId, "long")
		self:StopBar(overwhelmingEnergyMessage) -- Overwhelming Energy (n)
		self:StopBar(384223) -- Summon Draconic Image
		self:StopBar(372222) -- Arcane Cleave
		self:StopBar(385578) -- Ancient Orb
	end

	function mod:DraconicIllusionDeath(args)
		addKills = addKills + 1
		if addKills < 4 then
			self:Message(384132, "cyan", CL.add_killed:format(addKills, 4))
			self:PlaySound(384132, "alert")
		else
			local overwhemingEnergySpellName = self:SpellName(384132)
			self:SetStage(1)
			self:Message(384132, "green", CL.over:format(overwhemingEnergySpellName)) -- Overwhelming Energy Over
			self:PlaySound(384132, "info")
			self:CDBar(384223, 4.7) -- Summon Draconic Image
			self:CDBar(372222, 7.2) -- Arcane Cleave
			self:CDBar(385578, 12.5) -- Ancient Orb
			-- 60s energy loss + ~1.7s delay (usually longer because boss runs to middle first)
			self:CDBar(384132, 61.7, CL.count:format(overwhemingEnergySpellName, overwhelmingEnergyCount + 1)) -- Overwhelming Energy (n)
		end
	end
end

function mod:SummonDraconicImage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	-- 2 before 1st Overwhelming Energy, then 3 per stage 1
	summonDraconicImageRemaining = summonDraconicImageRemaining - 1
	if summonDraconicImageRemaining > 0 then
		self:CDBar(args.spellId, 14.6)
	else
		self:StopBar(args.spellId)
	end
end

function mod:AncientOrb(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	-- 2 before 1st Overwhelming Energy, then 3-4 per stage 1
	ancientOrbRemaining = ancientOrbRemaining - 1
	if ancientOrbRemaining > 0 then
		self:CDBar(args.spellId, 15.8)
	else
		self:StopBar(args.spellId)
	end
end

function mod:ArcaneCleave(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	-- 2 before 1st Overwhelming Energy, then 4-5 per stage 1
	arcaneCleaveRemaining = arcaneCleaveRemaining - 1
	if arcaneCleaveRemaining > 0 then
		self:CDBar(args.spellId, 13.4)
	else
		self:StopBar(args.spellId)
	end
end
