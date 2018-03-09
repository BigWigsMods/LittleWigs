--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mechano-Lord Capacitus", 730, 563)
if not mod then return end
mod:RegisterEnableMob(19219)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		35158, -- Reflective Magic Shield
		35159, -- Reflective Damage Shield
		39096, -- Polarity Shift
		"berserk",
	}, {
		[35158] = "general",
		["berserk"] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ReflectiveShield", 35158, 35159) -- Magic, Damage
	self:Log("SPELL_AURA_REMOVED", "ReflectiveShieldRemoved", 35158, 35159) -- Magic, Damage
	self:Log("SPELL_CAST_START", "PolarityShift", 39096)
	--self:Log("SPELL_CAST_SUCCESS", "PolarityScan", 39096) --success isn't getting logged right now

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 19219)

	positive = nil
end

function mod:OnEngage()
	if self:Heroic() then
		self:Berserk(180, true, nil, 224604) -- 224604 = Enrage
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ReflectiveShield(args)
	self:Message(args.spellId, "Urgent")
	self:Bar(args.spellId, 10)
end

function mod:ReflectiveShieldRemoved(args)
	self:Message(args.spellId, "Positive", nil, CL.removed:format(args.spellName))
end

function mod:PolarityShift(args)
	self:Message(args.spellId, "Urgent", nil, CL.casting(args.spellName))
	self:CastBar(args.spellId, 3)
	self:ScheduleTimer("PolarityScan", 4)
end

local function hasBuff(player, buff)
	local i = 1
	local name = UnitBuff(player, i)
	while name do
		if name == buff then return true end
		i = i + 1
		name = UnitBuff(player, i)
	end
	return false
end

function mod:PolarityScan()
	if positive then
		for k,v in positive do
			self:StopBar(v)
		end
		positive = nil
	end
	if hasBuff("player", charge) then table.insert(positive, UnitName("player")) end
	for i=1, 4 do
		if hasBuff("party"..i, charge) then table.insert(positive, UnitName("party"..i)) end
	end
	if positive then
		for k,v in pairs(positive) do
			self:Bar(v, 60, 39090) -- 39090 = Positive Charge
		end
	end
end
