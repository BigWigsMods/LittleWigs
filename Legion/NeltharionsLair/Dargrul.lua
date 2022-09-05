
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dargrul", 1458, 1687)
if not mod then return end
mod:RegisterEnableMob(91007)
mod.engageId = 1793

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{200732, "TANK"}, -- Molten Crash
		200700, -- Landslide
		200154, -- Burning Hatred
		200404, -- Magma Wave
		200551, -- Crystal Spikes
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MoltenCrash", 200732)
	self:Log("SPELL_CAST_START", "Landslide", 200700)
	self:Log("SPELL_AURA_APPLIED", "BurningHatred", 200154)
	self:Log("SPELL_CAST_START", "CrystalSpikes", 200551)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:CDBar(200700, 15) -- Landslide
	self:CDBar(200732, 18) -- Molten Crash
	self:CDBar(200551, 21) -- Crystal Spikes
	self:CDBar(200404, self:Normal() and 60 or 64) -- Magma Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MoltenCrash(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:CDBar(args.spellId, 17) -- pull:19.1, 17.0, 17.0, 23.1, 19.4
end

function mod:Landslide(args)
	self:MessageOld(args.spellId, "orange", "alert")
	self:CDBar(args.spellId, 17) -- pull:15.9, 17.0, 17.0, 23.1, 19.4, 17.0
end

function mod:BurningHatred(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm")
end

function mod:CrystalSpikes(args)
	self:MessageOld(args.spellId, "green", "alarm")
	self:CDBar(args.spellId, 21) -- pull:21.9, 21.8, 24.3, 21.8, 21.8
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	-- Faster that combat log event for Magma Wave (200404)
	if spellId == 201661 or spellId == 201663 then -- Dargrul Ability Callout 02, Dargrul Ability Callout 03
		self:MessageOld(200404, "green", "long")
		self:CDBar(200404, self:Normal() and 59.7 or 60.8)
		self:Bar(200404, 7, CL.cast:format(self:SpellName(200404)))
	end
end
