--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Spires of Ascension Trash", 2285)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	163503, -- Etherdiver
	163458, -- Forsworn Castigator
	168420, -- Forsworn Champion
	168318, -- Forsworn Goliath
	168418, -- Forsworn Inquisitor
	163459, -- Forsworn Mender
	163520, -- Forsworn Squad-Leader
	168718, -- Forsworn Warden
	168845, -- Astronos
	168844, -- Lakesis
	168843 -- Klotos
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.etherdiver = "Etherdiver"
	L.forsworn_castigator = "Forsworn Castigator"
	L.forsworn_champion = "Forsworn Champion"
	L.forsworn_goliath = "Forsworn Goliath"
	L.forsworn_inquisitor = "Forsworn Inquisitor"
	L.forsworn_mender = "Forsworn Mender"
	L.forsworn_squad_leader = "Forsworn Squad-Leader"
	L.forsworn_warden = "Forsworn Warden"
	L.astronos = "Astronos"
	L.lakesis = "Lakesis"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Etherdiver
		{317661, "DISPEL"}, -- Insidious Venom
		-- Forsworn Castigator
		{317963, "DISPEL"}, -- Burden of Knowledge
		-- Forsworn Champion
		327655, -- Infuse Weapon
		-- Forsworn Goliath
		327413, -- Rebellious Fist
		-- Forsworn Inquisitor
		327648, -- Internal Strife
		-- Forsworn Mender
		317936, -- Forsworn Doctrine
		327332, -- Imbue Weapon
		-- Forsworn Squad-Leader
		317985, -- Crashing Strike
		-- Forsworn Warden
		328295, -- Greater Mending
		328288, -- Bless Weapon
		-- Astronos
		328462, -- Charged Spear
		-- Lakesis
		328458, -- Diminuendo
	}, {
		[317661] = L.forsworn_squad_leader,
		[317963] = L.forsworn_castigator,
		[327655] = L.forsworn_champion,
		[327413] = L.forsworn_goliath,
		[327648] = L.forsworn_inquisitor,
		[317936] = L.forsworn_mender,
		[317985] = L.forsworn_squad_leader,
		[328295] = L.forsworn_warden,
		[328462] = L.astronos,
		[328458] = L.lakesis,
	}
end

function mod:OnBossEnable()
	-- Etherdiver
	self:Log("SPELL_AURA_APPLIED", "InsidiousVenomApplied", 317661)
	-- Forsworn Castigator
	self:Log("SPELL_CAST_START", "BurdenOfKnowledge", 317963)
	self:Log("SPELL_AURA_APPLIED", "BurdenOfKnowledgeApplied", 317963)
	-- Forsworn Champion
	self:Log("SPELL_CAST_START", "InfuseWeapon", 327655)
	self:Log("SPELL_AURA_APPLIED", "InfuseWeaponApplied", 327655)
	-- Forsworn Goliath
	self:Log("SPELL_CAST_START", "RebelliousFist", 327413)
	-- Forsworn Inquisitor
	self:Log("SPELL_CAST_START", "InternalStrife", 327648)
	-- Forsworn Mender
	self:Log("SPELL_CAST_START", "ForswornDoctrine", 317936)
	self:Log("SPELL_CAST_START", "ImbueWeapon", 327332)
	self:Log("SPELL_AURA_APPLIED", "ImbueWeaponApplied", 327332)
	-- Forsworn Squad-Leader
	self:Log("SPELL_CAST_START", "CrashingStrike", 317985)
	-- Forsworn Warden
	self:Log("SPELL_CAST_START", "GreaterMending", 328295)
	self:Log("SPELL_CAST_START", "BlessWeapon", 328288)
	self:Log("SPELL_AURA_APPLIED", "BlessWeaponApplied", 328288)
	-- Astronos
	self:Log("SPELL_CAST_START", "ChargedSpear", 328462)
	self:Death("AstronosDeath", 168845)
	-- Lakesis
	self:Log("SPELL_CAST_START", "Diminuendo", 328458)
	self:Death("LakesisDeath", 168844)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Etherdiver
function mod:InsidiousVenomApplied(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Forsworn Castigator
do
	local prev = 0
	function mod:BurdenOfKnowledge(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:BurdenOfKnowledgeApplied(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Forsworn Champion
function mod:InfuseWeapon(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:InfuseWeaponApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
	end
end

-- Forsworn Goliath
function mod:RebelliousFist(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Forsworn Inquisitor
function mod:InternalStrife(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Forsworn Mender
function mod:ForswornDoctrine(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:ImbueWeapon(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:ImbueWeaponApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
	end
end

-- Forsworn Squad-Leader
function mod:CrashingStrike(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Forsworn Warden
function mod:GreaterMending(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:BlessWeapon(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:BlessWeaponApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
	end
end

-- Astronos
function mod:ChargedSpear(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 16.5)
end

function mod:AstronosDeath(args)
	self:StopBar(328462) -- Charged Spear
end

-- Lakesis
function mod:Diminuendo(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 15.8)
end

function mod:LakesisDeath(args)
	self:StopBar(328458) -- Diminuendo
end
