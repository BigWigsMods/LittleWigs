--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shadowmoon Burial Grounds Trash", 1176)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	75713, -- Shadowmoon Bone-Mender
	75715, -- Reanimated Ritual Bones
	75652, -- Void Spawn
	75506, -- Shadowmoon Loyalist
	75451, -- Defiled Spirit
	76446, -- Shadowmoon Dominator
	77700, -- Shadowmoon Exhumer
	75979, -- Exhumed Spirit
	76104, -- Monstrous Corpse Spider
	76057  -- Carrion Worm
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.shadowmoon_bonemender = "Shadowmoon Bone-Mender"
	L.reanimated_ritual_bones = "Reanimated Ritual Bones"
	L.void_spawn = "Void Spawn"
	L.shadowmoon_loyalist = "Shadowmoon Loyalist"
	L.defiled_spirit = "Defiled Spirit"
	L.shadowmoon_dominator = "Shadowmoon Dominator"
	L.shadowmoon_exhumer = "Shadowmoon Exhumer"
	L.exhumed_spirit = "Exhumed Spirit"
	L.monstrous_corpse_spider = "Monstrous Corpse Spider"
	L.carrion_worm = "Carrion Worm"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Shadowmoon Bone-Mender
		152818, -- Shadow Mend
		{152819, "DISPEL"}, -- Shadow Word: Frailty
		-- Reanimated Ritual Bones
		{164907, "TANK_HEALER"}, -- Void Slash
		-- Void Spawn
		152964, -- Void Pulse
		394512, -- Void Eruptions
		-- Shaodwmoon Loyalist
		{398151, "DISPEL"}, -- Sinister Focus
		-- Defiled Spirit
		398154, -- Cry of Anguish
		-- Shaodwmoon Dominator
		398150, -- Domination
		-- Shadowmoon Exhumer
		153268, -- Exhume the Crypts
		-- Exhumed Spirit
		398206, -- Death Blast
		-- Monstrous Corpse Spider
		156718, -- Necrotic Burst
		-- Carrion Worm
		153395, -- Body Slam
	}, {
		[152818] = L.shadowmoon_bonemender,
		[164907] = L.reanimated_ritual_bones,
		[152964] = L.void_spawn,
		[398151] = L.shadowmoon_loyalist,
		[398154] = L.defiled_spirit,
		[398150] = L.shadowmoon_dominator,
		[153268] = L.shadowmoon_exhumer,
		[398206] = L.exhumed_spirit,
		[156718] = L.monstrous_corpse_spider,
		[153395] = L.carrion_worm,
	}
end

function mod:OnBossEnable()
	-- Shadowmoon Bone-Mender
	self:Log("SPELL_CAST_START", "ShadowMend", 152818)
	self:Log("SPELL_AURA_APPLIED", "ShadowWordFrailtyApplied", 152819)

	-- Reanimated Ritual Bones
	self:Log("SPELL_CAST_START", "VoidSlash", 164907)

	-- Void Spawn
	self:Log("SPELL_CAST_START", "VoidPulse", 152964)
	self:Log("SPELL_CAST_SUCCESS", "VoidEruptions", 394512)

	-- Shadowmoon Loyalist
	self:Log("SPELL_AURA_APPLIED", "SinisterFocusApplied", 398151)

	-- Defiled Spirit
	self:Log("SPELL_CAST_START", "CryOfAnguish", 398154)

	-- Shadowmoon Dominator
	self:Log("SPELL_CAST_START", "Domination", 398150)
	self:Log("SPELL_AURA_APPLIED", "DominationApplied", 398150)

	-- Shadowmoon Exhumer
	self:Log("SPELL_CAST_START", "ExhumeTheCrypts", 153268)

	-- Exhumed Spirit
	self:Log("SPELL_CAST_START", "DeathBlast", 398206)

	-- Monstrous Corpse Spider
	self:Log("SPELL_CAST_START", "NecroticBurst", 156718)

	-- Carrion Worm
	self:Log("SPELL_CAST_START", "BodySlam", 153395)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Shadowmoon Bone-Mender

function mod:ShadowMend(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:ShadowWordFrailtyApplied(args)
	if self:Dispeller("magic", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Reanimated Ritual Bones

function mod:VoidSlash(args)
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "alarm")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

-- Void Spawn

function mod:VoidPulse(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidEruptions(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
end

-- Shadowmoon Loyalist

function mod:SinisterFocusApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Defiled Spirit

function mod:CryOfAnguish(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Shadowmoon Dominator

function mod:Domination(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:DominationApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
end

-- Shadowmoon Exhumer

function mod:ExhumeTheCrypts(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Exhumed Spirit

do
	local prev = 0
	function mod:DeathBlast(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Monstrous Corpse Spider

do
	local prev = 0
	function mod:NecroticBurst(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Carrion Worm

function mod:BodySlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
