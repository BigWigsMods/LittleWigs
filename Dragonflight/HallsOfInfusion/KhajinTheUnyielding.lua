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

local hailstormCount = 1
local glacialSurgeCount = 1
local frostShockCount = 1
local frostCycloneCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{386757, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Hailstorm
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
	hailstormCount = 1
	glacialSurgeCount = 1
	frostShockCount = 1
	frostCycloneCount = 1
	if self:Tank() or self:Dispeller("magic", nil, 385963) or self:Dispeller("movement", nil, 385963) then
		self:CDBar(385963, 6.0) -- Frost Shock
	end
	if self:Mythic() then
		self:CDBar(390111, 10.0) -- Frost Cyclone
		self:CDBar(386757, 20.0) -- Hailstorm
		self:CDBar(386559, 32.0) -- Glacial Surge
	else
		self:CDBar(386757, 10.0) -- Hailstorm
		self:CDBar(386559, 22.0) -- Glacial Surge
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hailstorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	hailstormCount = hailstormCount + 1
	if self:Mythic() then
		self:CastBar(args.spellId, 7)
		if hailstormCount % 2 == 0 then
			self:CDBar(args.spellId, 30.0)
		else
			self:CDBar(args.spellId, 42.0)
		end
	else
		-- skip the castbar (4s) in Normal, there's nothing to hide behind
		if self:Heroic() then
			self:CastBar(args.spellId, 7)
		elseif self:Mythic() then
			self:CastBar(args.spellId, 4)
		end
		if hailstormCount % 2 == 0 then
			self:CDBar(args.spellId, 27.0)
		else
			self:CDBar(args.spellId, 28.0)
		end
	end
end

function mod:GlacialSurge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	glacialSurgeCount = glacialSurgeCount + 1
	if self:Mythic() then
		if glacialSurgeCount % 2 == 0 then
			self:CDBar(args.spellId, 30.0)
		else
			self:CDBar(args.spellId, 42.0)
		end
	else
		if glacialSurgeCount % 2 == 0 then
			self:CDBar(args.spellId, 22.0)
		else
			self:CDBar(args.spellId, 33.0)
		end
	end
end

function mod:FrostShock(args)
	frostShockCount = frostShockCount + 1
	if self:Tank() or self:Dispeller("magic", nil, 385963) or self:Dispeller("movement", nil, 385963) then
		if self:Mythic() then
			if frostShockCount % 3 == 2 then
				self:CDBar(args.spellId, 12.0)
			else
				self:CDBar(args.spellId, 30.0)
			end
		elseif self:Heroic() then
			if frostShockCount % 2 == 0 then
				self:CDBar(args.spellId, 11.0)
			else
				self:CDBar(args.spellId, 44.0)
			end
		else
			if frostShockCount % 3 == 2 then
				self:CDBar(args.spellId, 10.0)
			elseif frostShockCount % 3 == 0 then
				self:CDBar(args.spellId, 27.0)
			else
				self:CDBar(args.spellId, 18.0)
			end
		end
	end
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
	frostCycloneCount = frostCycloneCount + 1
	if frostCycloneCount % 2 == 0 then
		self:CDBar(args.spellId, 35.0)
	else
		self:CDBar(args.spellId, 37.0)
	end
end
