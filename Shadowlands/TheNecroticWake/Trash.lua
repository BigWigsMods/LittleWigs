--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Necrotic Wake Trash", 2286)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	166302, -- Corpse Harvester
	163121, -- Stitched Vanguard
	165137, -- Zolramus Gatekeeper
	163618, -- Zolramus Necromancer
	163126, -- Brittlebone Mage
	163619, -- Zolramus Bonecarver
	165919, -- Skeletal Marauder
	165222, -- Zolramus Bonemender
	163128, -- Zolramus Sorcerer
	165824, -- Nar'zudah
	165197, -- Skeletal Monstrosity
	173016, -- Corpse Collector
	172981, -- Kyrian Stitchwerk
	165872, -- Flesh Crafter
	165911, -- Loyal Creation
	173044, -- Stitching Assistant
	167731, -- Separation Assistant
	163621, -- Goregrind
	163620 -- Rotspew
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.amarth_warmup_trigger = "You will be brought to justice!"
	L.corpse_harvester = "Corpse Harvester"
	L.stitched_vanguard = "Stitched Vanguard"
	L.zolramus_gatekeeper = "Zolramus Gatekeeper"
	L.zolramus_necromancer = "Zolramus Necromancer"
	L.brittlebone_mage = "Brittlebone Mage"
	L.zolramus_bonecarver = "Zolramus Bonecarver"
	L.skeletal_marauder = "Skeletal Marauder"
	L.zolramus_bonemender = "Zolramus Bonemender"
	L.zolramus_sorcerer = "Zolramus Sorcerer"
	L.narzudah = "Nar'zudah"
	L.skeletal_monstrosity = "Skeletal Monstrosity"
	L.corpse_collector = "Corpse Collector"
	L.kyrian_stitchwerk = "Kyrian Stitchwerk"
	L.flesh_crafter = "Flesh Crafter"
	L.loyal_creation = "Loyal Creation"
	L.separation_assistant = "Separation Assistant"
	L.goregrind = "Goregrind"
	L.rotspew = "Rotspew"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Corpse Harvester
		{334748, "NAMEPLATE"}, -- Drain Fluids
		-- Stitched Vanguard
		{320696, "NAMEPLATE", "OFF"}, -- Bone Claw
		-- Zolramus Gatekeeper
		{323347, "NAMEPLATE"}, -- Clinging Darkness
		{322756, "NAMEPLATE"}, -- Wrath of Zolramus
		-- Zolramus Necromancer
		{321780, "NAMEPLATE"}, -- Animate Dead
		{327396, "SAY", "SAY_COUNTDOWN", "NAMEPLATE"}, -- Grim Fate
		-- Brittlebone Mage
		{328667, "NAMEPLATE"}, -- Frostbolt Volley
		-- Zolramus Bonecarver
		{321807, "TANK", "NAMEPLATE"}, -- Boneflay
		-- Skeletal Marauder
		{324293, "NAMEPLATE"}, -- Rasping Scream
		{343470, "NAMEPLATE"}, -- Boneshatter Shield
		{324323, "NAMEPLATE", "OFF"}, -- Gruesome Cleave
		-- Zolramus Bonemender
		{335143, "NAMEPLATE"}, -- Bonemend
		320822, -- Final Bargain
		-- Zolramus Sorcerer
		{320464, "NAMEPLATE"}, -- Shadow Well
		-- Nar'zudah
		{335141, "NAMEPLATE"}, -- Dark Shroud
		{345623, "NAMEPLATE"}, -- Death Burst
		-- Skeletal Monstrosity
		{324394, "TANK", "NAMEPLATE"}, -- Shatter
		{324387, "NAMEPLATE"}, -- Frigid Spikes
		{324372, "NAMEPLATE"}, -- Reaping Winds
		-- Corpse Collector
		{338353, "NAMEPLATE"}, -- Goresplatter
		-- Kyrian Stitchwerk
		{338456, "TANK_HEALER", "NAMEPLATE"}, -- Mutilate
		{338357, "NAMEPLATE"}, -- Tenderize
		-- Flesh Crafter
		{327130, "NAMEPLATE"}, -- Repair Flesh
		{323471, "SAY", "NAMEPLATE"}, -- Throw Cleaver
		-- Loyal Creation
		{327240, "NAMEPLATE"}, -- Spine Crush
		-- Separation Assistant
		{338606, "ME_ONLY_EMPHASIZE", "NAMEPLATE"}, -- Morbid Fixation
		-- Goregrind
		{333477, "NAMEPLATE"}, -- Gut Slice
		-- Rotspew
		{333479, "SAY", "NAMEPLATE"}, -- Spew Disease
	}, {
		[334748] = L.corpse_harvester,
		[320696] = L.stitched_vanguard,
		[323347] = L.zolramus_gatekeeper,
		[321780] = L.zolramus_necromancer,
		[328667] = L.brittlebone_mage,
		[324293] = L.skeletal_marauder,
		[335143] = L.zolramus_bonemender,
		[320464] = L.zolramus_sorcerer,
		[335141] = L.narzudah,
		[324394] = L.skeletal_monstrosity,
		[338353] = L.corpse_collector,
		[338456] = L.kyrian_stitchwerk,
		[327130] = L.flesh_crafter,
		[327240] = L.loyal_creation,
		[338606] = L.separation_assistant,
		[333477] = L.goregrind,
		[333479] = L.rotspew,
	}
