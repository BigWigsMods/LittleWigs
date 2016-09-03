
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dargrul", 1065, 1687)
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
	self:CDBar(200732, 18) -- Molten Crash
	self:CDBar(200700, 15) -- Landslide
	self:CDBar(200404, 61) -- Magma Wave
	self:CDBar(200551, 21) -- Crystal Spikes
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MoltenCrash(args)
	self:Message(args.spellId, "red", "Warning")
	self:CDBar(args.spellId, 17)
end

function mod:Landslide(args)
	self:Message(args.spellId, "orange", "Alert")
	self:CDBar(args.spellId, 17)
end

function mod:BurningHatred(args)
	self:TargetMessage(args.spellId, args.destName, "yellow", "Alarm")
end

function mod:CrystalSpikes(args)
	self:Message(args.spellId, "green", "Alarm")
	self:CDBar(args.spellId, 21)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	-- Faster that combat log event for Magma Wave (200404)
	if spellId == 201661 then -- Dargrul Ability Callout 02
		self:Message(200404, "green", "Long")
		--self:CDBar(args.spellId, 21)
		self:Bar(200404, 7, CL.cast:format(self:SpellName(200404)))
	end
end
