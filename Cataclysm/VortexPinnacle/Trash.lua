--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Vortex Pinnacle Trash", 657)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	45915, -- Armored Mistral
	45912, -- Wild Vortex
	45704, -- Lurking Tempest
	45917, -- Cloud Prince
	45924, -- Turbulent Squall
	45922, -- Empyrean Assassin
	45919, -- Young Storm Dragon
	45928, -- Executor of the Caliph
	45935, -- Temple Adept
	45926, -- Servant of Asaad
	45930  -- Minister of Air
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.armored_mistral = "Armored Mistral"
	L.wild_vortex = "Wild Vortex"
	L.lurking_tempest = "Lurking Tempest"
	L.cloud_prince = "Cloud Prince"
	L.turbulent_squall = "Turbulent Squall"
	L.empyrean_assassin = "Empyrean Assassin"
	L.young_storm_dragon = "Young Storm Dragon"
	L.executor_of_the_caliph = "Executor of the Caliph"
	L.temple_adept = "Temple Adept"
	L.servant_of_asaad = "Servant of Asaad"
	L.minister_of_air = "Minister of Air"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Armored Mistral
		410999, -- Pressurized Blast
		-- Wild Vortex
		410870, -- Cyclone
		-- Lurking Tempest
		411001, -- Lethal Current
		-- Cloud Prince
		411002, -- Turbulence
		411005, -- Bomb Cyclone
		-- Turbulent Squall
		88170, -- Cloudburst
		88171, -- Hurricane
		-- Empyrean Assassin
		88186, -- Vapor Form
		{88182, "DISPEL"}, -- Lethargic Poison
		-- Young Storm Dragon
		411910, -- Healing Well
		411012, -- Chilling Breath
		88194, -- Icy Buffet
		-- Executor of the Caliph
		413387, -- Crashing Stone
		87759, -- Shockwave
		-- Temple Adept
		87779, -- Greater Heal
		-- Servant of Asaad
		87772, -- Hand of Protection
		-- Minister of Air
		87762, -- Lightning Lash
		413385, -- Overload Grounding Field
	}, {
		[410999] = L.armored_mistral,
		[410870] = L.wild_vortex,
		[411001] = L.lurking_tempest,
		[411002] = L.cloud_prince,
		[88170] = L.turbulent_squall,
		[88186] = L.empyrean_assassin,
		[411910] = L.young_storm_dragon,
		[413387] = L.executor_of_the_caliph,
		[87779] = L.temple_adept,
		[87772] = L.servant_of_asaad,
		[87762] = L.minister_of_air,
	}
end

function mod:OnBossEnable()
	-- Armored Mistral
	self:Log("SPELL_CAST_START", "PressurizedBlast", 410999)

	-- Wild Vortex
	self:Log("SPELL_CAST_START", "Cyclone", 410870)

	-- Lurking Tempest
	self:Log("SPELL_CAST_START", "LethalCurrent", 411001)

	-- Cloud Prince
	self:Log("SPELL_CAST_START", "Turbulence", 411002)
	self:Log("SPELL_CAST_SUCCESS", "BombCyclone", 411004)

	-- Turbulent Squall
	self:Log("SPELL_CAST_START", "Cloudburst", 88170)
	-- TODO post-10.1 see if Hurricane was removed from normal/heroic as well
	self:Log("SPELL_AURA_APPLIED", "HurricaneDamage", 88171)
	self:Log("SPELL_PERIODIC_DAMAGE", "HurricaneDamage", 88171)
	self:Log("SPELL_PERIODIC_MISSED", "HurricaneDamage", 88171)

	-- Empyrean Assassin
	self:Log("SPELL_CAST_START", "VaporForm", 88186)
	self:Log("SPELL_AURA_APPLIED", "VaporFormApplied", 88186)
	-- TODO post-10.1 see if Lethargic Poison was removed from normal/heroic as well
	self:Log("SPELL_AURA_APPLIED_DOSE", "LethargicPoisonApplied", 88182)

	-- Young Storm Dragon
	self:Log("SPELL_CAST_START", "HealingWell", 411910)
	self:Log("SPELL_CAST_START", "ChillingBreath", 411012)
	self:Log("SPELL_CAST_START", "IcyBuffet", 88194)

	-- Executor of the Caliph
	self:Log("SPELL_CAST_START", "CrashingStone", 413387)
	-- TODO post-10.1 see if Shockwave was removed from normal/heroic as well
	self:Log("SPELL_CAST_SUCCESS", "Shockwave", 87759)

	-- Temple Adept
	self:Log("SPELL_CAST_START", "GreaterHeal", 87779)

	-- Servant of Asaad
	-- TODO post-10.1 see if Hand of Protection was removed from normal/heroic as well
	self:Log("SPELL_AURA_APPLIED", "HandOfProtectionApplied", 87772)

	-- Minister of Air
	self:Log("SPELL_CAST_START", "LightningLash", 87762)
	self:Log("SPELL_CAST_START", "OverloadGroundingField", 413385)
	self:Log("SPELL_DAMAGE", "OverloadGroundingFieldDamage", 413386)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Armored Mistral

function mod:PressurizedBlast(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Wild Vortex

function mod:Cyclone(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Lurking Tempest

do
	local prev = 0
	function mod:LethalCurrent(args)
		if self:MobId(args.sourceGUID) == 45704 then -- Lurking Tempest (trash version)
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "red", CL.casting:format(args.spellName))
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

-- Cloud Prince

function mod:Turbulence(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:BombCyclone(args)
	self:Message(411005, "orange")
	self:PlaySound(411005, "alarm")
end

-- Turbulent Squall

do
	local prev = 0
	function mod:Cloudburst(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:HurricaneDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Wild Vortex

function mod:VaporForm(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:VaporFormApplied(args)
	if not self:Player(args.destFlags) and self:Dispeller("magic", true) then
		self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:LethargicPoisonApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("poison", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		if args.amount == 10 or args.amount % 4 == 0 then -- 4, 8, 10 (max)
			self:StackMessage(args.spellId, "purple", args.destName, args.amount, 4)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

-- Young Storm Dragon

function mod:HealingWell(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end

function mod:ChillingBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:IcyBuffet(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

-- Executor of the Caliph

do
	local prev = 0
	function mod:CrashingStone(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:Shockwave(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Temple Adept

do
	local prev = 0
	function mod:GreaterHeal(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Servant of Asaad

function mod:HandOfProtectionApplied(args)
	if not self:Player(args.destFlags) and self:Dispeller("magic", true) then
		self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Minister of Air

do
	local function printTarget(self, name, guid)
		self:TargetMessage(87762, "red", name)
		if self:Me(guid) then
			self:PlaySound(87762, "warning")
		else
			self:PlaySound(87762, "alert", nil, name)
		end
	end

	function mod:LightningLash(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
	end
end

function mod:OverloadGroundingField(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:OverloadGroundingFieldDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(413385, "near")
		self:PlaySound(413385, "underyou")
	end
end
