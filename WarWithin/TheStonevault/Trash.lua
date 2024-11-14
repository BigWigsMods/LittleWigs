--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Stonevault Trash", 2652)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	210109, -- Earth Infused Golem
	222923, -- Repurposed Loaderbot
	212453, -- Ghastly Voidsoul
	212389, -- Cursedheart Invader
	212403, -- Cursedheart Invader
	212765, -- Void Bound Despoiler
	221979, -- Void Bound Howler
	214350, -- Turned Speaker
	212400, -- Void Touched Elemental
	213338, -- Forgebound Mender
	213343, -- Forge Loader
	214264, -- Cursedforge Honor Guard
	214066, -- Cursedforge Stoneshaper
	224962, -- Cursedforge Mender
	213954 -- Rock Smasher
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.earth_infused_golem = "Earth Infused Golem"
	L.repurposed_loaderbot = "Repurposed Loaderbot"
	L.ghastly_voidsoul = "Ghastly Voidsoul"
	L.cursedheart_invader = "Cursedheart Invader"
	L.void_bound_despoiler = "Void Bound Despoiler"
	L.void_bound_howler = "Void Bound Howler"
	L.turned_speaker = "Turned Speaker"
	L.void_touched_elemental = "Void Touched Elemental"
	L.forgebound_mender = "Forgebound Mender"
	L.forge_loader = "Forge Loader"
	L.cursedforge_honor_guard = "Cursedforge Honor Guard"
	L.cursedforge_stoneshaper = "Cursedforge Stoneshaper"
	L.rock_smasher = "Rock Smasher"

	L.edna_warmup_trigger = "What's this? Is that golem fused with something else?"
	L.custom_on_autotalk = CL.autotalk
	L.custom_on_autotalk_desc = "|cFFFF0000Requires Warrior, Dwarf, or 25 skill in Khaz Algar Blacksmithing.|r Automatically select the NPC dialog option that grants your group the 'Imbued Iron Energy' aura."
	L.custom_on_autotalk_icon = mod:GetMenuIcon("SAY")

	L["425027_icon"] = "ability_earthen_pillar" -- change the icon of Seismic Wave so it doesn't match Ground Pound
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Autotalk
		"custom_on_autotalk",
		462500, -- Imbued Iron Energy
		-- Earth Infused Golem
		{425027, "NAMEPLATE"}, -- Seismic Wave
		{425974, "NAMEPLATE"}, -- Ground Pound
		-- Repurposed Loaderbot
		{447141, "NAMEPLATE"}, -- Pulverizing Pounce
		-- Ghastly Voidsoul
		{449455, "NAMEPLATE"}, -- Howling Fear
		-- Cursedheart Invader
		{426308, "DISPEL", "NAMEPLATE"}, -- Void Infection
		-- Void Bound Despoiler
		{426771, "HEALER", "NAMEPLATE"}, -- Void Outburst
		{459210, "TANK", "NAMEPLATE"}, -- Shadow Claw
		-- Void Bound Howler
		{445207, "NAMEPLATE"}, -- Piercing Wail
		-- Turned Speaker
		{429545, "NAMEPLATE"}, -- Censoring Gear
		-- Void Touched Elemental
		{426345, "NAMEPLATE"}, -- Crystal Salvo
		-- Forgebound Mender / Cursedforge Mender
		{429109, "NAMEPLATE"}, -- Restoring Metals
		-- Forge Loader
		{449130, "NAMEPLATE"}, -- Lava Cannon
		{449154, "HEALER", "NAMEPLATE"}, -- Molten Mortar
		-- Cursedforge Honor Guard
		{448640, "NAMEPLATE"}, -- Shield Stampede
		{428894, "TANK", "NAMEPLATE", "OFF"}, -- Stonebreaker Strike
		-- Cursedforge Stoneshaper
		{429427, "NAMEPLATE"}, -- Earth Burst Totem
		-- Rock Smasher
		{428879, "NAMEPLATE"}, -- Smash Rock
		{428703, "NAMEPLATE"}, -- Granite Eruption
	}, {
		["custom_on_autotalk"] = CL.general,
		[425027] = L.earth_infused_golem,
		[447141] = L.repurposed_loaderbot,
		[449455] = L.ghastly_voidsoul,
		[426308] = L.cursedheart_invader,
		[426771] = L.void_bound_despoiler,
		[445207] = L.void_bound_howler,
		[429545] = L.turned_speaker,
		[426345] = L.void_touched_elemental,
		[429109] = L.forgebound_mender,
		[449130] = L.forge_loader,
		[448640] = L.cursedforge_honor_guard,
		[429427] = L.cursedforge_stoneshaper,
		[428879] = L.rock_smasher,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "ImbuedIronEnergyApplied", 462500)

	-- Earth Infused Golem
	self:RegisterEngageMob("EarthInfusedGolemEngaged", 210109)
	self:Log("SPELL_CAST_START", "SeismicWave", 425027)
	self:Log("SPELL_CAST_START", "GroundPound", 425974)
	self:Death("EarthInfusedGolemDeath", 210109)

	-- Repurposed Loaderbot
	self:RegisterEngageMob("RepurposedLoaderbotEngaged", 222923)
	self:Log("SPELL_CAST_START", "PulverizingPounce", 447141)
	self:Death("RepurposedLoaderbotDeath", 222923)

	-- Ghastly Voidsoul
	self:RegisterEngageMob("GhastlyVoidsoulEngaged", 212453)
	self:Log("SPELL_CAST_START", "HowlingFear", 449455)
	self:Log("SPELL_INTERRUPT", "HowlingFearInterrupt", 449455)
	self:Log("SPELL_CAST_SUCCESS", "HowlingFearSuccess", 449455)
	self:Death("GhastlyVoidsoulDeath", 212453)

	-- Cursedheart Invader
	self:RegisterEngageMob("CursedheartInvaderEngaged", 212389, 212403)
	self:Log("SPELL_CAST_SUCCESS", "VoidInfection", 426308)
	self:Log("SPELL_AURA_APPLIED", "VoidInfectionApplied", 426308)
	self:Death("CursedheartInvaderDeath", 212389, 212403)

	-- Void Bound Despoiler
	self:RegisterEngageMob("VoidBoundDespoilerEngaged", 212765)
	self:Log("SPELL_CAST_START", "VoidOutburst", 426771)
	self:Log("SPELL_CAST_START", "ShadowClaw", 459210)
	self:Death("VoidBoundDespoilerDeath", 212765)

	-- Void Bound Howler
	self:RegisterEngageMob("VoidBoundHowlerEngaged", 221979)
	self:Log("SPELL_CAST_START", "PiercingWail", 445207)
	self:Log("SPELL_INTERRUPT", "PiercingWailInterrupt", 445207)
	self:Log("SPELL_CAST_SUCCESS", "PiercingWailSuccess", 445207)
	self:Death("VoidBoundHowlerDeath", 221979)

	-- Turned Speaker
	self:RegisterEngageMob("TurnedSpeakerEngaged", 214350)
	self:Log("SPELL_CAST_START", "CensoringGear", 429545)
	self:Log("SPELL_INTERRUPT", "CensoringGearInterrupt", 429545)
	self:Log("SPELL_CAST_SUCCESS", "CensoringGearSuccess", 429545)
	self:Death("TurnedSpeakerDeath", 214350)

	-- Void Touched Elemental
	self:RegisterEngageMob("VoidTouchedElementalEngaged", 212400)
	self:Log("SPELL_CAST_SUCCESS", "CrystalSalvo", 426345)
	self:Death("VoidTouchedElementalDeath", 212400)

	-- Forgebound Mender / Cursedforge Mender
	--self:RegisterEngageMob("MenderEngaged", 213338, 224962) -- Forgebound Mender, Cursedforge Mender
	self:Log("SPELL_CAST_START", "RestoringMetals", 429109)
	self:Log("SPELL_INTERRUPT", "RestoringMetalsInterrupt", 429109)
	self:Log("SPELL_CAST_SUCCESS", "RestoringMetalsSuccess", 429109)
	self:Death("MenderDeath", 213338, 224962) -- Forgebound Mender, Cursedforge Mender

	-- Forge Loader
	self:RegisterEngageMob("ForgeLoaderEngaged", 213343)
	self:Log("SPELL_CAST_START", "LavaCannon", 449130)
	self:Log("SPELL_CAST_SUCCESS", "MoltenMortar", 449154)
	self:Death("ForgeLoaderDeath", 213343)

	-- Cursedforge Honor Guard
	self:RegisterEngageMob("CursedforgeHonorGuardEngaged", 214264)
	self:Log("SPELL_CAST_START", "ShieldStampede", 448640)
	self:Log("SPELL_CAST_START", "StonebreakerStrike", 428894)
	self:Log("SPELL_CAST_SUCCESS", "StonebreakerStrikeSuccess", 428894)
	self:Death("CursedforgeHonorGuardDeath", 214264)

	-- Cursedforge Stoneshaper
	self:RegisterEngageMob("CursedforgeStoneshaperEngaged", 214066)
	self:Log("SPELL_CAST_SUCCESS", "EarthBurstTotem", 429427)
	self:Log("SPELL_SUMMON", "EarthBurstTotemSummon", 429427)
	self:Death("CursedforgeStoneshaperDeath", 214066)

	-- Rock Smasher
	self:RegisterEngageMob("RockSmasherEngaged", 213954)
	self:Log("SPELL_CAST_START", "SmashRock", 428879)
	self:Log("SPELL_CAST_START", "GraniteEruption", 428703)
	self:Death("RockSmasherDeath", 213954)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_SAY(_, msg)
	if msg == L.edna_warmup_trigger then
		-- E.D.N.A. warmup
		local ednaModule = BigWigs:GetBossModule("E.D.N.A.", true)
		if ednaModule then
			ednaModule:Enable()
			ednaModule:Warmup()
		end
	end
