--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Forgemaster Throngus", 670, 132)
if not mod then return end
if mod:Retail() then
	mod:SetJournalID(2627) -- Journal ID was changed in The War Within
end
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
		{449474, "SAY", "SAY_COUNTDOWN"}, -- Molten Spark
		447395, -- Fiery Cleave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ForgeWeapon", 451996, 456902, 456900) -- Forge Axe, Forge Swords, Forge Mace
	self:Log("SPELL_CAST_START", "MoltenMace", 449687)
	self:Log("SPELL_AURA_APPLIED", "MoltenMaceApplied", 449687)
	self:Log("SPELL_AURA_REMOVED", "MoltenMaceRemoved", 449687)
	self:Log("SPELL_CAST_START", "MoltenFlurry", 449444)
	self:Log("SPELL_AURA_APPLIED", "MoltenSparkApplied", 449474)
	self:Log("SPELL_AURA_REFRESH", "MoltenSparkRefresh", 449474)
	self:Log("SPELL_AURA_REMOVED", "MoltenSparkRemoved", 449474)
	self:Log("SPELL_CAST_START", "FieryCleave", 447395)
end

function mod:OnEngage()
	self:SetStage(0.5)
	self:CDBar(457664, 8.4, 451996) -- Forge Weapon, Forge Axe
	self:CDBar(447395, 19.2) -- Fiery Cleave
	self:CDBar(449444, 38.6) -- Molten Flurry
	if self:Mythic() then
		self:CDBar(449687, 55.6) -- Molten Mace
	end
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
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
	self:StopBar(args.spellId)
	self:Message(457664, "cyan", args.spellName, args.spellId)
	self:PlaySound(457664, "info")
	if args.spellId == 451996 then -- Forge Axe
		self:SetStage(1)
		self:CDBar(457664, 19.4, 456902) -- Forge Swords
	elseif args.spellId == 456902 then -- Forge Swords
		self:SetStage(2)
		if self:Mythic() then
			self:CDBar(457664, 20.6, 456900) -- Forge Mace
		else -- Heroic, Normal
			self:CDBar(457664, 24.3, 451996) -- Forge Axe
		end
	else -- 456900, Forge Mace
		self:SetStage(3)
		self:CDBar(457664, 20.6, 451996) -- Forge Axe
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
	if self:Mythic() then
		self:CDBar(args.spellId, 60.2)
	else -- Heroic, Normal
		self:CDBar(args.spellId, 43.7)
	end
end

function mod:MoltenSparkApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Molten Spark")
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:MoltenSparkRefresh(args)
	if self:Me(args.destGUID) then
		-- this debuff usually goes on two players with applications 3s apart. but if you are the only valid
		-- target this can be refreshed intead, extending the original debuff back to a 6s duration.
		self:CancelSayCountdown(args.spellId)
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:MoltenSparkRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:FieryCleave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if self:Mythic() then
		self:CDBar(args.spellId, 60.7)
	else -- Heroic, Normal
		self:CDBar(args.spellId, 43.7)
	end
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
