--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Illyanna Ravenoak", 429, 407)
if not mod then return end
mod:RegisterEnableMob(
	11488, -- Illyanna Ravenoak
	14308 -- Ferra
)
mod:SetEncounterID(347)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ferra
		22911, -- Charge
		-- Illyanna Ravenoak
		30933, -- Volley
		22910, -- Immolation Trap
		22914, -- Concussive Shot
	}, {
		[22911] = -4906, -- Ferra
		[30933] = self.displayName,
	}
end

function mod:OnBossEnable()
	if self:Retail() then
		self:Log("SPELL_CAST_SUCCESS", "Charge", 451118)
		self:Log("SPELL_CAST_SUCCESS", "ImmolationTrap", 451121)
		self:Log("SPELL_CAST_SUCCESS", "Volley", 30933)
	else -- Classic
		self:Log("SPELL_CAST_SUCCESS", "ChargeClassic", 22911)
		self:Log("SPELL_CAST_SUCCESS", "ImmolationTrap", 22910)
	end
	self:Log("SPELL_CAST_SUCCESS", "ConcussiveShot", 22914)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11488)
	end
end

function mod:OnEngage()
	-- Charge and Volley are not cast if no one is at range
	self:CDBar(22910, 7.2) -- Immolation Trap
	self:CDBar(22914, 14.5) -- Concussive Shot
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			-- Ferra
			22911, -- Charge
			-- Illyanna Ravenoak
			22910, -- Immolation Trap
			22914, -- Concussive Shot
		}, {
			[22911] = -4906, -- Ferra
			[22910] = self.displayName,
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Ferra

function mod:Charge(args)
	self:Message(22911, "red") -- no target on Retail
	-- only cast if someone is at range
	--self:CDBar(args.spellId, 7.3)
	self:PlaySound(22911, "alarm")
end

function mod:ChargeClassic(args)
	self:TargetMessage(22911, "red", args.destName)
	-- only cast if someone is at range, no CD on Classic
	if self:Me(args.destGUID) then
		self:PlaySound(22911, "alarm", nil, args.destName)
	end
end

-- Illyanna Ravenoak

function mod:Volley(args)
	self:Message(args.spellId, "red")
	-- only cast if someone is at range
	--self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ImmolationTrap()
	self:Message(22910, "orange")
	self:CDBar(22910, 15.8)
	self:PlaySound(22910, "info")
end

function mod:ConcussiveShot(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end
