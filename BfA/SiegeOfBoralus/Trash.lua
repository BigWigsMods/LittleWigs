
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
	135241, -- Bilge Rat Pillager
	129367, -- Bilge Rat Tempest
	129369, -- Irontide Raider
	141284, -- Kul Tiran Wavetender
	141283, -- Kul Tiran Halberd
	138019, -- Kul Tiran Vanguard
	141285, -- Kul Tiran Marksman
	129366, -- Bilge Rat Buccaneer
	137516, -- Ashvane Invader
	129370, -- Irontide Waveshaper
	137521, -- Irontide Powdershot
	129374, -- Scrimshaw Enforcer (Alliance)
	129371, -- Riptide Shredder (Alliance)
	129640, -- Snarling Dockhound (Alliance)
	129373, -- Dockhound Packmaster (Alliance)
	129372  -- Blacktar Bomber (Alliance)
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
	L.pillager = "Bilge Rat Pillager"
	L.tempest = "Bilge Rat Tempest"
	L.wavetender = "Kul Tiran Wavetender"
	L.halberd = "Kul Tiran Halberd"
	L.raider = "Irontide Raider"
	L.vanguard = "Kul Tiran Vanguard"
	L.marksman = "Kul Tiran Marksman"
	L.buccaneer = "Bilge Rat Buccaneer"
	L.invader = "Ashvane Invader"
	L.dockhound = "Snarling Dockhound"
	L.shredder = "Riptide Shredder"
	L.packmaster = "Dockhound Packmaster"
	L.bomber = "Blackar Bomber"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ashvane Cannoneer
		{268260, "CASTBAR"}, -- Broadside
		-- Ashvane Commander
		{272874, "CASTBAR"}, -- Trample
		275826, -- Bolstering Shout
		-- Ashvane Invader
		275835, -- Stinging Venom Coating
		-- Ashvane Spotter
		{272421, "SAY"}, -- Sighted Artillery
		-- Bilge Rat Demolisher
		{257169, "CASTBAR"}, -- Terrifying Roar
		{272711, "CASTBAR"}, -- Crushing Slam
		-- Bilge Rat Pillager
		272827, -- Viscous Slobber
		-- Bilge Rat Tempest
		274569, -- Revitalizing Mist
		-- Bilge Rat Buccaneer
		272546, -- Banana Rampage
		-- Irontide Raider
		257170, -- Savage Tempest
		-- Kul Tiran Wavetender
		256957, -- Watertight Shell
		-- Kul Tiran Halberd
		256627, -- Slobber Knocker
		-- Kul Tiran Vanguard
		{257288, "CASTBAR"}, -- Heavy Slash
		-- Kul Tiran Marksman
		257641, -- Molten Slug
		-- Snarling Dockhound
		256897, -- Clamping Jaws
		-- Riptide Shredder
		256866, -- Iron Ambush
		-- Dockhound Packmaster
		{257036, "SAY"}, -- Feral Charge
		-- Blacktar Bomber
		256640, -- Burning Tar
		256673, -- Immolation
	}, {
		[268260] = L.cannoneer,
		[272874] = L.commander,
		[275835] = L.invader,
		[272421] = L.spotter,
		[257169] = L.demolisher,
		[272827] = L.pillager,
		[274569] = L.tempest,
		[272546] = L.buccaneer,
		[257170] = L.raider,
		[256957] = L.wavetender,
		[256627] = L.halberd,
		[257288] = L.vanguard,
		[257641] = L.marksman,
		[256897] = L.dockhound,
		[256866] = L.shredder,
		[257036] = L.packmaster,
		[256640] = L.bomber,
	}
end

