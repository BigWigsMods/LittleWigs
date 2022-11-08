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
	self:Log("SPELL_CAST_START", "OverwhelmingEnergy", 384132)
	self:Death("DraconicIllusionDeath", 192955)
	self:Log("SPELL_CAST_START", "SummonDraconicImage", 384223)
	self:Log("SPELL_CAST_START", "AncientOrb", 385578)
	self:Log("SPELL_CAST_START", "ArcaneCleave", 372222)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(384223, 3.7) -- Summon Draconic Image
	self:CDBar(372222, 6.1) -- Arcane Cleave
	self:CDBar(385578, 10.9) -- Ancient Orb
	self:CDBar(384132, 23.1) -- Overwhelming Energy
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local addKills = 0

	function mod:OverwhelmingEnergy(args)
		addKills = 0
		self:SetStage(2)
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "long")
		-- TODO unknown CD
		-- TODO stopbars?
	end

	function mod:DraconicIllusionDeath(args)
		addKills = addKills + 1
		-- TODO confirm adds required is still 4 in Normal/Mythic
		if addKills < 4 then
			self:Message(384132, "cyan", CL.add_killed:format(addKills, 4))
		else
			self:SetStage(1)
			self:Message(384132, "green", CL.over:format(self:SpellName(384132))) -- Overwhelming Energy Over
			self:PlaySound(384132, "info")
		end
	end
end

function mod:SummonDraconicImage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 14.6)
end

function mod:AncientOrb(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.8)
end

function mod:ArcaneCleave(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 13.3)
end
