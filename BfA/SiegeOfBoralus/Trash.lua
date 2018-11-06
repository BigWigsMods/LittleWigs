
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Siege of Boralus Trash", 1822)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	128969, -- Ashvane Commander
	135245  -- Bilge Rat Demolisher
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.commander = "Ashvane Commander"
	L.demolisher = "Bilge Rat Demolisher"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ashvane Commander
		272874, -- Trample
		-- Bilge Rat Demolisher
		257169, -- Terrifying Roar
		272711, -- Crushing Slam
	}, {
		[272874] = L.commander,
		[257169] = L.demolisher,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	
	-- Ashvane Commander
	self:Log("SPELL_CAST_START", "Trample", 272874)
	
	-- Bilge Rat Demolisher
	self:Log("SPELL_CAST_START", "TerrifyingRoar", 257169)
	self:Log("SPELL_CAST_SUCCESS", "TerrifyingRoarSuccess", 257169)
	
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end

function mod:Trample(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:TerrifyingRoar(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:TerrifyingRoarSuccess(args)
	self:CDBar(272711, 6) -- Crushing Slam
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 272711 then -- Crushing Slam
		self:CDBar(257169, 6) -- Terrifying Roar
	end
end