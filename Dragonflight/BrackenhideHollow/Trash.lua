--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brackenhide Hollow Trash", 2520)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	194675, -- Decaying Cauldron
	186766, -- Captive Tuskarr
	186191, -- Decay Speaker
	185508, -- Claw Fighter
	185534, -- Bonebolt Hunter
	185529, -- Bracken Warscourge
	186220, -- Brackenhide Shaper
	191926, -- Fishface
	189531, -- Decayed Elder
	186229, -- Wilted Oak
	186226, -- Fetid Rotsinger
	190426, -- Decay Totem
	186227, -- Monstrous Decay
	189299, -- Decaying Slime (regular mob)
	199916, -- Decaying Slime (infinitely spawning mob)
	194330, -- Decaying Slime (summoned by Monstrous Decay)
	189318, -- Infected Bear
	187033, -- Stinkbreath
	187192, -- Rageclaw
	186208, -- Rotbow Ranger
	186242, -- Skulking Gutstabber
	186246, -- Fleshripper Vulture
	185656, -- Filth Caller
	194241, -- Vile Rothexer
	187224, -- Vile Rothexer
	194487  -- Vile Rothexer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_cauldron_autotalk = "Autotalk"
	L.custom_on_cauldron_autotalk_desc = "[Alchemy] Instantly detoxify Decaying Cauldrons for a disease dispel buff."
	L.custom_on_cauldron_autotalk_icon = "ui_chat"
	L.captive_tuskarr_freed = "Captive Tuskarr Freed"
	L.captive_tuskarr_freed_desc = "Show an alert when a Captive Tuskarr has been freed."
	L.captive_tuskarr_freed_icon = "inv_10_dungeonjewelry_primitive_trinket_tuskarrplushie_color1"

	L.decaying_cauldron = "Decaying Cauldron"
	L.captive_tuskarr = "Captive Tuskarr"
	L.decay_speaker = "Decay Speaker"
	L.claw_fighter = "Claw Fighter"
	L.bonebolt_hunter = "Bonebolt Hunter"
	L.bracken_warscourge = "Bracken Warscourge"
	L.brackenhide_shaper = "Brackenhide Shaper"
	L.fishface = "Fishface"
	L.rotting_creek = "Rotting Creek"
	L.decayed_elder = "Decayed Elder"
	L.wilted_oak = "Wilted Oak"
	L.fetid_rotsinger = "Fetid Rotsinger"
	L.decay_totem = "Decay Totem"
	L.monstrous_decay = "Monstrous Decay"
	L.decaying_slime = "Decaying Slime"
	L.infected_bear = "Infected Bear"
	L.stinkbreath = "Stinkbreath"
	L.rageclaw = "Rageclaw"
	L.rotbow_ranger = "Rotbow Ranger"
	L.skulking_gutstabber = "Skulking Gutstabber"
	L.fleshripper_vulture = "Fleshripper Vulture"
	L.filth_caller = "Filth Caller"
	L.vile_rothexer = "Vile Rothexer"
end

--------------------------------------------------------------------------------
-- Initialization
--