end

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		if self:GetGossipID(124023) then -- Dwarf (Dark Iron Dwarf, Dwarf, Earthen)
			-- 124023:<The Earthen Bar resonates with you, allowing you to absorb its power.>\r\n|cFFFF0000[Requires Warrior, Dwarf, or at least 25 skill in Khaz Algar Blacksmithing.]
			self:SelectGossipID(124023)
		elseif self:GetGossipID(124024) then -- Blacksmithing
			-- 124024:<Malleate the imbued iron bar down, and release the energy contained within. >\r\n|cFFFF0000[Requires Warrior, Dwarf, or at least 25 skill in Khaz Algar Blacksmithing.]
			self:SelectGossipID(124024)
		elseif self:GetGossipID(124025) then -- Warrior
			-- 124025:<Smash the imbued iron bar and let loose the energies contained within.>\r\n|cFFFF0000[Requires Warrior, Dwarf, or at least 25 skill in Khaz Algar Blacksmithing.]
			self:SelectGossipID(124025)
		end
	end
end

function mod:ImbuedIronEnergyApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Earth Infused Golem

function mod:EarthInfusedGolemEngaged(guid)
	self:Nameplate(425027, 5.5, guid, 1016245) -- Seismic Wave, fileId for L["425027_icon"]
	self:Nameplate(425974, 13.4, guid) -- Ground Pound