function mod:OnBossEnable()
	-- Ashvane Commander
	self:Log("SPELL_CAST_START", "BolsteringShout", 275826)
	self:Log("SPELL_CAST_SUCCESS", "BolsteringShoutSuccess", 275826)
	-- Ashvane Invader
	self:Log("SPELL_CAST_START", "StingingVenomCoating", 275835)
	-- Ashvane Spotter
	self:Log("SPELL_AURA_APPLIED", "SightedArtillery", 272421)
	-- Bilge Rat Demolisher
	self:Log("SPELL_CAST_START", "TerrifyingRoar", 257169)
	-- Bilge Rat Pillager
	self:Log("SPELL_CAST_START", "ViscousSlobber", 272827)
	-- Bilge Rat Tempest
	self:Log("SPELL_CAST_START", "RevitalizingMist", 274569)
	-- Bilge Rat Buccaneer
	self:Log("SPELL_CAST_START", "BananaRampage", 272546)
	-- Irontide Raider
	self:Log("SPELL_CAST_START", "SavageTempest", 257170)
	self:Log("SPELL_CAST_SUCCESS", "SavageTempestSuccess", 257170)
	self:Death("IrontideRaiderDeath", 129369)
	-- Kul Tiran Wavetender
	self:Log("SPELL_CAST_START", "WatertightShell", 256957)
	self:Log("SPELL_AURA_APPLIED", "WatertightShellApplied", 256957)
	-- Kul Tiran Halberd
	self:Log("SPELL_CAST_START", "SlobberKnocker", 256627)
	-- Kul Tiran Marksman
	self:Log("SPELL_CAST_START", "MoltenSlug", 257641)
	-- Snarling Dockhound
	self:Log("SPELL_CAST_SUCCESS", "ClampingJaws", 256897)
	-- Riptide Shredder
	self:Log("SPELL_CAST_START", "IronAmbush", 256866)
	-- Dockhound Packmaster
	self:Log("SPELL_CAST_START", "FeralCharge", 257036)
	-- Blacktar Bomber
	self:Log("SPELL_CAST_SUCCESS", "BurningTar", 256640)
	self:Log("SPELL_CAST_START", "Immolation", 256673)

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
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:BolsteringShoutSuccess(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:StingingVenomCoating(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:SightedArtillery(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info")
	self:TargetBar(args.spellId, 6, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Sighted Artillery")
	end
end

function mod:TerrifyingRoar(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 3)
end

function mod:ViscousSlobber(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:RevitalizingMist(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:BananaRampage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SavageTempest(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:SavageTempestSuccess(args)
	self:CDBar(args.spellId, 14)
end

function mod:IrontideRaiderDeath(args)
	self:StopBar(257170) -- Savage Tempest
end

function mod:WatertightShell(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:WatertightShellApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:SlobberKnocker(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:PersonalMessage(257641) -- Molten Slug
				self:PlaySound(257641, "info") -- Molten Slug
			end
		end
	end

	function mod:MoltenSlug(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:ClampingJaws(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:IronAmbush(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(257036, "orange", name)
		self:PlaySound(257036, "alert", nil, name)
		if self:Me(guid) then
			self:Say(257036, nil, nil, "Feral Charge")
		end
	end

	function mod:FeralCharge(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:BurningTar(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Immolation(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_START(_, unit, castGUID, spellId)
		if spellId == 272711 and castGUID ~= prev then -- Crushing Slam
			prev = castGUID
			self:Message(spellId, "orange")
			self:PlaySound(spellId, "alert")
			self:CastBar(spellId, 3.5)
		elseif spellId == 268260 and castGUID ~= prev then -- Broadside
			local guid = self:UnitGUID(unit)
			if self:MobId(guid) == 138465 then -- Trash cannoneer, Lockwood cannoneers have a different id
				prev = castGUID
				self:Message(spellId, "orange")
				self:PlaySound(spellId, "alarm")
				self:CastBar(spellId, 3)
			end
		elseif spellId == 272874 and castGUID ~= prev then -- Trample
			prev = castGUID
			self:Message(spellId, "orange")
			self:PlaySound(spellId, "info")
			self:CastBar(spellId, 3)
		elseif spellId == 257288 and castGUID ~= prev then -- Heavy Slash
			prev = castGUID
			self:Message(spellId, "orange")
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