local decayTotemMarker = mod:AddMarkerOption(true, "npc", 7, 381821, 7) -- Decay Totem
function mod:GetOptions()
	return {
		-- Decaying Cauldron
		"custom_on_cauldron_autotalk",
		-- Captive Tuskarr
		"captive_tuskarr_freed",
		-- Decay Speaker
		{367503, "SAY"}, -- Withering Burst
		{368081, "DISPEL"}, -- Withering
		-- Claw Fighter
		{367484, "ME_ONLY"}, -- Vicious Clawmangle
		-- Bonebolt Hunter
		368287, -- Toxic Trap
		-- Bracken Warscourge
		367500, -- Hideous Cackle
		382555, -- Ragestorm
		-- Brackenhide Shaper
		372711, -- Infuse Corruption
		-- Fishface
		384854, -- Fish Slap!
		384847, -- Fresh Catch
		-- Rotting Creek
		374245, -- Rotting Creek
		-- Decayed Elder
		373897, -- Decaying Roots
		-- Wilted Oak
		373943, -- Stomp
		382712, -- Necrotic Breath
		-- Fetid Rotsinger
		374057, -- Summon Totem
		decayTotemMarker,
		{374544, "SAY"}, -- Burst of Decay
		-- Monstrous Decay
		374569, -- Burst
		-- Decaying Slime
		372141, -- Withering Away!
		-- Infected Bear
		{373929, "TANK"}, -- Bash
		-- Stinkbreath
		{388060, "SAY"}, -- Stink Breath
		388046, -- Violent Whirlwind
		-- Rageclaw
		{385832, "SAY"}, -- Bloodthirsty Charge
		{385827, "DISPEL"}, -- Bloody Rage
		-- Rotbow Ranger
		{384974, "DISPEL"}, -- Rotten Meat
		-- Fleshripper Vulture
		385029, -- Screech
		-- Filth Caller
		383399, -- Rotting Surge
		-- Vile Rothexer
		{383087, "SAY"}, -- Withering Contagion
	}, {
		["custom_on_cauldron_autotalk"] = L.decaying_cauldron,
		["captive_tuskarr_freed"] = L.captive_tuskarr,
		[367503] = L.decay_speaker,
		[367484] = L.claw_fighter,
		[368287] = L.bonebolt_hunter,
		[367500] = L.bracken_warscourge,
		[372711] = L.brackenhide_shaper,
		[384854] = L.fishface,
		[374245] = L.rotting_creek,
		[373897] = L.decayed_elder,
		[373943] = L.wilted_oak,
		[374057] = L.fetid_rotsinger,
		[374569] = L.monstrous_decay,
		[372141] = L.decaying_slime,
		[373929] = L.infected_bear,
		[388060] = L.stinkbreath,
		[385832] = L.rageclaw,
		[384974] = L.rotbow_ranger,
		[385029] = L.fleshripper_vulture,
		[383399] = L.filth_caller,
		[383087] = L.vile_rothexer,
	}, {
		[367484] = CL.fixate, -- Vicious Clawmangle (Fixate)
		[384974] = CL.fixate, -- Rotten Meat (Fixate)
	}
end

