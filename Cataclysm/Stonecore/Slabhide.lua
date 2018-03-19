
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Slabhide", 725, 111)
if not mod then return end
mod:RegisterEnableMob(43214)
mod.engageId = 1059
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{80801, "FLASH"}, -- Lava Pool
		92265, -- Crystal Storm
	}
end

function mod:OnBossEnable()
	-- Heroic
	self:Log("SPELL_CAST_START", "CrystalStorm", 92265)
	self:Log("SPELL_AURA_APPLIED", "CrystalStormBegun", 92265)
	-- Normal
	self:Log("SPELL_AURA_APPLIED", "LavaPool", 80801)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrystalStorm(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 2.5, CL.cast:format(args.spellName))
end

function mod:CrystalStormBegun(args)
	self:Bar(args.spellId, 6)
end

function mod:LavaPool(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Alarm")
		self:Flash(args.spellId)
	end
end

