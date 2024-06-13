--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Forgemaster Throngus", 670, 132)
if not mod then return end
mod:RegisterEnableMob(40177) -- Forgemaster Throngus
mod:SetEncounterID(1050)
mod:SetRespawnTime(30)
mod:SetStage(0.5)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		457664, -- Forge Weapon
		449687, -- Molten Mace
		449444, -- Molten Flurry
		{449474, "SAY"}, -- Molten Spark
		447395, -- Fiery Cleave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ForgeWeapon", 456900, 456902, 451996) -- Forge Mace, Forge Swords, Forge Axe
	self:Log("SPELL_CAST_START", "MoltenMace", 449687)
	self:Log("SPELL_AURA_APPLIED", "MoltenMaceApplied", 449687)
	self:Log("SPELL_AURA_REMOVED", "MoltenMaceRemoved", 449687)
	self:Log("SPELL_CAST_START", "MoltenFlurry", 449444)
	self:Log("SPELL_AURA_APPLIED", "MoltenSparkApplied", 449474)
	self:Log("SPELL_CAST_START", "FieryCleave", 447395)
end

function mod:OnEngage()
	self:SetStage(0.5)
	self:CDBar(457664, 8.4) -- Forge Weapon
	self:CDBar(447395, 19.2) -- Fiery Cleave
	self:CDBar(449444, 38.6) -- Molten Flurry
	self:CDBar(449687, 55.6) -- Molten Mace
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if not BigWigsLoader.isBeta then
	function mod:GetOptions()
		return {
			74908, -- Personal Phalanx
			75007, -- Encumbered
			74981, -- Dual Blades
			74976, -- Disorienting Roar
			75056, -- Impaling Slam
			74987, -- Cave In
		}
	end

	function mod:OnBossEnable()
		self:Log("SPELL_AURA_APPLIED", "Phalanx", 74908)
		self:Log("SPELL_AURA_APPLIED", "Encumbered", 75007)
		self:Log("SPELL_AURA_APPLIED", "Blades", 74981)
		self:Log("SPELL_CAST_SUCCESS", "Impale", 75056)
		self:Log("SPELL_AURA_APPLIED", "CaveIn", 74987)
		self:Log("SPELL_AURA_APPLIED", "Roar", 74976)
		self:Log("SPELL_AURA_REMOVED_DOSE", "RoarRemoved", 74976)
	end

	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ForgeWeapon(args)
	self:Message(457664, "cyan", args.spellName, args.spellId)
	self:PlaySound(457664, "info")
	self:CDBar(457664, 19.4) -- TODO alter bar text to say which is next?
	if args.spellId == 451996 then -- Forge Axe
		self:SetStage(1)
	elseif args.spellId == 456902 then -- Forge Swords
		self:SetStage(2)
	else -- 456900, Forge Mace
		self:SetStage(3)
	end
end

function mod:MoltenMace(args)
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "info")
	end
	self:CDBar(args.spellId, 60.7)
end

function mod:MoltenMaceApplied(args)
	if self:Tank() then
		self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
	end
end

function mod:MoltenMaceRemoved(args)
	if self:Tank() then
		self:StopBar(CL.onboss:format(args.spellName))
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:MoltenFlurry(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 60.2)
end

function mod:MoltenSparkApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		-- TODO this should probably have a say countdown, but this can be
		-- SPELL_AURA_REFRESH and that interaction needs to be handled
		self:Say(args.spellId, nil, nil, "Molten Spark")
	end
end

function mod:FieryCleave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 60.7)
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:Roar(args)
	if self:Me(args.destGUID) then
		self:StackMessageOld(args.spellId, args.destName, 3, "blue", "long", self:SpellName(56748)) -- 56748 = "Roar"
	end
end

function mod:RoarRemoved(args)
	if self:Me(args.destGUID) then
		self:StackMessageOld(args.spellId, args.destName, args.amount, "blue", nil, self:SpellName(56748)) -- 56748 = "Roar"
	end
end

function mod:Phalanx(args)
	self:MessageOld(args.spellId, "red", "alert")
	self:Bar(args.spellId, 30)
end

function mod:Encumbered(args)
	self:MessageOld(args.spellId, "red", "alert")
	self:Bar(args.spellId, 30)
end

function mod:Blades(args)
	self:MessageOld(args.spellId, "red", "alert")
	self:Bar(args.spellId, 30)
end

function mod:Impale(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
end

function mod:CaveIn(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
	end
end
