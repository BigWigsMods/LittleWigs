if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gutshot", 2520, 2472)
if not mod then return end
mod:RegisterEnableMob(186116) -- Gutshot
mod:SetEncounterID(2567)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		384827, -- Call Hyenas
		385359, -- Ensnaring Trap
		384416, -- Meat Toss
		384633, -- Master's Call
		{384353, "TANK"}, -- Gut Shot
	}, nil, {
		[384416] = CL.fixate, -- Meat Toss (Smell Like Meat)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallHyenas", 384827)
	self:Log("SPELL_AURA_APPLIED", "EnsnaringTrapCast", 385356)
	self:Log("SPELL_AURA_APPLIED", "EnsnaringTrapApplied", 384148)
	self:Log("SPELL_CAST_START", "MeatToss", 384416)
	self:Log("SPELL_AURA_APPLIED", "SmellLikeMeatApplied", 384425)
	self:Log("SPELL_CAST_START", "MastersCall", 384633)
	self:Log("SPELL_CAST_START", "GutShot", 384353)
end

function mod:OnEngage()
	self:CDBar(385359, 8.4) -- Ensnaring Trap
	self:CDBar(384353, 12.1) -- Gut Shot
	self:CDBar(384633, 15.8) -- Master's Call
	self:CDBar(384416, 21.8) -- Meat Toss
	self:Bar(384827, 33.9) -- Call Hyenas
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallHyenas(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(385359, 31.6)
end

function mod:EnsnaringTrapCast(args)
	self:Message(385359, "yellow")
	self:PlaySound(385359, "alarm")
	self:CDBar(385359, 8.5)
end

function mod:EnsnaringTrapApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("movement") then
		self:TargetMessage(385359, "red", args.destName)
		self:PlaySound(385359, "alarm", nil, args.destName)
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:PlaySound(384416, "alarm")
		else
			self:PlaySound(384416, "alert", nil, player)
		end
		self:TargetMessage(384416, "orange", player)
	end

	function mod:MeatToss(args)
		self:GetBossTarget(printTarget, 0.2, args.sourceGUID)
		self:CDBar(args.spellId, 23.1)
	end
end

function mod:SmellLikeMeatApplied(args)
	if self:Me(args.destGUID) then
		self:Bar(384416, 10, CL.fixate) -- Meat Toss (Fixate)
	end
end

function mod:MastersCall(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 42.5)
end

function mod:GutShot(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 18.2)
end