function mod:OnBossEnable()
	-- Decaying Cauldron
	self:RegisterEvent("GOSSIP_SHOW")

	-- Captive Tuskarr
	self:RegisterWidgetEvent(4267, "CaptiveTuskarrFreed", true)

	-- Decay Speaker
	self:Log("SPELL_CAST_START", "WitheringBurst", 367503)
	self:Log("SPELL_AURA_APPLIED", "WitheringApplied", 368081)

	-- Claw Fighter
	self:Log("SPELL_CAST_START", "ViciousClawmangle", 367484)
	self:Log("SPELL_AURA_APPLIED", "ViciousClawmangleApplied", 367484)

	-- Bonebolt Hunter
	self:Log("SPELL_CAST_SUCCESS", "ToxicTrap", 368287)
	self:Log("SPELL_DAMAGE", "ToxicTrapDamage", 368297) -- triggering the trap
	self:Log("SPELL_AURA_APPLIED", "ToxicTrapDamage", 368299) -- standing in the trap
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicTrapDamage", 368299) -- standing in the trap for >1s

	-- Bracken Warscourge
	self:Log("SPELL_CAST_START", "HideousCackle", 367500)
	self:Log("SPELL_CAST_START", "Ragestorm", 382555)
	self:Log("SPELL_DAMAGE", "RagestormDamage", 382556)
	self:Log("SPELL_MISSED", "RagestormDamage", 382556)

	-- Brackenhide Shaper
	self:Log("SPELL_CAST_SUCCESS", "InfuseCorruption", 372711)

	-- Fishface
	self:Log("SPELL_CAST_START", "FishSlap", 384854)
	self:Log("SPELL_CAST_START", "FreshCatch", 384847)

	-- Rotting Creek
	self:Log("SPELL_PERIODIC_DAMAGE", "RottingCreekDamage", 374245) -- don't trigger on application, it's unavoidable and doesn't do damage

	-- Decayed Elder
	self:Log("SPELL_CAST_START", "DecayingRoots", 373897)

	-- Wilted Oak
	self:Log("SPELL_CAST_START", "Stomp", 373943)
	self:Log("SPELL_CAST_START", "NecroticBreath", 382712)

	-- Fetid Rotsinger
	self:Log("SPELL_CAST_SUCCESS", "SummonDecayTotem", 375065) -- Summon Totem
	self:Log("SPELL_SUMMON", "DecayTotemSummon", 374057)
	self:Log("SPELL_CAST_START", "BurstOfDecay", 374544)

	-- Monstrous Decay
	self:Log("SPELL_CAST_START", "Burst", 374569)

	-- Decaying Slime
	self:Log("SPELL_AURA_APPLIED", "WitheringAwayDamage", 372141)
	self:Log("SPELL_PERIODIC_DAMAGE", "WitheringAwayDamage", 372141)

	-- Infected Bear
	self:Log("SPELL_CAST_START", "Bash", 373929)

	-- Stinkbreath
	self:Log("SPELL_CAST_START", "StinkBreath", 388060)
	self:Log("SPELL_CAST_START", "ViolentWhirlwind", 388046)
	self:Death("StinkbreathDeath", 187033)

	-- Rageclaw
	self:Log("SPELL_CAST_START", "BloodthirstyCharge", 385832)
	self:Log("SPELL_AURA_APPLIED", "BloodyRageApplied", 385827)

	-- Rotbow Ranger
	self:Log("SPELL_AURA_APPLIED", "RottenMeatApplied", 384974)

	-- Fleshripper Vulture
	self:Log("SPELL_CAST_START", "Screech", 385029)

	-- Filth Caller
	self:Log("SPELL_CAST_START", "RottingSurge", 383385)
	self:Log("SPELL_AURA_APPLIED", "RottingSurgeDamage", 383399)
	self:Log("SPELL_PERIODIC_DAMAGE", "RottingSurgeDamage", 383399)
	self:Log("SPELL_PERIODIC_MISSED", "RottingSurgeDamage", 383399)

	-- Vile Rothexer
	self:Log("SPELL_AURA_APPLIED", "WitheringContagion", 383087)
	self:Log("SPELL_AURA_APPLIED", "WitheringContagionApplied", 382808)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Decaying Cauldron

function mod:GOSSIP_SHOW(event)
	if self:GetOption("custom_on_cauldron_autotalk") then
		if self:GetGossipID(56025) then
			-- Detoxify Cauldron (requires Alchemy)
			self:SelectGossipID(56025)
		end
	end
end

-- Captive Tuskarr

