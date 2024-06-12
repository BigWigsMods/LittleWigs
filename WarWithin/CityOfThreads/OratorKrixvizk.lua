if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Orator Krix'vizk", 2669, 2594)
if not mod then return end
mod:RegisterEnableMob(216619) -- Orator Krix'vizk
mod:SetEncounterID(2907)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local vociferousIndoctrinationCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		434722, -- Subjugate
		434779, -- Terrorize
		434829, -- Vociferous Indoctrination
		434926, -- Lingering Influence
		-- TODO Shadows of Doubt (Mythic)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Subjugate", 434722)
	self:Log("SPELL_CAST_START", "Terrorize", 434779)
	self:Log("SPELL_CAST_START", "VociferousIndoctrination", 434829)
	self:Log("SPELL_AURA_REMOVED", "VociferousIndoctrinationOver", 434829)
	self:Log("SPELL_PERIODIC_DAMAGE", "LingeringInfluenceDamage", 434926)
end

function mod:OnEngage()
	vociferousIndoctrinationCount = 1
	self:CDBar(434722, 4.7) -- Subjugate
	self:CDBar(434779, 8.1) -- Terrorize
	self:CDBar(434829, 25.1, CL.count:format(self:SpellName(434829), vociferousIndoctrinationCount)) -- Vociferous Indoctrination
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Subjugate(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 13.9)
end

function mod:Terrorize(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 8.5)
end

function mod:VociferousIndoctrination(args)
	self:StopBar(CL.count:format(args.spellName, vociferousIndoctrinationCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, vociferousIndoctrinationCount))
	self:PlaySound(args.spellId, "long")
	vociferousIndoctrinationCount = vociferousIndoctrinationCount + 1
	self:CDBar(args.spellId, 30.3, CL.count:format(args.spellName, vociferousIndoctrinationCount))
	-- TODO 10.92 minimum to next ability
end

function mod:VociferousIndoctrinationOver(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:LingeringInfluenceDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou", nil, args.destName)
	end
end
