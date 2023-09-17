--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oakheart", 1466, 1655)
if not mod then return end
mod:RegisterEnableMob(103344)
mod:SetEncounterID(1837)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		204611, -- Crushing Grip
		{204574, "DISPEL"}, -- Strangling Roots
		204667, -- Nightmare Breath
		204666, -- Shattered Earth
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CrushingGrip", 204611)
	self:Log("SPELL_CAST_START", "StranglingRoots", 204574)
	self:Log("SPELL_AURA_APPLIED", "StranglingRootsApplied", 199063)
	self:Log("SPELL_CAST_START", "NightmareBreath", 204667)
	self:Log("SPELL_CAST_START", "ShatteredEarth", 204666)
	-- TODO bug? Uproot is never cast as of 10.2.0.51297
end

function mod:OnEngage()
	self:CDBar(204666, 8.2) -- Shattered Earth
	self:CDBar(204574, 14.2) -- Strangling Roots
	self:CDBar(204667, 19.4) -- Nightmare Breath
	self:CDBar(204611, 24.0) -- Crushing Grip
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrushingGrip(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 28.0)
end

function mod:StranglingRoots(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 23.0)
end

function mod:StranglingRootsApplied(args)
	if self:Player(args.destFlags) and (self:Dispeller("movement", nil, 204574) or self:Me(args.destGUID)) then
		self:TargetMessage(204574, "yellow", args.destName)
		self:PlaySound(204574, "info", nil, args.destName)
	end
end

function mod:NightmareBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 25.5)
end

function mod:ShatteredEarth(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 35.2)
end
