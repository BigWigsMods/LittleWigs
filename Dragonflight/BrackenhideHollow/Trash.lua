--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brackenhide Hollow Trash", 2520)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	194675, -- Decaying Cauldron
	186191, -- Decay Speaker
	185508, -- Claw Fighter
	185534, -- Bonebolt Hunter
	185529, -- Bracken Warscourge
	186220, -- Brackenhide Shaper
	189531, -- Decayed Elder
	186229, -- Wilted Oak
	186226, -- Fetid Rotsinger
	190426, -- Decay Totem
	186227, -- Monstrous Decay
	189318, -- Infected Bear
	187033, -- Stinkbreath
	187192, -- Rageclaw
	186208, -- Rotbow Stalker
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

	L.decaying_cauldron = "Decaying Cauldron"
	L.decay_speaker = "Decay Speaker"
	L.claw_fighter = "Claw Fighter"
	L.bonebolt_hunter = "Bonebolt Hunter"
	L.bracken_warscourge = "Bracken Warscourge"
	L.brackenhide_shaper = "Brackenhide Shaper"
	L.decayed_elder = "Decayed Elder"
	L.wilted_oak = "Wilted Oak"
	L.fetid_rotsinger = "Fetid Rotsinger"
	L.monstrous_decay = "Monstrous Decay"
	L.infected_bear = "Infected Bear"
	L.stinkbreath = "Stinkbreath"
	L.rageclaw = "Rageclaw"
	L.rotbow_stalker = "Rotbow Stalker"
	L.skulking_gutstabber = "Skulking Gutstabber"
	L.fleshripper_vulture = "Fleshripper Vulture"
	L.filth_caller = "Filth Caller"
	L.vile_rothexer = "Vile Rothexer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Decaying Cauldron
		"custom_on_cauldron_autotalk",
		-- Decay Speaker
		382435, -- Rotchanting Totem
		{367503, "SAY"}, -- Withering Burst
		{368081, "DISPEL"}, -- Withering
		-- Claw Fighter
		367484, -- Vicious Clawmangle
		-- Bonebolt Hunter
		368287, -- Toxic Trap
		-- Bracken Warscourge
		367500, -- Hideous Cackle
		382555, -- Ragestorm
		-- Brackenhide Shaper
		372711, -- Infuse Corruption
		-- Decayed Elder
		373897, -- Decaying Roots
		-- Wilted Oak
		373943, -- Stomp
		382712, -- Necrotic Breath
		-- Fetid Rotsinger
		374057, -- Summon Totem
		{374544, "SAY"}, -- Burst of Decay
		-- Monstrous Decay
		374569, -- Burst
		-- Infected Bear
		{373929, "TANK"}, -- Bash
		-- Stinkbreath
		388060, -- Stink Breath
		388046, -- Violent Whirlwind
		-- Rageclaw
		{385832, "SAY"}, -- Bloodthirsty Charge
		{385827, "DISPEL"}, -- Bloody Rage
		-- Rotbow Stalker
		384974, -- Scented Meat
		-- Skulking Gutstabber
		{385058, "DISPEL"}, -- Withering Poison
		-- Fleshripper Vulture
		385029, -- Screech
		-- Filth Caller
		383399, -- Rotting Surge
		-- Vile Rothexer
		{383087, "SAY"}, -- Withering Contagion
	}, {
		["custom_on_cauldron_autotalk"] = L.decaying_cauldron,
		[382435] = L.decay_speaker,
		[367484] = L.claw_fighter,
		[368287] = L.bonebolt_hunter,
		[367500] = L.bracken_warscourge,
		[372711] = L.brackenhide_shaper,
		[373897] = L.decayed_elder,
		[373943] = L.wilted_oak,
		[374057] = L.fetid_rotsinger,
		[374569] = L.monstrous_decay,
		[373929] = L.infected_bear,
		[388060] = L.stinkbreath,
		[385832] = L.rageclaw,
		[384974] = L.rotbow_stalker,
		[385058] = L.skulking_gutstabber,
		[385029] = L.fleshripper_vulture,
		[383399] = L.filth_caller,
		[383087] = L.vile_rothexer,
	}, {
		[367484] = CL.fixate, -- Vicious Clawmangle (Fixate)
		[384974] = CL.fixate, -- Scented Meat (Fixate)
	}
end

