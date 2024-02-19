--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Executor Tarvold", 2284, 2415)
if not mod then return end
mod:RegisterEnableMob(162103) -- Executor Tarvold
mod:SetEncounterID(2361)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		{322554, "SAY"}, -- Castigate
		322574, -- Coalesce Manifestation
		{328494, "DISPEL"}, -- Sintouched Anima
		-- Fleeting Manifestation
		323551, -- Residue
	}, {
		[322554] = "general",
		[323551] = -21883, -- Fleeting Manifestation
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "Castigate", 322554)
	self:Log("SPELL_AURA_APPLIED", "SintouchedAnimaApplied", 328494)
	self:Log("SPELL_AURA_APPLIED", "Residue", 323573)
	self:Log("SPELL_PERIODIC_DAMAGE", "Residue", 323573)
	self:Log("SPELL_PERIODIC_MISSED", "Residue", 323573)
	self:Death("FleetingManifestationDeath", 165556)
end

function mod:OnEngage()
	self:Bar(322554, 4.7) -- Castigate
	self:CDBar(322574, 10.8) -- Coalesce Manifestation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prevGUID = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if spellId == 322573 and prevGUID ~= castGUID then -- Coalesce Manifestation
			prevGUID = castGUID

			self:Message(322574, "yellow") -- Coalesce Manifestation
			self:PlaySound(322574, "info") -- Coalesce Manifestation
			self:CDBar(322574, 30)  -- Coalesce Manifestation
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(322554, "orange", name)
		self:PlaySound(322554, "alert", nil, name)
		if self:Me(guid) then
			self:Say(322554, nil, nil, "Castigate")
		end
	end

	function mod:Castigate(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 20.7)
	end
end

function mod:SintouchedAnimaApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:Residue(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(323551, "underyou") -- Residue
				self:PlaySound(323551, "underyou") -- Residue
			end
		end
	end
end

function mod:FleetingManifestationDeath(args)
	self:Message(323551, "orange") -- Residue
	self:PlaySound(323551, "alert") -- Residue
end
