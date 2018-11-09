
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
	141283, -- Kul Tiran Halberd
	138019  -- Kul Tiran Vanguard
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
	L.vanguard = "Kul Tiran Vanguard"
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
		-- Kul Tiran Vanguard
		257288, -- Heavy Slash
	}, {
		[268260] = L.cannoneer,
		[272874] = L.commander,
		[272421] = L.spotter,
		[257169] = L.demolisher,
		[257170] = L.raider,
		[256957] = L.wavetender,
		[256627] = L.halberd,
		[257288] = L.vanguard,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	
	-- Ashvane Commander
	self:Log("SPELL_CAST_START", "BolsteringShout", 275826)
	self:Log("SPELL_CAST_SUCCESS", "BolsteringShoutSuccess", 275826)
	-- Ashvane Spotter
	self:Log("SPELL_AURA_APPLIED", "SightedArtillery", 272421)
	-- Bilge Rat Demolisher
	self:Log("SPELL_CAST_START", "TerrifyingRoar", 257169)
	-- Irontide Raider
	self:Log("SPELL_CAST_START", "SavageTempest", 257170)
	self:Log("SPELL_CAST_SUCCESS", "SavageTempestSuccess", 257170)
	-- Kul Tiran Wavetender
	self:Log("SPELL_CAST_START", "WatertightShell", 256957)
	self:Log("SPELL_AURA_APPLIED", "WatertightShellApplied", 256957)
	-- Kul Tiran Halberd
	self:Log("SPELL_CAST_START", "SlobberKnocker", 256627)
	
	-- Ashvane Cannoneer's Broadside
	-- Ashvane Commander's Trample
	-- Bilge Rat Demolisher's Crushing Slam
	-- Kul Tiran Vanguard's Heavy Slash
	self:RegisterEvent("UNIT_SPELLCAST_START")
	-- Bilge Rat Demolisher's Crushing Slam
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BolsteringShout(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:BolsteringShoutSuccess(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:SightedArtillery(args)
	self:TargetMessage2(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info")
end

function mod:TerrifyingRoar(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 3)
end

function mod:SavageTempest(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:SavageTempestSuccess(args)
	self:CDBar(257170, 14) -- Savage Tempest
end

function mod:WatertightShell(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:WatertightShellApplied(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:SlobberKnocker(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_START(_, _, castGUID, spellId)
		if spellId == 272711 and castGUID ~= prev then -- Crushing Slam
			prev = castGUID
			self:Message2(spellId, "orange")
			self:PlaySound(spellId, "alert")
			self:CastBar(spellId, 3.5)
		elseif spellId == 268260 and castGUID ~= prev then -- Broadside
			prev = castGUID
			self:Message2(spellId, "orange")
			self:PlaySound(spellId, "alarm")
			self:CastBar(spellId, 3)
		elseif spellId == 272874 and castGUID ~= prev then -- Trample
			prev = castGUID
			self:Message2(spellId, "orange")
			self:PlaySound(spellId, "info")
			self:CastBar(spellId, 3)
		elseif spellId == 257288 and castGUID ~= prev then -- Heavy Slash
			prev = castGUID
			self:Message2(spellId, "orange")
			self:PlaySound(spellId, "alert")
			self:CastBar(spellId, 2.8)
		end
	end
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if spellId == 272711 and castGUID ~= prev then -- Crushing Slam
			prev = castGUID
			self:CDBar(257169, 6) -- Terrifying Roar
		end
	end
end
