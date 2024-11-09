--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Siege of Boralus Trash", 1822)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	129374, -- Scrimshaw Enforcer (Alliance)
	141283, -- Kul Tiran Halberd (Horde)
	138002, -- Scrimshaw Gutter (Alliance, RP fights)
	133990, -- Scrimshaw Gutter (Alliance)
	129372, -- Blacktar Bomber
	129370, -- Irontide Waveshaper
	144071, -- Irontide Waveshaper
	141284, -- Kul Tiran Wavetender (Horde)
	129369, -- Irontide Raider
	129371, -- Riptide Shredder
	138019, -- Kul Tiran Vanguard (Horde)
	128969, -- Ashvane Commander
	135258, -- Irontide Curseblade
	138247, -- Irontide Curseblade (RP fights)
	135263, -- Ashvane Spotter
	138255, -- Ashvane Spotter
	138465, -- Ashvane Cannoneer
	135245, -- Bilge Rat Demolisher
	129366, -- Bilge Rat Buccaneer
	135241, -- Bilge Rat Pillager
	129367, -- Bilge Rat Tempest
	137516 -- Ashvane Invader
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.enforcer = "Scrimshaw Enforcer"
	L.halberd = "Kul Tiran Halberd"
	L.gutter = "Scrimshaw Gutter"
	L.bomber = "Blackar Bomber"
	L.waveshaper = "Irontide Waveshaper"
	L.wavetender = "Kul Tiran Wavetender"
	L.raider = "Irontide Raider"
	L.shredder = "Riptide Shredder"
	L.vanguard = "Kul Tiran Vanguard"
	L.commander = "Ashvane Commander"
	L.curseblade = "Irontide Curseblade"
	L.spotter = "Ashvane Spotter"
	L.cannoneer = "Ashvane Cannoneer"
	L.demolisher = "Bilge Rat Demolisher"
	L.buccaneer = "Bilge Rat Buccaneer"
	L.pillager = "Bilge Rat Pillager"
	L.tempest = "Bilge Rat Tempest"
	L.invader = "Ashvane Invader"

	L.gate_open = CL.gate_open
	L.gate_open_desc = "Show a bar indicating when the gate to the next area will open after defeating each boss."
	L.gate_open_icon = "achievement_dungeon_siegeofboralus"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- RP Timers
		"gate_open",
		-- Scrimshaw Enforcer / Kul Tiran Halberd
		{256627, "NAMEPLATE"}, -- Slobber Knocker
		{257732, "NAMEPLATE"}, -- Shattering Bellow
		-- Scrimshaw Gutter
		{256616, "TANK", "NAMEPLATE"}, -- Tooth Breaker
		-- Blacktar Bomber
		{256640, "NAMEPLATE"}, -- Burning Tar
		-- Irontide Waveshaper / Kul Tiran Wavetender
		{256957, "NAMEPLATE"}, -- Watertight Shell
		-- Irontide Raider
		{272662, "NAMEPLATE"}, -- Iron Hook
		{257170, "NAMEPLATE"}, -- Savage Tempest
		-- Riptide Shredder
		{257270, "NAMEPLATE", "OFF"}, -- Iron Ambush
		-- Kul Tiran Vanguard
		{257288, "NAMEPLATE"}, -- Heavy Slash
		-- Ashvane Commander
		{454437, "SAY", "NAMEPLATE"}, -- Azerite Charge
		{275826, "NAMEPLATE"}, -- Bolstering Shout
		-- Irontide Curseblade
		{257168, "TANK", "NAMEPLATE", "OFF"}, -- Cursed Slash
		-- Ashvane Spotter
		{272421, "SAY", "NAMEPLATE"}, -- Sighted Artillery
		-- Ashvane Cannoneer
		{268260, "NAMEPLATE"}, -- Broadside
		-- Bilge Rat Demolisher
		{257169, "NAMEPLATE"}, -- Terrifying Roar
		{272711, "NAMEPLATE"}, -- Crushing Slam
		-- Bilge Rat Buccaneer
		{272546, "NAMEPLATE"}, -- Banana Rampage
		-- Bilge Rat Pillager
		{454440, "NAMEPLATE"}, -- Stinky Vomit
		-- Bilge Rat Tempest
		{272571, "NAMEPLATE"}, -- Choking Waters
		-- Ashvane Invader
		{275835, "TANK", "NAMEPLATE"}, -- Stinging Venom Coating
	}, {
		[256627] = L.halberd.." / "..L.enforcer,
		[256616] = L.gutter,
		[256640] = L.bomber,
		[256957] = L.wavetender.." / "..L.waveshaper,
		[272662] = L.raider,
		[257270] = L.shredder,
		[257288] = L.vanguard,
		[454437] = L.commander,
		[257168] = L.curseblade,
		[272421] = L.spotter,
		[268260] = L.cannoneer,
		[257169] = L.demolisher,
		[272546] = L.buccaneer,
		[454440] = L.pillager,
		[272571] = L.tempest,
		[275835] = L.invader,
	}
