
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Siege of Boralus Trash", 1822)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	138465, -- Ashvane Cannoneer
	128969, -- Ashvane Commander
	135263, -- Ashvane Spotter
	138255, -- Ashvane Spotter
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
	L.cannoneer = "Ashvane Cannoneer"
	L.commander = "Ashvane Commander"
	L.spotter = "Ashvane Spotter"
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
		-- Ashvane Cannoneer
		268260, -- Broadside
		-- Ashvane Commander
		272874, -- Trample
		275826, -- Bolstering Shout
		-- Ashvane Spotter
		272421, -- Sighted Artillery
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
		[268260] = L.cannoneer,
		[272421] = L.spotter,
		[272874] = L.commander,
		[257169] = L.demolisher,
		[257170] = L.raider,
		[256957] = L.wavetender,
		[256627] = L.halberd,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	
	-- Ashvane Cannoneer
	self:Log("SPELL_CAST_START", "Broadside", 268260)
	-- Ashvane Commander
	self:Log("SPELL_CAST_START", "Trample", 272874)
	self:Log("SPELL_CAST_START", "BolsteringShout", 275826)
	-- Ashvane Spotter
	self:Log("SPELL_AURA_APPLIED", "SightedArtillery", 272421)
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
	
	-- Bilge Rat Demolisher's Crushing Slam
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end

function mod:Broadside(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 3)
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

function mod:SightedArtillery(args)
	self:TargetMessage2(args.spellId, "cyan", args.destName)
	self:PlaySound(args.spellId, "info")
end

function mod:TerrifyingRoar(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 3)
end

function mod:TerrifyingRoarSuccess(args)
	-- This timer might not be right
	self:CDBar(272711, 6) -- Crushing Slam
end

function mod:SavageTempest(args)
	self:Message2(args.spellId, "yellow")
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
		self:CastBar(spellId, 3.5)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 272711 then -- Crushing Slam
		self:CDBar(257169, 6) -- Terrifying Roar
	end
end