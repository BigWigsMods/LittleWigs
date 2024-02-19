--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kokia Blazehoof", 2521, 2485)
if not mod then return end
mod:RegisterEnableMob(189232) -- Kokia Blazehoof
mod:SetEncounterID(2606)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local ritualOfBlazebindingCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Kokia Blazehoof
		372863, -- Ritual of Blazebinding
		{372107, "SAY"}, -- Molten Boulder
		{372858, "TANK_HEALER"}, -- Searing Blows
		-- Blazebound Firestorm
		373017, -- Roaring Blaze
		373087, -- Burnout
	}, {
		[372863] = self.displayName,
		[373017] = -24945, -- Blazebound Firestorm
	}
end

function mod:OnBossEnable()
	-- Kokia Blazehoof
	self:Log("SPELL_CAST_START", "RitualOfBlazebinding", 372863)
	self:Log("SPELL_CAST_START", "MoltenBoulder", 372107)
	self:Log("SPELL_CAST_SUCCESS", "SearingBlows", 372858)

	-- Blazebound Firestorm
	self:Log("SPELL_CAST_START", "RoaringBlaze", 373017)
	self:Log("SPELL_CAST_START", "Burnout", 373087)
end

function mod:OnEngage()
	ritualOfBlazebindingCount = 0
	self:Bar(372863, 7.3, CL.count:format(self:SpellName(372863), 1)) -- Ritual of Blazebinding (1)
	self:Bar(372107, 14.5) -- Molten Boulder
	self:Bar(372858, 21.6) -- Searing Blows
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Kokia Blazehoof

function mod:RitualOfBlazebinding(args)
	ritualOfBlazebindingCount = ritualOfBlazebindingCount + 1
	local ritualOfBlazebindingMessage = CL.count:format(args.spellName, ritualOfBlazebindingCount)
	self:StopBar(ritualOfBlazebindingMessage)
	self:Message(args.spellId, "orange", ritualOfBlazebindingMessage)
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 33.9, CL.count:format(args.spellName, ritualOfBlazebindingCount + 1))
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(372107, "yellow", name)
		self:PlaySound(372107, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(372107, nil, nil, "Molten Boulder")
		end
	end

	function mod:MoltenBoulder(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:Bar(args.spellId, 17)
	end
end

function mod:SearingBlows(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 32.7)
end

-- Blazebound Firestorm

function mod:RoaringBlaze(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:Burnout(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
