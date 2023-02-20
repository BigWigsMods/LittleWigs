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
	189531, -- Decayed Elder
	186229, -- Wilted Oak
	187033, -- Stinkbreath
	187192, -- Rageclaw
	186246, -- Fleshripper Vulture
	185656, -- Filth Caller
	186226  -- Fetid Rotsinger
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
	L.decayed_elder = "Decayed Elder"
	L.wilted_oak = "Wilted Oak"
	L.stinkbreath = "Stinkbreath"
	L.rageclaw = "Rageclaw"
	L.fleshripper_vulture = "Fleshripper Vulture"
	L.filth_caller = "Filth Caller"
	L.fetid_rotsinger = "Fetid Rotsinger"
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
		-- Claw Fighter
		367484, -- Vicious Clawmangle
		-- Bonebolt Hunter
		368287, -- Toxic Trap
		-- Bracken Warscourge
		367500, -- Hideous Cackle
		382555, -- Ragestorm
		-- Decayed Elder
		373897, -- Decaying Roots
		-- Wilted Oak
		373943, -- Stomp
		382712, -- Necrotic Breath
		-- Stinkbreath
		388060, -- Stink Breath
		388046, -- Violent Whirlwind
		-- Rageclaw
		{385832, "SAY"}, -- Bloodthirsty Charge
		-- Fleshripper Vulture
		385029, -- Screech
		-- Filth Caller
		383399, -- Rotting Surge
		-- Fetid Rotsinger
		374057, -- Summon Totem
		374544, -- Burst of Decay
	}, {
		["custom_on_cauldron_autotalk"] = L.decaying_cauldron,
		[382435] = L.decay_speaker,
		[367484] = L.claw_fighter,
		[368287] = L.bonebolt_hunter,
		[367500] = L.bracken_warscourge,
		[373897] = L.decayed_elder,
		[373943] = L.wilted_oak,
		[388060] = L.stinkbreath,
		[385832] = L.rageclaw,
		[385029] = L.fleshripper_vulture,
		[383399] = L.filth_caller,
		[374057] = L.fetid_rotsinger,
	}, {
		[367484] = CL.fixate, -- Vicious  Clawmangle (Fixate)
	}
end

function mod:OnBossEnable()
	-- Decaying Cauldron
	self:RegisterEvent("GOSSIP_SHOW")

	-- TODO Captive Tuskarr?
	-- [UPDATE_UI_WIDGET] widgetID:4267, widgetType:8, widgetSetID:1, scriptedAnimationEffectID:0, modelSceneLayer:0, widgetScale:0, tooltipLoc:0, fontType:1, shownState:1, widgetSizeSetting:0, bottomPadding:0, enabledState:1, textSizeType:4, text:Tuskarr Freed: 4/5, orderIndex:0, layoutDirection:0, inAnimType:0, widgetTag:, hasTimer:false, outAnimType:0, tooltip:Free Tuskarr to goad Hackclaw's War-Band out into the open., hAlign:1

	-- Decay Speaker
	-- TODO can this mob be stunned to stop the totem spawn?
	self:Log("SPELL_SUMMON", "RotchantingTotemSummoned", 382435)

	-- Claw Fighter
	self:Log("SPELL_AURA_APPLIED", "ViciousClawmangleApplied", 367484)

	-- Bonebolt Hunter
	self:Log("SPELL_CAST_SUCCESS", "ToxicTrap", 368287)

	-- Bracken Warscourge
	self:Log("SPELL_CAST_START", "HideousCackle", 367500)
	self:Log("SPELL_CAST_SUCCESS", "Ragestorm", 382555)
	self:Log("SPELL_DAMAGE", "RagestormDamage", 382556)
	self:Log("SPELL_MISSED", "RagestormDamage", 382556)

	-- Decayed Elder
	self:Log("SPELL_CAST_START", "DecayingRoots", 373897)

	-- Wilted Oak
	self:Log("SPELL_CAST_START", "Stomp", 373943)
	self:Log("SPELL_CAST_START", "NecroticBreath", 382712)

	-- Stinkbreath
	self:Log("SPELL_CAST_START", "StinkBreath", 388060)
	self:Log("SPELL_CAST_START", "ViolentWhirlwind", 388046)

	-- Rageclaw
	self:Log("SPELL_CAST_START", "BloodthirstyCharge", 385832)

	-- Fleshripper Vulture
	self:Log("SPELL_CAST_START", "Screech", 385029)

	-- Filth Caller
	self:Log("SPELL_AURA_APPLIED", "RottingSurgeDamage", 383399)
	self:Log("SPELL_PERIODIC_DAMAGE", "RottingSurgeDamage", 383399)
	self:Log("SPELL_PERIODIC_MISSED", "RottingSurgeDamage", 383399)

	-- Fetid Rotsinger
	self:Log("SPELL_SUMMON", "DecayTotemSummoned", 374057)
	self:Log("SPELL_CAST_START", "BurstOfDecay", 374544)
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

-- Fleshripper Vulture

function mod:Screech(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Filth Caller

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

-- Fetid Rotsinger

function mod:DecayTotemSummoned(args)
	self:Message(args.spellId, "yellow", CL.spawned:format(args.destName))
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:BurstOfDecay(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
