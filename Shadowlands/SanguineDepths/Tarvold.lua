
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Executor Tarvold", 2284, 2415)
if not mod then return end
mod:RegisterEnableMob(162103)
mod.engageId = 2361
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		{322554, "SAY"}, -- Castigate
		322573, -- Coalesce Manifestation
		{328494, "DISPEL"}, -- Sintouched Anima
		-- Fleeting Manifestation
		323551, -- Residue
	}, {
		[322554] = "general",
		[323551] = -21883, -- Fleeting Manifestation
	}
end

function mod:OnBossEnable()
	-- XXX Change to RegisterUnitEvent if boss frames get added to this fight
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:Log("SPELL_CAST_START", "Castigate", 322554)
	self:Log("SPELL_AURA_APPLIED", "SintouchedAnimaApplied", 328494)
	self:Death("FleetingManifestationDeath", 165556)
end

function mod:OnEngage()
	self:Bar(322554, 4.7) -- Castigate
	self:CDBar(322573, 10.8) -- Coalesce Manifestation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prevGUID = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if spellId == 322573 and prevGUID ~= castGUID then -- Coalesce Manifestation
			prevGUID = castGUID

			self:Message(322573, "yellow")
			self:PlaySound(322573, "info")
			self:CDBar(322573, 30)
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(322554, "orange", name)
		self:PlaySound(322554, "alert", nil, name)
		if self:Me(guid) then
			self:Say(322554)
		end
	end

	function mod:Castigate(args)
		-- XXX Change to GetBossTarget if boss frames get added to this fight
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

function mod:FleetingManifestationDeath(args)
	self:Message(323551, "orange") -- Residue
	self:PlaySound(323551, "alert") -- Residue
end
