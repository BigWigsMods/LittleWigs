--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gilnid", 36, 2628)
if not mod then return end
mod:RegisterEnableMob(1763) -- Gilnid
mod:SetEncounterID(mod:Retail() and 2969 or 2743)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{5213, "DISPEL"}, -- Molten Metal
		{5159, "DISPEL"}, -- Melt Ore
		450542, -- Summon Remote-Controlled Golems
	}
end

function mod:OnBossEnable()
	if self:Classic() then
		self:Log("SPELL_CAST_START", "MoltenMetal", 5213)
	end
	self:Log("SPELL_CAST_SUCCESS", "MoltenMetalSuccess", 5213)
	if self:Retail() then
		self:Log("SPELL_AURA_APPLIED", "MoltenMetalApplied", 5213)
		self:Log("SPELL_CAST_START", "MeltOre", 5159)
		self:Log("SPELL_AURA_APPLIED", "MeltOreApplied", 5159)
		self:Log("SPELL_CAST_START", "SummonRemoteControlledGolems", 450542)
	end
end

function mod:OnEngage()
	if self:Retail() then
		self:CDBar(5213, 1.2) -- Molten Metal
		self:CDBar(5159, 9.7) -- Melt Ore
		self:CDBar(450542, 12.1) -- Summon Remote-Controlled Golems
	else -- Classic
		self:CDBar(5213, 13.0) -- Molten Metal
	end
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			5213, -- Molten Metal
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MoltenMetal(args) -- Classic only
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:MoltenMetalSuccess(args)
	if self:Retail() then
		self:CDBar(args.spellId, 9.7)
	else -- Classic
		self:CDBar(args.spellId, 28.7)
	end
end

function mod:MoltenMetalApplied(args)
	if self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:MeltOre(args)
	if self:MobId(args.sourceGUID) == 1763 then -- Gilnid
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 20.6)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:MeltOreApplied(args)
	if self:Dispeller("magic", nil, args.spellId) and self:MobId(args.sourceGUID) == 1763 then -- Gilnid
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:SummonRemoteControlledGolems(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 30.4)
	self:PlaySound(args.spellId, "long")
end
