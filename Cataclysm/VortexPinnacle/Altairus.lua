--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Altairus", 657, 115)
if not mod then return end
mod:RegisterEnableMob(43873)
mod:SetEncounterID(1041)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-2425, -- Call the Wind
		88282, -- Upwind of Altairus
		88286, -- Downwind of Altairus
		88308, -- Chilling Breath
		88357, -- Lightning Blast
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Call the Wind
	self:Log("SPELL_AURA_APPLIED", "UpwindOfAltairus", 88282)
	self:Log("SPELL_AURA_APPLIED", "DownwindOfAltairus", 88286)
	self:Log("SPELL_AURA_REMOVED", "DownwindOfAltairusRemoved", 88286)
	self:Log("SPELL_CAST_START", "ChillingBreath", 88308)
	self:Log("SPELL_CAST_START", "LightningBlast", 88357)
end

function mod:OnEngage()
	self:Bar(-2425, 5.9, nil, 88276) -- Call the Wind
	self:Bar(88308, 10.7) -- Chilling Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 88276 then -- Call the Wind
		self:Message(-2425, "cyan", nil, spellId)
		self:PlaySound(-2425, "long")
		self:Bar(-2425, 20.6, nil, spellId)
	end
end

do
	-- TODO this is no longer needed in 10.1+
	local haveDownwind = false -- for some reason players get spammed by SPELL_AURA_APPLIED events from Upwind when they have Downwind

	function mod:UpwindOfAltairus(args)
		if self:Me(args.destGUID) and not haveDownwind then
			self:Message(args.spellId, "green", CL.you:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end

	function mod:DownwindOfAltairus(args)
		if self:Me(args.destGUID) then
			haveDownwind = true
			self:Message(args.spellId, "red", CL.you:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:DownwindOfAltairusRemoved(args)
		if self:Me(args.destGUID) then
			haveDownwind = false
		end
	end
end

function mod:ChillingBreath(args)
	-- TODO any way to get target?
	-- boss seems to detarget before casting this, previously this used self:UnitName("boss1target")
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if self:Mythic() then
		self:Bar(args.spellId, 19.4)
	else
		-- TODO confirm once 10.1 is live
		self:Bar(args.spellId, 12)
	end
end

function mod:LightningBlast(args)
	-- only cast when a player is too far from the arena
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
