
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Siege of Boralus Trash", 1822)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	128969, -- Ashvane Commander
	135245, -- Bilge Rat Demolisher
	129369, -- Irontide Raider
	141284, -- Kul Tiran Wavetender
	141283  -- Kul Tiran Halberd
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.commander = "Ashvane Commander"
	L.demolisher = "Bilge Rat Demolisher"
	L.wavetender = "Kul Tiran Wavetender"
	L.halberd = "Kul Tiran Halberd"
	L.raider = "Irontide Raider"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ashvane Commander
		272874, -- Trample
		275826, -- Bolstering Shout
		-- Bilge Rat Demolisher
		257169, -- Terrifying Roar
		272711, -- Crushing Slam
		-- Irontide Raider
		257170, -- Savage Tempest
		-- Kul Tiran Wavetender
		256957, -- Watertight Shell
		-- Kul Tiran Halberd
		256627, -- Slobber Knocker
	}, {
		[272874] = L.commander,
		[257169] = L.demolisher,
		[257170] = L.raider,
		[256957] = L.wavetender,
		[256627] = L.halberd,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	
	-- Ashvane Commander
	self:Log("SPELL_CAST_START", "Trample", 272874)
	self:Log("SPELL_CAST_START", "BolsteringShout", 275826)
	
	-- Bilge Rat Demolisher
	self:Log("SPELL_CAST_START", "TerrifyingRoar", 257169)
	self:Log("SPELL_CAST_SUCCESS", "TerrifyingRoarSuccess", 257169)
	
	-- Irontide Raider
	self:Log("SPELL_CAST_START", "SavageTempest", 257170)
	self:Log("SPELL_CAST_SUCCESS", "SavageTempestSuccess", 257170)
	
	-- Kul Tiran Wavetender
	self:Log("SPELL_CAST_START", "WatertightShell", 256957)
	
	-- Kul Tiran Halberd
	self:Log("SPELL_CAST_START", "SlobberKnocker", 256627)
	
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end

function mod:Trample(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 3)
end

function mod:BolsteringShout(args)
	self:Message2(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:TerrifyingRoar(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:TerrifyingRoarSuccess(args)
	-- This timer might not be right
	self:CDBar(272711, 6) -- Crushing Slam
end

function mod:SavageTempest(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
end

function mod:SavageTempestSuccess(args)
	self:CDBar(257170, 14) -- Savage Tempest
end

function mod:WatertightShell(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SlobberKnocker(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:UNIT_SPELLCAST_START(_, _, _, spellId)
	if spellId == 272711 then -- Crushing Slam
		self:Message2(spellId, "orange")
		self:PlaySound(spellId, "alert")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 272711 then -- Crushing Slam
		self:CDBar(257169, 6) -- Terrifying Roar
	end
end