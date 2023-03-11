--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Khajin the Unyielding", 2527, 2510)
if not mod then return end
mod:RegisterEnableMob(189727) -- Khajin the Unyielding
mod:SetEncounterID(2617)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local hailstormCount = 0
local glacialSurgeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		386757, -- Hailstorm
		386559, -- Glacial Surge
		{385963, "DISPEL"}, -- Frost Shock
		390111, -- Frost Cyclone
	}, {
		[390111] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Hailstorm", 386757)
	self:Log("SPELL_CAST_START", "GlacialSurge", 386559)
	self:Log("SPELL_CAST_SUCCESS", "FrostShock", 385963)
	self:Log("SPELL_AURA_APPLIED", "FrostShockApplied", 385963)
	self:Log("SPELL_CAST_START", "FrostCyclone", 390111)
end

function mod:OnEngage()
	hailstormCount = 0
	glacialSurgeCount = 0
	self:Bar(385963, 6.0) -- Frost Shock
	if self:Mythic() then
		self:Bar(390111, 10.0) -- Frost Cyclone
		self:Bar(386757, 20.0) -- Hailstorm
		self:Bar(386559, 27.0) -- Glacial Surge
	else
		self:Bar(386757, 10.0) -- Hailstorm
		self:Bar(386559, 22.0) -- Glacial Surge
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hailstorm(args)
	hailstormCount = hailstormCount + 1
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	if self:Mythic() then
		if hailstormCount % 2 == 1 then
			self:Bar(args.spellId, 23.0)
		else
			self:Bar(args.spellId, 37.0)
		end
	else
		-- TODO find pattern
		self:CDBar(args.spellId, 22)
	end
end

function mod:GlacialSurge(args)
	glacialSurgeCount = glacialSurgeCount + 1
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	if self:Mythic() then
		if glacialSurgeCount % 2 == 1 then
			self:Bar(args.spellId, 25.0)
		else
			self:Bar(args.spellId, 35.0)
		end
	else
		-- TODO find pattern
		self:CDBar(args.spellId, 22)
	end
end

function mod:FrostShock(args)
	-- mythic pull:6.0, 12.0, 24.1, 23.9, 12.0, 48.0, 12.0, 22.1, 25.9, 12.0, 24.1, 23.9, 12.0, 60.0, 22.0
	-- mythic pull:6.0, 12.0, 22.1, 25.9, 12.0, 24.1, 23.9, 12.0, 22.0, 26.0, 12.0, 24.2, 23.9, 12.0, 24.1
	-- mythic pull:6.0, 12.0, 24.1, 23.9, 12.0, 22.1, 25.9, 12.0, 24.2, 23.9, 12.0, 22.1, 25.9, 12.0
	-- TODO is there a reliable pattern? can skip casts if out of range
	-- mythic 8s after frost cyclone?
	-- mythic 13 or 14s after glacial surge
	-- heroic 7s after hailstorm?
	-- heroic 17s after glacial surge?
	self:CDBar(args.spellId, 12.0)
end

function mod:FrostShockApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:FrostCyclone(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 30.0)
end