end

function mod:OnBossEnable()
	-- Scrimshaw Enforcer / Kul Tiran Halberd
	self:RegisterEngageMob("KulTiranHalberdEngaged", 141283, 129374) -- Enforcer, Halberd
	self:Log("SPELL_CAST_START", "SlobberKnocker", 256627)
	self:Log("SPELL_CAST_START", "ShatteringBellow", 257732)
	self:Death("KulTiranHalberdDeath", 141283, 129374) -- Enforcer, Halberd

	-- Scrimshaw Gutter
	self:RegisterEngageMob("ScrimshawGutterEngaged", 133990) -- 138002 RP fights
	self:Log("SPELL_CAST_START", "ToothBreaker", 256616)
	self:Log("SPELL_CAST_SUCCESS", "ToothBreakerSuccess", 256616)
	self:Death("ScrimshawGutterDeath", 138002, 133990)

	-- Blacktar Bomber
	self:RegisterEngageMob("BlacktarBomberEngaged", 129372)
	self:Log("SPELL_CAST_SUCCESS", "BurningTar", 256640)
	self:Log("SPELL_PERIODIC_DAMAGE", "BurningTarDamage", 256663)
	self:Death("BlacktarBomberDeath", 129372)

	-- Irontide Waveshaper / Kul Tiran Wavetender
	self:RegisterEngageMob("KulTiranWavetenderEngaged", 129370, 144071, 141284) -- Waveshaper, Waveshaper, Wavetender
	self:Log("SPELL_CAST_START", "WatertightShell", 256957)
	self:Log("SPELL_INTERRUPT", "WatertightShellInterrupt", 256957)
	self:Log("SPELL_CAST_SUCCESS", "WatertightShellSuccess", 256957)
	self:Log("SPELL_AURA_APPLIED", "WatertightShellApplied", 256957)
	self:Death("KulTiranWavetenderDeath", 129370, 144071, 141284) -- Waveshaper, Waveshaper, Wavetender

	-- Irontide Raider
	self:RegisterEngageMob("IrontideRaiderEngaged", 129369)
	self:Log("SPELL_CAST_START", "IronHook", 272662)
	self:Log("SPELL_CAST_START", "SavageTempest", 257170)
	self:Death("IrontideRaiderDeath", 129369)

	-- Riptide Shredder
	self:RegisterEngageMob("RiptideShredderEngaged", 129371)
	self:Log("SPELL_CAST_SUCCESS", "IronAmbush", 257270)
	self:Death("RiptideShredderDeath", 129371)

	-- Kul Tiran Vanguard (Horde-only)
	self:RegisterEngageMob("KulTiranVanguardEngaged", 138019)
	self:Log("SPELL_CAST_START", "HeavySlash", 257288)
	self:Death("KulTiranVanguardDeath", 138019)

	-- Ashvane Commander
	self:RegisterEngageMob("AshvaneCommanderEngaged", 128969)
	self:Log("SPELL_CAST_SUCCESS", "AzeriteCharge", 454437)
	self:Log("SPELL_AURA_APPLIED", "AzeriteChargeApplied", 454437)
	self:Log("SPELL_CAST_START", "BolsteringShout", 275826)
	self:Log("SPELL_INTERRUPT", "BolsteringShoutInterrupt", 275826)
	self:Log("SPELL_CAST_SUCCESS", "BolsteringShoutSuccess", 275826)
	self:Death("AshvaneCommanderDeath", 128969)

	-- Irontide Curseblade
	self:RegisterEngageMob("IrontideCursebladeEngaged", 135258) -- 138247 RP fights
	self:Log("SPELL_CAST_SUCCESS", "CursedSlash", 257168)
	self:Death("IrontideCursebladeDeath", 135258, 138247)

	-- Ashvane Spotter
	self:RegisterEngageMob("AshvaneSpotterEngaged", 135263, 138255)
	self:Log("SPELL_CAST_SUCCESS", "SightedArtillery", 272422)
	self:Log("SPELL_AURA_APPLIED", "SightedArtilleryApplied", 272421)
	self:Death("AshvaneSpotterDeath", 135263, 138255)

	-- Ashvane Cannoneer
	self:RegisterEngageMob("AshvaneCannoneerEngaged", 138465)
	self:Log("SPELL_CAST_START", "Broadside", 268260)
	self:Death("AshvaneCannoneerDeath", 138465)

	-- Bilge Rat Demolisher
	self:RegisterEngageMob("BilgeRatDemolisherEngaged", 135245)
	self:Log("SPELL_CAST_START", "TerrifyingRoar", 257169)
	self:Log("SPELL_CAST_START", "CrushingSlam", 272711)
	self:Death("BilgeRatDemolisherDeath", 135245)

	-- Bilge Rat Buccaneer
	self:RegisterEngageMob("BilgeRatBuccaneerEngaged", 129366)
	self:Log("SPELL_CAST_START", "BananaRampage", 272546)
	self:Log("SPELL_CAST_SUCCESS", "BananaRampageSuccess", 272546)
	self:Death("BilgeRatBuccaneerDeath", 129366)

	-- Bilge Rat Pillager
	self:RegisterEngageMob("BilgeRatPillagerEngaged", 135241)
	self:Log("SPELL_CAST_START", "StinkyVomit", 454440)
	self:Log("SPELL_INTERRUPT", "StinkyVomitInterrupt", 454440)
	self:Log("SPELL_CAST_SUCCESS", "StinkyVomitSuccess", 454440)
	self:Death("BilgeRatPillagerDeath", 135241)

	-- Bilge Rat Tempest
	self:RegisterEngageMob("BilgeRatTempestEngaged", 129367)
	self:Log("SPELL_CAST_START", "ChokingWaters", 272571)
	self:Log("SPELL_INTERRUPT", "ChokingWatersInterrupt", 272571)
	self:Log("SPELL_CAST_SUCCESS", "ChokingWatersSuccess", 272571)
	self:Death("BilgeRatTempestDeath", 129367)

	-- Ashvane Invader
	self:RegisterEngageMob("AshvaneInvaderEngaged", 137516)
	self:Log("SPELL_CAST_SUCCESS", "StingingVenomCoating", 275835)
	self:Death("AshvaneInvaderDeath", 137516)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- RP Timers