function mod:OnBossEnable()
	-- Decaying Cauldron
	self:RegisterEvent("GOSSIP_SHOW")

	-- TODO Captive Tuskarr?
	-- [UPDATE_UI_WIDGET] widgetID:4267, widgetType:8, widgetSetID:1, scriptedAnimationEffectID:0, modelSceneLayer:0, widgetScale:0, tooltipLoc:0, fontType:1, shownState:1, widgetSizeSetting:0, bottomPadding:0, enabledState:1, textSizeType:4, text:Tuskarr Freed: 4/5, orderIndex:0, layoutDirection:0, inAnimType:0, widgetTag:, hasTimer:false, outAnimType:0, tooltip:Free Tuskarr to goad Hackclaw's War-Band out into the open., hAlign:1

	-- Decay Speaker
	self:Log("SPELL_SUMMON", "RotchantingTotemSummoned", 382435)
	self:Log("SPELL_CAST_START", "WitheringBurst", 367503)
	self:Log("SPELL_AURA_APPLIED", "WitheringApplied", 368081)

	-- Claw Fighter
	self:Log("SPELL_AURA_APPLIED", "ViciousClawmangleApplied", 367484)

	-- Bonebolt Hunter
	self:Log("SPELL_CAST_SUCCESS", "ToxicTrap", 368287)

	-- Bracken Warscourge
	self:Log("SPELL_CAST_START", "HideousCackle", 367500)
	self:Log("SPELL_CAST_START", "Ragestorm", 382555)
	self:Log("SPELL_DAMAGE", "RagestormDamage", 382556)
	self:Log("SPELL_MISSED", "RagestormDamage", 382556)

	-- Brackenhide Shaper
	self:Log("SPELL_CAST_SUCCESS", "InfuseCorruption", 372711)

	-- Decayed Elder
	self:Log("SPELL_CAST_START", "DecayingRoots", 373897)

	-- Wilted Oak
	self:Log("SPELL_CAST_START", "Stomp", 373943)
	self:Log("SPELL_CAST_START", "NecroticBreath", 382712)

	-- Fetid Rotsinger
	self:Log("SPELL_SUMMON", "DecayTotemSummoned", 374057)
	self:Log("SPELL_CAST_START", "BurstOfDecay", 374544)

	-- Monstrous Decay
	self:Log("SPELL_CAST_START", "Burst", 374569)

	-- Infected Bear
	self:Log("SPELL_CAST_START", "Bash", 373929)

	-- Stinkbreath
	self:Log("SPELL_CAST_START", "StinkBreath", 388060)
	self:Log("SPELL_CAST_START", "ViolentWhirlwind", 388046)

	-- Rageclaw
	self:Log("SPELL_CAST_START", "BloodthirstyCharge", 385832)
	self:Log("SPELL_AURA_APPLIED", "BloodyRageApplied", 385827)

	-- Rotbow Stalker
	self:Log("SPELL_AURA_APPLIED", "ScentedMeatApplied", 384974)

	-- Skulking Gutstabber
	self:Log("SPELL_AURA_APPLIED", "WitheringPoisonApplied", 385058)

	-- Fleshripper Vulture
	self:Log("SPELL_CAST_START", "Screech", 385029)

	-- Filth Caller
	self:Log("SPELL_CAST_SUCCESS", "RottingSurge", 383385)
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

-- Decay Speaker

function mod:RotchantingTotemSummoned(args)
	self:Message(args.spellId, "yellow", CL.spawned:format(args.destName))
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(367503, "orange", name)
		self:PlaySound(367503, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(367503)
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

function mod:ViciousClawmangleApplied(args)
	if self:Me(args.destGUID) and not self:Tank() then
		self:PersonalMessage(args.spellId, nil, CL.fixate)
		self:PlaySound(args.spellId, "long")
	end
end

-- Bonebolt Hunter

function mod:ToxicTrap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
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
		if self:Me(args.destGUID) and not self:Tank() then
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

function mod:NecroticBreath(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Fetid Rotsinger

function mod:DecayTotemSummoned(args)
	self:Message(args.spellId, "yellow", CL.spawned:format(args.destName))
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(374544, "red", name)
		self:PlaySound(374544, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(374544)
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

-- Infected Bear

function mod:Bash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

-- Stinkbreath

function mod:StinkBreath(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ViolentWhirlwind(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Rageclaw

do
	local function printTarget(self, name, guid)
		self:TargetMessage(385832, "red", name)
		self:PlaySound(385832, "alert", nil, name)
		if self:Me(guid) then
			self:Say(385832)
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

-- Rotbow Stalker

function mod:ScentedMeatApplied(args)
	if self:Me(args.destGUID) and not self:Tank() then
		self:PersonalMessage(args.spellId, nil, CL.fixate)
		self:PlaySound(args.spellId, "warning")
	elseif self:Healer() then
		self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Skulking Gutstabber

function mod:WitheringPoisonApplied(args)
	-- TODO on live not dispelled by movement (bug), check PTR
	if self:Dispeller("poison", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
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
	-- this is triggered on cast success (there's a channel after) because
	-- interrupting this during the pre-cast doesn't put it on CD
	self:Message(383399, "yellow")
	self:PlaySound(383399, "alert")
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
		self:Say(args.spellId)
	end
end

function mod:WitheringContagionApplied(args)
	-- this is the dispellable version which can spread
	if self:Dispeller("disease", nil, 383087) then
		self:TargetMessage(383087, "yellow", args.destName)
		self:PlaySound(383087, "alert", nil, args.destName)
	end
end