end

function mod:OnBossEnable()
	-- Warmup
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	-- Corpse Harvester
	self:RegisterEngageMob("CorpseHarvesterEngaged", 166302)
	self:Log("SPELL_CAST_START", "DrainFluids", 334748)
	self:Log("SPELL_INTERRUPT", "DrainFluidsInterrupt", 334748)
	self:Log("SPELL_CAST_SUCCESS", "DrainFluidsSuccess", 334748)
	self:Death("CorpseHarvesterDeath", 166302)

	-- Stitched Vanguard
	self:RegisterEngageMob("StitchedVanguardEngaged", 163121)
	self:Log("SPELL_CAST_START", "BoneClaw", 320696)
	self:Death("StitchedVanguardDeath", 163121)

	-- Zolramus Gatekeeper
	self:RegisterEngageMob("ZolramusGatekeeperEngaged", 165137)
	self:Log("SPELL_CAST_SUCCESS", "ClingingDarkness", 323347) -- Mythic only
	self:Log("SPELL_AURA_APPLIED", "ClingingDarknessApplied", 323347) -- Mythic only
	self:Log("SPELL_CAST_START", "WrathOfZolramus", 322756)
	self:Death("ZolramusGatekeeperDeath", 165137)

	-- Zolramus Necromancer
	self:RegisterEngageMob("ZolramusNecromancerEngaged", 163618)
	self:Log("SPELL_CAST_SUCCESS", "AnimateDead", 321780)
	self:Log("SPELL_CAST_SUCCESS", "GrimFate", 327393)
	self:Log("SPELL_AURA_APPLIED", "GrimFateApplied", 327396)
	self:Log("SPELL_AURA_REMOVED", "GrimFateRemoved", 327396)
	self:Death("ZolramusNecromancerDeath", 163618)

	-- Brittlebone Mage
	self:RegisterEngageMob("BrittleboneMageEngaged", 163126)
	self:Log("SPELL_CAST_START", "FrostboltVolley", 328667)
	self:Log("SPELL_INTERRUPT", "FrostboltVolleyInterrupt", 328667)
	self:Log("SPELL_CAST_SUCCESS", "FrostboltVolleySuccess", 328667)
	self:Death("BrittleboneMageDeath", 163126)

	-- Zolramus Bonecarver
	self:RegisterEngageMob("ZolramusBonecarverEngaged", 163619)
	self:Log("SPELL_CAST_START", "Boneflay", 321807)
	self:Log("SPELL_CAST_SUCCESS", "BoneflaySuccess", 321807)
	self:Death("ZolramusBonecarverDeath", 163619)

	-- Skeletal Marauder
	self:RegisterEngageMob("SkeletalMarauderEngaged", 165919)
	self:Log("SPELL_CAST_START", "RaspingScream", 324293)
	self:Log("SPELL_INTERRUPT", "RaspingScreamInterrupt", 324293)
	self:Log("SPELL_CAST_SUCCESS", "RaspingScreamSuccess", 324293)
	self:Log("SPELL_CAST_SUCCESS", "BoneshatterShield", 343470)
	self:Log("SPELL_CAST_START", "GruesomeCleave", 324323)
	self:Death("SkeletalMarauderDeath", 165919)

	-- Zolramus Bonemender
	self:RegisterEngageMob("ZolramusBonemenderEngaged", 165222)
	self:Log("SPELL_CAST_START", "Bonemend", 335143)
	self:Log("SPELL_INTERRUPT", "BonemendInterrupt", 335143)
	self:Log("SPELL_CAST_SUCCESS", "BonemendSuccess", 335143)
	self:Log("SPELL_CAST_START", "FinalBargain", 320822)
	self:Death("ZolramusBonemenderDeath", 165222)

	-- Zolramus Sorcerer
	self:RegisterEngageMob("ZolramusSorcererEngaged", 163128)
	self:Log("SPELL_CAST_START", "ShadowWell", 320464)
	self:Log("SPELL_CAST_SUCCESS", "ShadowWellSuccess", 320464)
	self:Death("ZolramusSorcererDeath", 163128)

	-- Nar'zudah
	self:RegisterEngageMob("NarzudahEngaged", 165824)
	self:Log("SPELL_CAST_START", "DarkShroud", 335141)
	self:Log("SPELL_AURA_REMOVED", "DarkShroudRemoved", 335141)
	self:Log("SPELL_CAST_SUCCESS", "DeathBurst", 345623)
	self:Death("NarzudahDeath", 165824)

	-- Skeletal Monstrosity
	self:RegisterEngageMob("SkeletalMonstrosityEngaged", 165197)
	self:Log("SPELL_CAST_START", "Shatter", 324394)
	self:Log("SPELL_CAST_START", "FrigidSpikes", 324387)
	self:Log("SPELL_CAST_SUCCESS", "ReapingWinds", 324372)
	self:Death("SkeletalMonstrosityDeath", 165197)

	-- Corpse Collector
	self:RegisterEngageMob("CorpseCollectorEngaged", 173016)
	self:Log("SPELL_CAST_START", "Goresplatter", 338353)
	self:Log("SPELL_INTERRUPT", "GoresplatterInterrupt", 338353)
	self:Log("SPELL_CAST_SUCCESS", "GoresplatterSuccess", 338353)
	self:Death("CorpseCollectorDeath", 173016)

	-- Kyrian Stitchwerk
	self:RegisterEngageMob("KyrianStitchwerkEngaged", 172981)
	self:Log("SPELL_CAST_START", "Mutilate", 338456)
	self:Log("SPELL_CAST_START", "Tenderize", 338357)
	self:Death("KyrianStitchwerkDeath", 172981)

	-- Flesh Crafter
	self:RegisterEngageMob("FleshCrafterEngaged", 165872)
	self:Log("SPELL_CAST_SUCCESS", "RepairFlesh", 327130) -- SUCCESS on 327130 is when the interruptible channel begins
	self:Log("SPELL_CAST_SUCCESS", "ThrowCleaver", 323496)
	self:Log("SPELL_AURA_APPLIED", "ThrowCleaverApplied", 323471)
	self:Death("FleshCrafterDeath", 165872)

	-- Loyal Creation
	self:RegisterEngageMob("LoyalCreationEngaged", 165911)
	self:Log("SPELL_CAST_START", "SpineCrush", 327240)
	self:Log("SPELL_CAST_SUCCESS", "SpineCrushSuccess", 327240)
	self:Death("LoyalCreationDeath", 165911)

	-- Stitching Assistant
	self:RegisterEngageMob("StitchingAssistantEngaged", 173044)
	self:Death("StitchingAssistantDeath", 173044)

	-- Separation Assistant
	self:RegisterEngageMob("SeparationAssistantEngaged", 167731)
	self:Log("SPELL_CAST_START", "MorbidFixation", 338606)
	self:Log("SPELL_AURA_APPLIED", "MorbidFixationApplied", 338606)
	self:Log("SPELL_AURA_REMOVED", "MorbidFixationRemoved", 338606)
	self:Death("SeparationAssistantDeath", 167731)

	-- Goregrind
	self:RegisterEngageMob("GoregrindEngaged", 163621)
	self:Log("SPELL_CAST_START", "GutSlice", 333477)
	self:Death("GoregrindDeath", 163621)

	-- Rotspew
	self:RegisterEngageMob("RotspewEngaged", 163620)
	self:Log("SPELL_CAST_START", "SpewDisease", 333479)
	self:Death("RotspewDeath", 163620)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg == L.amarth_warmup_trigger then
		self:UnregisterEvent(event)
		-- Amarth Warmup
		local amarthModule = BigWigs:GetBossModule("Amarth, The Reanimator", true)
		if amarthModule then
			amarthModule:Enable()
			amarthModule:Warmup()
		end
	end