-- triggered from Chopper Redhook's and Sergeant Bainbridge's :OnWin
function mod:FirstBossDefeated()
	self:Bar("gate_open", 4.2, L.gate_open, L.gate_open_icon)
end

-- triggered from Dread Captain Lockwood's :OnWin
function mod:LockwoodDefeated()
	self:Bar("gate_open", 4.8, L.gate_open, L.gate_open_icon)
end

-- triggered from Hadal Darkfathom's :OnWin
function mod:DarkfathomDefeated()
	if self:Mythic() or self:Heroic() then -- Alliance version
		self:Bar("gate_open", 12.3, L.gate_open, L.gate_open_icon)
	--else -- we might be in the Horde version which has a shorter timer
		--self:Bar("gate_open", 4.9, L.gate_open, L.gate_open_icon)
	end
end

-- Scrimshaw Enforcer / Kul Tiran Halberd

function mod:KulTiranHalberdEngaged(guid)
	self:Nameplate(256627, 5.6, guid) -- Slobber Knocker
	self:Nameplate(257732, 13.1, guid) -- Shattering Bellow
end

function mod:SlobberKnocker(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 20.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ShatteringBellow(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 27.9, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:KulTiranHalberdDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Scrimshaw Gutter

function mod:ScrimshawGutterEngaged(guid)
	self:Nameplate(256616, 2.3, guid) -- Tooth Breaker
end

do
	local prev = 0
	function mod:ToothBreaker(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:ToothBreakerSuccess(args)
	self:Nameplate(args.spellId, 18.0, args.sourceGUID)
end

function mod:ScrimshawGutterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Blacktar Bomber

function mod:BlacktarBomberEngaged(guid)
	self:Nameplate(256640, 7.1, guid) -- Burning Tar
end

do
	local prev = 0
	function mod:BurningTar(args)
		self:Nameplate(args.spellId, 20.3, args.sourceGUID)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:BurningTarDamage(args)
		local t = args.time
		if self:Me(args.destGUID) and t - prev > 1.5 then
			prev = t
			self:PersonalMessage(256640, "underyou")
			self:PlaySound(256640, "underyou")
		end
	end
end

function mod:BlacktarBomberDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Irontide Waveshaper / Kul Tiran Wavetender

function mod:KulTiranWavetenderEngaged(guid)
	self:Nameplate(256957, 7.0, guid) -- Watertight Shell
end

function mod:WatertightShell(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:WatertightShellInterrupt(args)
	self:Nameplate(256957, 30.9, args.destGUID)
end

function mod:WatertightShellSuccess(args)
	self:Nameplate(args.spellId, 30.9, args.sourceGUID)
end

function mod:WatertightShellApplied(args)
	if not self:Friendly(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:KulTiranWavetenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Irontide Raider

function mod:IrontideRaiderEngaged(guid)
	self:Nameplate(272662, 5.6, guid) -- Iron Hook
	self:Nameplate(257170, 8.0, guid) -- Savage Tempest
end

function mod:IronHook(args)
	-- this is also cast by the first boss in the Alliance version (Chopper Redhook)
	if self:MobId(args.sourceGUID) == 129369 then -- Irontide Raider
		self:Message(args.spellId, "cyan")
		self:Nameplate(args.spellId, 23.0, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:SavageTempest(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 23.0, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:IrontideRaiderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Riptide Shredder

function mod:RiptideShredderEngaged(guid)
	self:Nameplate(257270, 14.5, guid) -- Iron Ambush
end

do
	local prev = 0
	function mod:IronAmbush(args)
		self:Nameplate(args.spellId, 25.5, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alarm", nil, args.destName)
		end
	end
end

function mod:RiptideShredderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Kul Tiran Vanguard (Horde-only)

function mod:KulTiranVanguardEngaged(guid)
	self:Nameplate(257288, 7.3, guid) -- Heavy Slash
end

function mod:HeavySlash(args)
	if self:MobId(args.sourceGUID) == 138019 then -- Horde-only trash version
		self:Message(args.spellId, "purple")
		self:Nameplate(args.spellId, 20.2, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:KulTiranVanguardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ashvane Commander

function mod:AshvaneCommanderEngaged(guid)
	self:Nameplate(454437, 2.3, guid) -- Azerite Charge
	self:Nameplate(275826, 8.3, guid) -- Bolstering Shout
end

function mod:AzeriteCharge(args)
	self:Nameplate(args.spellId, 15.8, args.sourceGUID)
end

function mod:AzeriteChargeApplied(args)
	if self:Player(args.destFlags) then -- can be cast on friendly NPCs during RP fighting
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Azerite Charge")
		end
	end
end

function mod:BolsteringShout(args)
	-- only cast if there are nearby mobs
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:BolsteringShoutInterrupt(args)
	self:Nameplate(275826, 15.3, args.destGUID)
end

function mod:BolsteringShoutSuccess(args)
	self:Nameplate(args.spellId, 15.3, args.sourceGUID)
	if self:Dispeller("magic", true) then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:AshvaneCommanderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Irontide Curseblade

function mod:IrontideCursebladeEngaged(guid)
	self:Nameplate(257168, 3.5, guid) -- Cursed Slash
end

do
	local prev = 0
	function mod:CursedSlash(args)
		self:Nameplate(args.spellId, 15.8, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:IrontideCursebladeDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ashvane Spotter

function mod:AshvaneSpotterEngaged(guid)
	self:Nameplate(272421, 3.6, guid) -- Sighted Artillery
end

function mod:SightedArtillery(args)
	local mobId = self:MobId(args.sourceGUID)
	if mobId == 135263 or mobId == 138255 then -- Ashvane Spotter
		self:Nameplate(272421, 12.2, args.sourceGUID)
	end
end

function mod:SightedArtilleryApplied(args)
	local mobId = self:MobId(args.sourceGUID)
	if mobId == 135263 or mobId == 138255 then -- Ashvane Spotter
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Sighted Artillery")
		end
	end
end

function mod:AshvaneSpotterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ashvane Cannoneer

function mod:AshvaneCannoneerEngaged(guid)
	self:Nameplate(268260, 9.6, guid) -- Broadside
end

function mod:Broadside(args)
	if self:MobId(args.sourceGUID) == 138465 then -- trash version
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 11.0, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:AshvaneCannoneerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bilge Rat Demolisher

function mod:BilgeRatDemolisherEngaged(guid)
	self:Nameplate(272711, 4.8, guid) -- Crushing Slam
	self:Nameplate(257169, 13.3, guid) -- Terrifying Roar
end

function mod:TerrifyingRoar(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 29.2, args.sourceGUID)
	self:PlaySound(args.spellId, "warning")
end

function mod:CrushingSlam(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 20.6, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:BilgeRatDemolisherDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bilge Rat Buccaneer

function mod:BilgeRatBuccaneerEngaged(guid)
	self:Nameplate(272546, 2.8, guid) -- Banana Rampage
end

do
	local prev = 0
	function mod:BananaRampage(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:BananaRampageSuccess(args)
	self:Nameplate(args.spellId, 15.5, args.sourceGUID)
end

function mod:BilgeRatBuccaneerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bilge Rat Pillager

function mod:BilgeRatPillagerEngaged(guid)
	self:Nameplate(454440, 3.1, guid) -- Stinky Vomit
end

do
	local prev = 0
	function mod:StinkyVomit(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:StinkyVomitInterrupt(args)
	self:Nameplate(454440, 14.0, args.destGUID)
end

function mod:StinkyVomitSuccess(args)
	self:Nameplate(args.spellId, 14.0, args.sourceGUID)
end

function mod:BilgeRatPillagerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bilge Rat Tempest

function mod:BilgeRatTempestEngaged(guid)
	self:Nameplate(272571, 5.8, guid) -- Choking Waters
end

function mod:ChokingWaters(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:ChokingWatersInterrupt(args)
	self:Nameplate(272571, 21.8, args.destGUID)
end

function mod:ChokingWatersSuccess(args)
	self:Nameplate(args.spellId, 21.8, args.sourceGUID)
end

function mod:BilgeRatTempestDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ashvane Invader

function mod:AshvaneInvaderEngaged(guid)
	self:Nameplate(275835, 5.0, guid) -- Stinging Venom Coating
end

do
	local prev = 0
	function mod:StingingVenomCoating(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "info")
		end
		self:Nameplate(args.spellId, 17.1, args.sourceGUID)
	end
end

function mod:AshvaneInvaderDeath(args)
	self:ClearNameplate(args.destGUID)
end