function mod:CaptiveTuskarrFreed(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:4267, widgetType:8, text:Tuskarr Freed: 1/5
	self:Message("captive_tuskarr_freed", "green", text, L.captive_tuskarr_freed_icon)
	self:PlaySound("captive_tuskarr_freed", "info")
end

-- Decay Speaker

do
	local function printTarget(self, name, guid)
		self:TargetMessage(367503, "orange", name)
		self:PlaySound(367503, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(367503, nil, nil, "Withering Burst")
		end
	end

	function mod:WitheringBurst(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

do
	local playerList = {}
	local prev = 0
	function mod:WitheringApplied(args)
		-- 10.1: this is currently bugged and cannot be dispelled by movement dispelling effects
		if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
			local t = args.time
			if t - prev > .5 then -- throttle alerts to .5s intervals
				prev = t
				playerList = {}
			end
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "yellow", playerList, 5, nil, nil, .5)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end

-- Claw Fighter

do
	local prev = 0
	function mod:ViciousClawmangle(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:ViciousClawmangleApplied(args)
	if self:Friendly(args.destFlags) then
		local onMe = self:Me(args.destGUID)
		if onMe and self:Tank() then
			-- tanks don't care about being fixated
			return
		end
		self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate)
		if onMe then
			self:PlaySound(args.spellId, "warning", nil, args.destName)
		else
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end

-- Bonebolt Hunter

function mod:ToxicTrap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:ToxicTrapDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(368287, "underyou")
				self:PlaySound(368287, "underyou")
			end
		end
	end
end

-- Bracken Warscourge

function mod:HideousCackle(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:Ragestorm(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:RagestormDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(382555, "near")
				self:PlaySound(382555, "underyou")
			end
		end
	end
end

-- Brackenhide Shaper

function mod:InfuseCorruption(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Fishface

function mod:FishSlap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 20.6, args.sourceGUID)
end

function mod:FreshCatch(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	--self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

-- Rotting Creek

do
	local prev = 0
	function mod:RottingCreekDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Decayed Elder

function mod:DecayingRoots(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Wilted Oak

function mod:Stomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:NecroticBreath(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Fetid Rotsinger

function mod:SummonDecayTotem(args)
	self:Message(374057, "yellow", CL.incoming:format(L.decay_totem))
	self:PlaySound(374057, "warning")
end

do
	local totemGUID = nil

	function mod:DecayTotemSummon(args)
		-- register events to auto-mark totem
		if self:GetOption(decayTotemMarker) then
			totemGUID = args.destGUID
			self:RegisterTargetEvents("MarkDecayTotem")
		end
	end

	function mod:MarkDecayTotem(_, unit, guid)
		if totemGUID == guid then
			totemGUID = nil
			self:CustomIcon(decayTotemMarker, unit, 7)
			self:UnregisterTargetEvents()
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(374544, "red", name)
		self:PlaySound(374544, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(374544, nil, nil, "Burst of Decay")
		end
	end

	function mod:BurstOfDecay(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

-- Monstrous Decay

function mod:Burst(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Decaying Slime

do
	local prev = 0
	function mod:WitheringAwayDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(372141, "underyou")
				self:PlaySound(372141, "underyou")
			end
		end
	end
end

-- Infected Bear

function mod:Bash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

-- Stinkbreath

do
	-- use this timer to schedule StopBars on both abilities, this way if you pull
	-- and reset the mob (or wipe) the bars won't be stuck for the rest of the dungeon.
	local timer

	local function printTarget(self, name, guid)
		self:TargetMessage(388060, "red", name)
		self:PlaySound(388060, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(388060, nil, nil, "Stink Breath")
		end
	end

	function mod:StinkBreath(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:CDBar(args.spellId, 15.8)
		timer = self:ScheduleTimer("StinkbreathDeath", 30)
	end

	function mod:ViolentWhirlwind(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 18.2)
		timer = self:ScheduleTimer("StinkbreathDeath", 30)
	end

	function mod:StinkbreathDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(388060) -- Stink Breath
		self:StopBar(388046) -- Violent Whirlwind
	end
end

-- Rageclaw

do
	local function printTarget(self, name, guid)
		self:TargetMessage(385832, "red", name)
		self:PlaySound(385832, "alert", nil, name)
		if self:Me(guid) then
			self:Say(385832, nil, nil, "Bloodthirsty Charge")
		end
	end

	function mod:BloodthirstyCharge(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:BloodyRageApplied(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Rotbow Ranger

function mod:RottenMeatApplied(args)
	if self:Me(args.destGUID) and not self:Tank() then
		self:PersonalMessage(args.spellId, nil, CL.fixate)
		self:PlaySound(args.spellId, "warning")
	elseif self:Dispeller("poison", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Fleshripper Vulture

function mod:Screech(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Filth Caller

function mod:RottingSurge(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(383399, "yellow")
	self:PlaySound(383399, "long")
end

do
	local prev = 0
	function mod:RottingSurgeDamage(args)
		if self:Me(args.destGUID) and not self:Tank() then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Vile Rothexer

function mod:WitheringContagion(args)
	-- this is the pre-application debuff, not dispellable/spreadable until 3.5s later
	self:TargetMessage(args.spellId, "orange", args.destName, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Withering Contagion")
	end
end

function mod:WitheringContagionApplied(args)
	-- this is the dispellable version which can spread
	if self:Dispeller("disease", nil, 383087) then
		self:TargetMessage(383087, "yellow", args.destName)
		self:PlaySound(383087, "alert", nil, args.destName)
	end
end
