--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dargrul", 1458, 1687)
if not mod then return end
mod:RegisterEnableMob(91007)
mod:SetEncounterID(1793)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200732, -- Molten Crash
		200700, -- Landslide
		200637, -- Magma Sculptor
		200154, -- Burning Hatred
		200404, -- Magma Wave
		200551, -- Crystal Spikes
		216407, -- Lava Geyser
	}
end

function mod:OnBossEnable()
	-- TODO any worthwhile emotes/yells?
	self:Log("SPELL_CAST_START", "MoltenCrash", 200732)
	self:Log("SPELL_CAST_START", "Landslide", 200700)
	self:Log("SPELL_CAST_START", "MagmaSculptor", 200637)
	self:Log("SPELL_AURA_APPLIED", "BurningHatred", 200154)
	self:Log("SPELL_CAST_START", "CrystalSpikes", 200551)
	self:Log("SPELL_AURA_APPLIED", "LavaGeyserDamage", 216407)
	self:Log("SPELL_PERIODIC_DAMAGE", "LavaGeyserDamage", 216407)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- for Magma Wave
	self:Log("SPELL_CAST_START", "MagmaWave", 200404)
end

function mod:OnEngage()
	self:CDBar(200551, 6.1) -- Crystal Spikes
	self:CDBar(200637, 9.7) -- Molten Crash
	self:CDBar(200700, 15.8) -- Landslide
	self:CDBar(200732, 19) -- Molten Crash
	self:CDBar(200404, 60.8) -- Magma Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MoltenCrash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	-- TODO pattern? pull:19.0, 17.0, 19.5, 21.8, 34.0, 25.4, 17.0, 17.0, 26.7, 19.4, 21.8, 21.9"
	self:CDBar(args.spellId, 17.0) -- pull:19.1, 17.0, 17.0, 23.1, 19.4
end

function mod:Landslide(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO pattern? pull:15.8, 17.1, 19.5, 21.8, 16.9, 17.0, 25.5, 17.0, 17.0, 26.7, 19.4, 21.8, 21.8"
	self:CDBar(args.spellId, 17.0) -- pull:15.9, 17.0, 17.0, 23.1, 19.4, 17.0
end

function mod:MagmaSculptor(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 71.6)
end

function mod:BurningHatred(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:CrystalSpikes(args)
	-- TODO targeted?
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.8) -- pull:21.9, 21.8, 24.3, 21.8, 21.8
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	-- faster than combat log event for Magma Wave (200404)
	if spellId == 201661 or spellId == 201663 then -- Dargrul Ability Callout 02, Dargrul Ability Callout 03
		self:Message(200404, "red")
		self:PlaySound(200404, "long")
		self:CDBar(200404, 60.6)
		self:CastBar(200404, 7)
	end
end

function mod:MagmaWave(args)
	-- correct the castbar started above
	self:CastBar(200404, {6, 7})
end

do
	local prev = 0
	function mod:LavaGeyserDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end