end

-- Corpse Harvester

function mod:CorpseHarvesterEngaged(guid)
	self:Nameplate(334748, 5.6, guid) -- Drain Fluids
end

do
	local prev = 0
	function mod:DrainFluids(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:DrainFluidsInterrupt(args)
	self:Nameplate(334748, 15.0, args.destGUID)
end

function mod:DrainFluidsSuccess(args)
	self:Nameplate(args.spellId, 15.0, args.sourceGUID)
end

function mod:CorpseHarvesterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Stitched Vanguard

function mod:StitchedVanguardEngaged(guid)
	self:Nameplate(320696, 5.6, guid) -- Bone Claw
end

do
	local prev = 0
	function mod:BoneClaw(args)
		if self:MobId(args.sourceGUID) == 163121 then -- Stitched Vanguard
			self:Nameplate(args.spellId, 9.7, args.sourceGUID)
		else -- 165911, Loyal Creation
			self:Nameplate(args.spellId, 10.9, args.sourceGUID)
		end
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:StitchedVanguardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Zolramus Gatekeeper

function mod:ZolramusGatekeeperEngaged(guid)
	self:Nameplate(322756, 5.9, guid) -- Wrath of Zolramus
	if self:Mythic() then
		self:Nameplate(323347, 6.4, guid) -- Clinging Darkness
	end
end

function mod:ClingingDarkness(args)
	self:Nameplate(args.spellId, 65.5, args.sourceGUID)
end

function mod:ClingingDarknessApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:WrathOfZolramus(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ZolramusGatekeeperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Zolramus Necromancer

function mod:ZolramusNecromancerEngaged(guid)
	self:Nameplate(327396, 10.5, guid) -- Grim Fate
	self:Nameplate(321780, 16.6, guid) -- Animate Dead
end

function mod:AnimateDead(args)
	-- these NPCs can be mind-controlled by Priests but cannot cast Animate Dead while MC'd
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 29.2, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:GrimFate(args)
	if self:MobId(args.sourceGUID) == 165824 then -- Nar'zudah
		self:NarzudahGrimFate(args)
	else
		self:Nameplate(327396, 18.1, args.sourceGUID)
	end
end

function mod:GrimFateApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Grim Fate")
		self:SayCountdown(args.spellId, 4)
	end
end

function mod:GrimFateRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:ZolramusNecromancerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Brittlebone Mage

function mod:BrittleboneMageEngaged(guid)
	self:Nameplate(328667, 7.0, guid) -- Frostbolt Volley
end

function mod:FrostboltVolley(args)
	if self:MobId(args.sourceGUID) == 163126 then -- Brittlebone Mage, Amarth has adds that cast this spell
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:FrostboltVolleyInterrupt(args)
	if self:MobId(args.destGUID) == 163126 then -- Brittlebone Mage, Amarth has adds that cast this spell
		self:Nameplate(328667, 16.1, args.destGUID)
	end
end

function mod:FrostboltVolleySuccess(args)
	if self:MobId(args.sourceGUID) == 163126 then -- Brittlebone Mage, Amarth has adds that cast this spell
		self:Nameplate(args.spellId, 16.1, args.sourceGUID)
	end
end

function mod:BrittleboneMageDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Zolramus Bonecarver

function mod:ZolramusBonecarverEngaged(guid)
	self:Nameplate(321807, 6.7, guid) -- Boneflay
end

do
	local prev = 0
	function mod:Boneflay(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:BoneflaySuccess(args)
	self:Nameplate(args.spellId, 15.0, args.sourceGUID)
end

function mod:ZolramusBonecarverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Skeletal Marauder

function mod:SkeletalMarauderEngaged(guid)
	self:Nameplate(324323, 2.4, guid) -- Gruesome Cleave
	if not self:Normal() then
		self:Nameplate(343470, 11.3, guid) -- Boneshatter Shield
	end
	self:Nameplate(324293, 13.3, guid) -- Rasping Scream
end

function mod:RaspingScream(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:RaspingScreamInterrupt(args)
	self:Nameplate(324293, 16.2, args.destGUID)
end

function mod:RaspingScreamSuccess(args)
	self:Nameplate(args.spellId, 16.2, args.sourceGUID)
end

function mod:BoneshatterShield(args)
	self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.sourceName))
	self:Nameplate(args.spellId, 20.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:GruesomeCleave(args)
		self:Nameplate(args.spellId, 11.2, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:SkeletalMarauderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Zolramus Bonemender

function mod:ZolramusBonemenderEngaged(guid)
	self:Nameplate(335143, 1.2, guid) -- Bonemend
end

function mod:Bonemend(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:BonemendInterrupt(args)
	self:Nameplate(335143, 7.0, args.destGUID)
end

function mod:BonemendSuccess(args)
	self:Nameplate(args.spellId, 7.0, args.sourceGUID)
end

function mod:FinalBargain(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:ZolramusBonemenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Zolramus Sorcerer

function mod:ZolramusSorcererEngaged(guid)
	self:Nameplate(320464, 6.5, guid) -- Shadow Well
end

do
	local prev = 0
	function mod:ShadowWell(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:ShadowWellSuccess(args)
	self:Nameplate(args.spellId, 12.1, args.sourceGUID)
end

function mod:ZolramusSorcererDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nar'zudah

do
	local timer

	function mod:NarzudahEngaged(guid)
		self:CDBar(345623, 6.0) -- Death Burst
		self:Nameplate(345623, 6.0, guid) -- Death Burst
		self:CDBar(335141, 7.0) -- Dark Shroud
		self:Nameplate(335141, 7.0, guid) -- Dark Shroud
		self:CDBar(327396, 11.4) -- Grim Fate
		self:Nameplate(327396, 11.4, guid) -- Grim Fate
		timer = self:ScheduleTimer("NarzudahDeath", 30)
	end

	function mod:DarkShroud(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 22.3)
		self:Nameplate(args.spellId, 22.3, args.sourceGUID)
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "warning")
		else
			self:PlaySound(args.spellId, "alert")
		end
		timer = self:ScheduleTimer("NarzudahDeath", 30)
	end

	function mod:DarkShroudRemoved(args)
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end

	function mod:NarzudahGrimFate(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(327396, 20.7)
		self:Nameplate(327396, 20.7, args.sourceGUID)
		timer = self:ScheduleTimer("NarzudahDeath", 30)
	end

	function mod:DeathBurst(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 17.0)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("NarzudahDeath", 30)
	end

	function mod:NarzudahDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(335141) -- Dark Shroud
		self:StopBar(327396) -- Grim Fate
		self:StopBar(345623) -- Death Burst
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Skeletal Monstrosity

do
	local timer

	function mod:SkeletalMonstrosityEngaged(guid)
		self:CDBar(324394, 4.6) -- Shatter
		self:Nameplate(324394, 4.6, guid) -- Shatter
		self:CDBar(324372, 9.5) -- Reaping Winds
		self:Nameplate(324372, 9.5, guid) -- Reaping Winds
		self:CDBar(324387, 15.6) -- Rigid Spikes
		self:Nameplate(324387, 15.6, guid) -- Rigid Spikes
		timer = self:ScheduleTimer("SkeletalMonstrosityDeath", 30)
	end

	function mod:Shatter(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 17.0)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("SkeletalMonstrosityDeath", 30)
	end

	function mod:FrigidSpikes(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("SkeletalMonstrosityDeath", 30)
	end

	function mod:ReapingWinds(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 20.2)
		self:Nameplate(args.spellId, 20.2, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("SkeletalMonstrosityDeath", 30)
	end

	function mod:SkeletalMonstrosityDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(324394) -- Shatter
		self:StopBar(324387) -- Rigid Spikes
		self:StopBar(324372) -- Reaping Winds
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Corpse Collector

function mod:CorpseCollectorEngaged(guid)
	self:Nameplate(338353, 5.5, guid) -- Goresplatter
	self:Nameplate(334748, 6.6, guid) -- Drain Fluids
end

function mod:Goresplatter(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:GoresplatterInterrupt(args)
	self:Nameplate(338353, 21.0, args.destGUID)
end

function mod:GoresplatterSuccess(args)
	self:Nameplate(args.spellId, 21.0, args.sourceGUID)
end

function mod:CorpseCollectorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Kyrian Stitchwerk

function mod:KyrianStitchwerkEngaged(guid)
	self:Nameplate(338357, 5.4, guid) -- Tenderize
	self:Nameplate(338456, 9.0, guid) -- Mutilate
end

function mod:Mutilate(args)
	local mobId = self:MobId(args.sourceGUID)
	if mobId ~= 164578 then -- Stitchflesh's Creation, add on Surgeon Stitchflesh
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		if mobId == 163620 then -- Rotspew
			self:RotspewMutilate(args)
		elseif mobId == 163621 then -- Goregrind
			self:GoregrindMutilate(args)
		else
			self:Nameplate(args.spellId, 14.6, args.sourceGUID)
		end
	end
end

function mod:Tenderize(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "info")
	if self:MobId(args.sourceGUID) == 163621 then -- Goregrind
		self:GoregrindTenderize(args)
	else
		self:Nameplate(args.spellId, 14.6, args.sourceGUID)
	end
end

function mod:KyrianStitchwerkDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Flesh Crafter

function mod:FleshCrafterEngaged(guid)
	self:Nameplate(323471, 1.2, guid) -- Throw Cleaver
	self:Nameplate(327130, 9.9, guid) -- Repair Flesh
end

function mod:RepairFlesh(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 16.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:ThrowCleaver(args)
	self:Nameplate(323471, 13.0, args.sourceGUID)
end

do
	local prevOnMe = 0
	function mod:ThrowCleaverApplied(args)
		self:TargetMessage(args.spellId, "yellow", args.destName)
		local t = args.time
		if self:Me(args.destGUID) and t - prevOnMe > 2 then
			prevOnMe = t
			self:Say(args.spellId, nil, nil, "Throw Cleaver")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:FleshCrafterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Loyal Creation

function mod:LoyalCreationEngaged(guid)
	self:Nameplate(320696, 4.2, guid) -- Bone Claw
	self:Nameplate(327240, 8.6, guid) -- Spine Crush
end

function mod:SpineCrush(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SpineCrushSuccess(args)
	self:Nameplate(args.spellId, 14.0, args.sourceGUID)
end

function mod:LoyalCreationDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Stitching Assistant

function mod:StitchingAssistantEngaged(guid)
	self:Nameplate(323471, 1.0, guid) -- Throw Cleaver
	self:Nameplate(334748, 8.3, guid) -- Drain Fluids
end

function mod:StitchingAssistantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Separation Assistant

function mod:SeparationAssistantEngaged(guid)
	self:Nameplate(323471, 1.0, guid) -- Throw Cleaver
	self:Nameplate(338606, 11.9, guid) -- Morbid Fixation
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(338606, "yellow", name)
		if self:Me(guid) then
			self:PlaySound(338606, "warning", nil, name)
		else
			self:PlaySound(338606, "info", nil, name)
		end
	end

	function mod:MorbidFixation(args)
		-- alert earlier using target scanning instead of watching the debuff
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Nameplate(args.spellId, 26.7, args.sourceGUID)
	end
end

function mod:MorbidFixationApplied(args)
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:MorbidFixationRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:SeparationAssistantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Goregrind

do
	local timer

	function mod:GoregrindEngaged(guid)
		self:CDBar(338357, 4.3) -- Tenderize
		self:Nameplate(338357, 4.3, guid) -- Tenderize
		self:CDBar(338456, 7.9) -- Mutilate
		self:Nameplate(338456, 7.9, guid) -- Mutilate
		self:CDBar(333477, 10.3) -- Gut Slice
		self:Nameplate(333477, 10.3, guid) -- Gut Slice
		timer = self:ScheduleTimer("GoregrindDeath", 30)
	end

	function mod:GutSlice(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 14.5)
		self:Nameplate(args.spellId, 14.5, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("GoregrindDeath", 30)
	end

	function mod:GoregrindTenderize(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(338357, 12.1)
		self:Nameplate(338357, 12.1, args.sourceGUID)
		timer = self:ScheduleTimer("GoregrindDeath", 30)
	end

	function mod:GoregrindMutilate(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(338456, 12.1)
		self:Nameplate(338456, 12.1, args.sourceGUID)
		timer = self:ScheduleTimer("GoregrindDeath", 30)
	end

	function mod:GoregrindDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(333477) -- Gut Slice
		self:StopBar(338357) -- Tenderize
		self:StopBar(338456) -- Mutilate
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Rotspew

do
	local timer

	function mod:RotspewEngaged(guid)
		self:CDBar(338456, 4.6) -- Mutilate
		self:Nameplate(338456, 4.6, guid) -- Mutilate
		self:CDBar(333479, 8.2) -- Spew Disease
		self:Nameplate(333479, 8.2, guid) -- Spew Disease
		timer = self:ScheduleTimer("RotspewDeath", 30)
	end

	do
		local function printTarget(self, name, guid)
			self:TargetMessage(333479, "yellow", name)
			self:PlaySound(333479, "alert", nil, name)
			if self:Me(guid) then
				self:Say(333479, nil, nil, "Spew Disease")
			end
		end

		function mod:SpewDisease(args)
			if timer then
				self:CancelTimer(timer)
			end
			self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
			self:CDBar(args.spellId, 11.7)
			self:Nameplate(args.spellId, 11.7, args.sourceGUID)
			timer = self:ScheduleTimer("RotspewDeath", 30)
		end
	end

	function mod:RotspewMutilate(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(338456, 11.8)
		self:Nameplate(338456, 11.8, args.sourceGUID)
		timer = self:ScheduleTimer("RotspewDeath", 30)
	end

	function mod:RotspewDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(333479) -- Spew Disease
		self:StopBar(338456) -- Mutilate
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end