end

function mod:SeismicWave(args)
	self:Message(args.spellId, "purple", nil, L["425027_icon"])
	self:Nameplate(args.spellId, 18.2, args.sourceGUID, 1016245) -- fileId for L["425027_icon"]
	self:PlaySound(args.spellId, "alarm")
end

function mod:GroundPound(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 21.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:EarthInfusedGolemDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Repurposed Loaderbot

function mod:RepurposedLoaderbotEngaged(guid)
	self:Nameplate(447141, 4.2, guid) -- Pulverizing Pounce
end

do
	local prev = 0
	function mod:PulverizingPounce(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

function mod:RepurposedLoaderbotDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ghastly Voidsoul

function mod:GhastlyVoidsoulEngaged(guid)
	self:Nameplate(449455, 6.8, guid) -- Howling Fear
end

function mod:HowlingFear(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "warning")
end

function mod:HowlingFearInterrupt(args)
	self:Nameplate(449455, 22.9, args.destGUID)
end

function mod:HowlingFearSuccess(args)
	self:Nameplate(args.spellId, 22.9, args.sourceGUID)
end

function mod:GhastlyVoidsoulDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cursedheart Invader

function mod:CursedheartInvaderEngaged(guid)
	self:Nameplate(426308, 5.2, guid) -- Void Infection
end

function mod:VoidInfection(args)
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

do
	local prev = 0
	function mod:VoidInfectionApplied(args)
		local t = args.time
		if self:Dispeller("curse", nil, args.spellId) and t - prev > 2 then
			prev = t
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:CursedheartInvaderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Void Bound Despoiler

function mod:VoidBoundDespoilerEngaged(guid)
	self:Nameplate(459210, 5.4, guid) -- Shadow Claw
	self:Nameplate(426771, 6.6, guid) -- Void Outburst
end

function mod:VoidOutburst(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 27.9, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:ShadowClaw(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 13.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidBoundDespoilerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Void Bound Howler

function mod:VoidBoundHowlerEngaged(guid)
	self:Nameplate(445207, 4.7, guid) -- Piercing Wail
end

do
	local prev = 0
	function mod:PiercingWail(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:PiercingWailInterrupt(args)
	self:Nameplate(445207, 20.0, args.destGUID)
end

function mod:PiercingWailSuccess(args)
	self:Nameplate(args.spellId, 20.0, args.sourceGUID)
end

function mod:VoidBoundHowlerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Turned Speaker

function mod:TurnedSpeakerEngaged(guid)
	self:Nameplate(429545, 1.1, guid) -- Censoring Gear
end

function mod:CensoringGear(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:CensoringGearInterrupt(args)
	self:Nameplate(429545, 18.0, args.destGUID)
end

function mod:CensoringGearSuccess(args)
	self:Nameplate(args.spellId, 18.0, args.sourceGUID)
end

function mod:TurnedSpeakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Void Touched Elemental

function mod:VoidTouchedElementalEngaged(guid)
	self:Nameplate(426345, 5.4, guid) -- Crystal Salvo
end

function mod:CrystalSalvo(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:VoidTouchedElementalDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Forgebound Mender / Cursedforge Mender

--function mod:MenderEngaged(guid)
	-- seems to be health based for the first cast, so an initial timer is not very useful
	--self:Nameplate(429109, 7.5, guid) -- Restoring Metals
--end

do
	local prev = 0
	function mod:RestoringMetals(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:RestoringMetalsInterrupt(args)
	self:Nameplate(429109, 16.4, args.destGUID)
end

function mod:RestoringMetalsSuccess(args)
	self:Nameplate(args.spellId, 16.4, args.sourceGUID)
end

function mod:MenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Forge Loader

function mod:ForgeLoaderEngaged(guid)
	self:Nameplate(449130, 8.4, guid) -- Lava Cannon
	self:Nameplate(449154, 14.5, guid) -- Molten Mortar
end

do
	local prev = 0
	function mod:LavaCannon(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:MoltenMortar(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 24.2, args.sourceGUID)
	end
end

function mod:ForgeLoaderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cursedforge Honor Guard

function mod:CursedforgeHonorGuardEngaged(guid)
	self:Nameplate(448640, 6.8, guid) -- Shield Stampede
	self:Nameplate(428894, 14.4, guid) -- Stonebreaker Strike
end

do
	local prev = 0
	function mod:ShieldStampede(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:StonebreakerStrike(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:StonebreakerStrikeSuccess(args)
	self:Nameplate(args.spellId, 15.2, args.sourceGUID)
end

function mod:CursedforgeHonorGuardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cursedforge Stoneshaper

function mod:CursedforgeStoneshaperEngaged(guid)
	self:Nameplate(429427, 4.6, guid) -- Earth Burst Totem
end

function mod:EarthBurstTotem(args)
	self:Nameplate(args.spellId, 31.6, args.sourceGUID)
end

do
	local prev = 0
	function mod:EarthBurstTotemSummon(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "cyan", CL.spawned:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:CursedforgeStoneshaperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Rock Smasher

function mod:RockSmasherEngaged(guid)
	self:Nameplate(428879, 8.1, guid) -- Smash Rock
	self:Nameplate(428703, 14.5, guid) -- Granite Eruption
end

do
	local prev = 0
	function mod:SmashRock(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 28.4, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:GraniteEruption(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 28.0, args.sourceGUID)
	end
end

function mod:RockSmasherDeath(args)
	self:ClearNameplate(args.destGUID)
end
