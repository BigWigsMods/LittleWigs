
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
	}, {
		[80801] = "general",
		[92265] = "heroic",
	}
end

function mod:OnBossEnable()
	-- Normal
	self:Log("SPELL_AURA_APPLIED", "LavaPool", 80801)

	-- Heroic
	self:Log("SPELL_CAST_START", "CrystalStorm", 92265)
	self:Log("SPELL_AURA_APPLIED", "CrystalStormBegun", 92265)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LavaPool(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
		self:Flash(args.spellId)
	end
end

function mod:CrystalStorm(args)
	self:MessageOld(args.spellId, "red", "alert", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 2.5, CL.cast:format(args.spellName))
end

function mod:CrystalStormBegun(args)
	self:Bar(args.spellId, 6)
end
