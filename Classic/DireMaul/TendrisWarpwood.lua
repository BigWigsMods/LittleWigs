--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tendris Warpwood", 429, 406)
if not mod then return end
mod:RegisterEnableMob(11489) -- Tendris Warpwood
mod:SetEncounterID(350)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{5568, "HEALER"}, -- Trample
		22924, -- Grasping Vines
		{22994, "DISPEL"}, -- Entangle
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Trample", 5568)
	self:Log("SPELL_CAST_START", "GraspingVines", 22924)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "Entangle", 451014)
	end
	self:Log("SPELL_AURA_APPLIED", "EntangleApplied", 22994)
	if self:Classic() and not self:Vanilla() then -- no encounter events in Cataclysm Classic
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11489)
	end
end

function mod:OnEngage()
	if self:Retail() then
		self:CDBar(22994, 6.6) -- Entangle
	end
	self:CDBar(5568, 7.1) -- Trample
	self:CDBar(22924, 11.8) -- Grasping Vines
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Trample(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 11489 then -- Tendris Warpwood
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 5.6)
	end
end

function mod:GraspingVines(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 14.5)
	self:PlaySound(args.spellId, "alert")
end

function mod:Entangle(args)
	self:Message(22994, "orange", CL.casting:format(args.spellName))
	self:CDBar(22994, 6.1)
	self:PlaySound(22994, "alert")
end

function mod:EntangleApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end
