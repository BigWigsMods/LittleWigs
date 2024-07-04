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
	165919, -- Skeletal Marauder
	165222, -- Zolramus Bonemender
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
	L.skeletal_marauder = "Skeletal Marauder"
	L.zolramus_bonemender = "Zolramus Bonemender"
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
		334748, -- Drain Fluids
		-- Stitched Vanguard
		323190, -- Meat Shield
		-- Zolramus Gatekeeper
		323347, -- Clinging Darkness
		{322756, "NAMEPLATEBAR"}, -- Wrath of Zolramus
		-- Zolramus Necromancer
		321780, -- Animate Dead
		-- Brittlebone Mage
		328667, -- Frostbolt Volley
		-- Skeletal Marauder
		324293, -- Rasping Scream
		343470, -- Boneshatter Shield
		-- Zolramus Bonemender
		335143, -- Bonemend
		320822, -- Final Bargain
		-- Nar'zudah
		335141, -- Dark Shroud
		{327396, "SAY", "SAY_COUNTDOWN"}, -- Grim Fate
		-- Skeletal Monstrosity
		{324394, "TANK"}, -- Shatter
		324387, -- Frigid Spikes
		324372, -- Reaping Winds
		-- Corpse Collector
		338353, -- Goresplatter
		-- Kyrian Stitchwerk
		{338456, "TANK_HEALER"}, -- Mutilate
		{338357, "NAMEPLATEBAR"}, -- Tenderize
		-- Flesh Crafter
		327130, -- Repair Flesh
		{323471, "SAY"}, -- Throw Cleaver
		-- Loyal Creation
		327240, -- Spine Crush
		-- Separation Assistant
		338606, -- Morbid Fixation
		-- Goregrind
		333477, -- Gut Slice
		-- Rotspew
		{333479, "SAY"}, -- Spew Disease
	}, {
		[334748] = L.corpse_harvester,
		[323190] = L.stitched_vanguard,
		[323347] = L.zolramus_gatekeeper,
		[321780] = L.zolramus_necromancer,
		[328667] = L.brittlebone_mage,
		[324293] = L.skeletal_marauder,
		[335143] = L.zolramus_bonemender,
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
	self:Log("SPELL_CAST_START", "DrainFluids", 334748)

	-- Stitched Vanguard
	self:Log("SPELL_CAST_START", "MeatShield", 323190)

	-- Zolramus Gatekeeper
	self:Log("SPELL_AURA_APPLIED", "ClingingDarkness", 323347)
	self:Log("SPELL_CAST_START", "WrathOfZolramus", 322756)

	-- Zolramus Necromancer
	self:Log("SPELL_AURA_APPLIED", "AnimateDead", 321780)

	-- Brittlebone Mage
	self:Log("SPELL_CAST_START", "FrostboltVolley", 328667)

	-- Skeletal Marauder
	self:Log("SPELL_CAST_START", "RaspingScream", 324293)
	self:Log("SPELL_AURA_APPLIED", "BoneshatterShieldApplied", 343470)

	-- Zolramus Bonemender
	self:Log("SPELL_CAST_START", "Bonemend", 335143)
	self:Log("SPELL_CAST_START", "FinalBargain", 320822)

	-- Nar'zudah
	self:Log("SPELL_CAST_START", "DarkShroud", 335141)
	self:Log("SPELL_AURA_REMOVED", "DarkShroudRemoved", 335141)
	self:Log("SPELL_CAST_SUCCESS", "GrimFate", 327393)
	self:Log("SPELL_AURA_APPLIED", "GrimFateApplied", 327396)
	self:Log("SPELL_AURA_REMOVED", "GrimFateRemoved", 327396)
	self:Death("NarzudahDeath", 165824)

	-- Skeletal Monstrosity
	self:Log("SPELL_CAST_START", "Shatter", 324394)
	self:Log("SPELL_CAST_START", "FrigidSpikes", 324387)
	self:Log("SPELL_CAST_SUCCESS", "ReapingWinds", 324372)
	self:Death("SkeletalMonstrosityDeath", 165197)

	-- Corpse Collector
	self:Log("SPELL_CAST_START", "Goresplatter", 338353)

	-- Kyrian Stitchwerk
	self:Log("SPELL_CAST_START", "Mutilate", 338456)
	self:Log("SPELL_CAST_START", "Tenderize", 338357)

	-- Flesh Crafter
	self:Log("SPELL_CAST_SUCCESS", "RepairFlesh", 327130) -- SUCCESS on 327130 is when the interruptible channel begins
	self:Log("SPELL_AURA_APPLIED", "ThrowCleaver", 323471)

	-- Loyal Creation
	self:Log("SPELL_CAST_START", "SpineCrush", 327240)

	-- Separation Assistant
	self:Log("SPELL_CAST_START", "MorbidFixation", 338606)
	self:Log("SPELL_AURA_APPLIED", "MorbidFixationApplied", 338606)
	self:Log("SPELL_AURA_REMOVED", "MorbidFixationRemoved", 338606)

	-- Goregrind
	self:Log("SPELL_CAST_START", "GutSlice", 333477)

	-- Rotspew
	self:Log("SPELL_CAST_START", "SpewDisease", 333479)
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

do
	local prev = 0
	function mod:DrainFluids(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t-prev > 0.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Stitched Vanguard

do
	local prev = 0
	function mod:MeatShield(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		local t = args.time
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Zolramus Gatekeeper

function mod:ClingingDarkness(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:WrathOfZolramus(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

-- Zolramus Necromancer

function mod:AnimateDead(args)
	-- these NPCs can be mind-controlled by Priests but cannot cast Animate Dead while MC'd
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Brittlebone Mage

function mod:FrostboltVolley(args)
	if self:MobId(args.sourceGUID) == 163126 then -- Brittlebone Mage, Amarth has adds that cast this spell
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Skeletal Marauder

function mod:RaspingScream(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:BoneshatterShieldApplied(args)
	self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "alert")
end

-- Zolramus Bonemender

function mod:Bonemend(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:FinalBargain(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Nar'zudah

do
	local timer

	function mod:DarkShroud(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 22.7)
		timer = self:ScheduleTimer("NarzudahDeath", 30)
	end

	function mod:DarkShroudRemoved(args)
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end

	function mod:GrimFate(args)
		if self:MobId(args.sourceGUID) == 165824 then -- Nar'zudah
			if timer then
				self:CancelTimer(timer)
			end
			self:CDBar(327396, 20.7)
			timer = self:ScheduleTimer("NarzudahDeath", 30)
		end
	end

	function mod:GrimFateApplied(args)
		self:TargetMessage(args.spellId, "yellow", args.destName)
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

	function mod:NarzudahDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(335141) -- Dark Shroud
		self:StopBar(327396) -- Grim Fate
	end
end

-- Skeletal Monstrosity

do
	local timer

	function mod:Shatter(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("SkeletalMonstrosityDeath", 30)
	end

	function mod:FrigidSpikes(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 12.1)
		timer = self:ScheduleTimer("SkeletalMonstrosityDeath", 30)
	end

	function mod:ReapingWinds(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 20.6)
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
	end
end

-- Corpse Collector

function mod:Goresplatter(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Kyrian Stitchwerk

function mod:Mutilate(args)
	if self:MobId(args.sourceGUID) ~= 164578 then -- Stitchflesh's Creation, add on Surgeon Stitchflesh
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:Tenderize(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "info")
	-- This bar is here in case dps/pets taunt to let the tank drop stacks
	self:NameplateCDBar(args.spellId, 12.2, args.sourceGUID)
end

-- Flesh Crafter

function mod:RepairFlesh(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

do
	local prevOnMe = 0
	function mod:ThrowCleaver(args)
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
		local t = args.time
		if self:Me(args.destGUID) and t - prevOnMe > 2 then
			prevOnMe = t
			self:Say(args.spellId, nil, nil, "Throw Cleaver")
		end
	end
end

-- Loyal Creation

function mod:SpineCrush(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Separation Assistant

do
	local function printTarget(self, name, guid)
		self:TargetMessage(338606, "yellow", name)
		if self:Me(guid) then
			self:PlaySound(338606, "alarm", nil, name)
		else
			self:PlaySound(338606, "info", nil, name)
		end
	end

	function mod:MorbidFixation(args)
		-- alert earlier using target scanning instead of watching the debuff
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:MorbidFixationApplied(args)
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:MorbidFixationRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

-- Goregrind

function mod:GutSlice(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Rotspew

do
	local function printTarget(self, name, guid)
		self:TargetMessage(333479, "yellow", name)
		self:PlaySound(333479, "alert", nil, name)
		if self:Me(guid) then
			self:Say(333479, nil, nil, "Spew Disease")
		end
	end

	function mod:SpewDisease(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
	end
end
