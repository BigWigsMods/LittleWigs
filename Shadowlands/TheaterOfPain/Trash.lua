--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Theater Of Pain Trash", 2293)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	170850, -- Raging Bloodhorn
	170690, -- Diseased Horror
	174210, -- Blighted Sludge-Spewer
	169927, -- Putrid Butcher
	163086, -- Rancid Gasbag
	167538, -- Dokigg the Brutalizer
	162744, -- Nekthara the Mangler
	167532, -- Heavin the Breaker
	167536, -- Harugia the Bloodthirsty
	164506, -- Ancient Captain
	167533, -- Advent Nevermore
	167534, -- Rek the Hardened
	167998, -- Portal Guardian
	160495, -- Maniacal Soulbinder
	170882, -- Bone Magus
	169893, -- Nefarious Darkspeaker
	162763 -- Soulforged Bonereaver
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.mordretha_warmup_trigger = "Soldiers of Maldraxxus! Are you ready for some carnage?!"
	L.raging_bloodhorn = "Raging Bloodhorn"
	L.diseased_horror = "Diseased Horror"
	L.blighted_sludge_spewer = "Blighted Sludge-Spewer"
	L.putrid_butcher = "Putrid Butcher"
	L.rancid_gasbag = "Rancid Gasbag"
	L.dokigg_the_brutalizer_harugia_the_bloodthirsty = "Dokigg the Brutalizer / Harugia the Bloodthirsty"
	L.dokigg_the_brutalizer = "Dokigg the Brutalizer"
	L.nekthara_the_mangler_heavin_the_breaker = "Nekthara the Mangler / Heavin the Breaker"
	L.nekthara_the_mangler_rek_the_hardened = "Nekthara the Mangler / Rek the Hardened"
	L.nekthara_the_mangler = "Nekthara the Mangler"
	L.heavin_the_breaker = "Heavin the Breaker"
	L.harugia_the_bloodthirsty_advent_nevermore = "Harugia the Bloodthirsty / Advent Nevermore"
	L.harugia_the_bloodthirsty = "Harugia the Bloodthirsty"
	L.ancient_captain = "Ancient Captain"
	L.advent_nevermore = "Advent Nevermore"
	L.rek_the_hardened = "Rek the Hardened"
	L.portal_guardian = "Portal Guardian"
	L.maniacal_soulbinder = "Maniacal Soulbinder"
	L.bone_magus = "Bone Magus"
	L.nefarious_darkspeaker = "Nefarious Darkspeaker"
	L.soulforged_bonereaver = "Soulforged Bonereaver"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Raging Bloodhorn
		{333241, "DISPEL"}, -- Raging Tantrum
		-- Diseased Horror
		319290, -- Meat Shield
		{330700, "DISPEL"}, -- Decaying Blight
		-- Blighted Sludge-Spewer
		341969, -- Withering Discharge
		{341949, "DISPEL"}, -- Withering Blight
		-- Putrid Butcher
		330586, -- Devour Flesh
		332836, -- Chop
		-- Rancid Gasbag
		330614, -- Vile Eruption
		-- Dokigg the Brutalizer / Harugia the Bloodthirsty
		342139, -- Battle Trance
		-- Dokigg the Brutalizer
		342125, -- Brutal Leap
		-- Nekthara the Mangler / Heavin the Breaker
		342135, -- Interrupting Roar
		-- Nekthara the Mangler / Rek the Hardened
		317605, -- Whirlwind
		-- Nekthara the Mangler
		337037, -- Whirling Blade
		-- Heavin the Breaker
		332708, -- Ground Smash
		-- Harugia the Bloodthirsty / Advent Nevermore
		{333861, "SAY"}, -- Ricocheting Blade
		-- Harugia the Bloodthirsty
		334023, -- Bloodthirsty Charge
		-- Ancient Captain
		330562, -- Demoralizing Shout
		-- Advent Nevermore
		333827, -- Seismic Stomp
		331275, -- Unbreakable Guard
		-- Rek the Hardened
		{333845, "TANK_HEALER"}, -- Unbalancing Blow
		-- Portal Guardian
		330716, -- Soulstorm
		{330725, "DISPEL"}, -- Shadow Vulnerability
		-- Maniacal Soulbinder
		330868, -- Necrotic Bolt Volley
		{333708, "DISPEL"}, -- Soul Corruption
		-- Bone Magus
		342675, -- Bone Spear
		-- Nefarious Darkspeaker
		333294, -- Death Winds
		-- Soulforged Bonereaver
		331223, -- Bonestorm
		331237, -- Bone Spikes
	}, {
		[333241] = L.raging_bloodhorn,
		[319290] = L.diseased_horror,
		[341969] = L.blighted_sludge_spewer,
		[330586] = L.putrid_butcher,
		[330614] = L.rancid_gasbag,
		[342139] = L.dokigg_the_brutalizer_harugia_the_bloodthirsty,
		[342125] = L.dokigg_the_brutalizer,
		[342135] = L.nekthara_the_mangler_heavin_the_breaker,
		[317605] = L.nekthara_the_mangler_rek_the_hardened,
		[337037] = L.nekthara_the_mangler,
		[332708] = L.heavin_the_breaker,
		[333861] = L.harugia_the_bloodthirsty_advent_nevermore,
		[334023] = L.harugia_the_bloodthirsty,
		[330562] = L.ancient_captain,
		[333827] = L.advent_nevermore,
		[333845] = L.rek_the_hardened,
		[330716] = L.portal_guardian,
		[330868] = L.maniacal_soulbinder,
		[342675] = L.bone_magus,
		[333294] = L.nefarious_darkspeaker,
		[331223] = L.soulforged_bonereaver
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Log("SPELL_AURA_APPLIED", "RagingTantrumApplied", 333241)
	self:Log("SPELL_CAST_START", "MeatShield", 341977)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DecayingBlightApplied", 330700)
	self:Log("SPELL_CAST_START", "WitheringDischarge", 341969)
	self:Log("SPELL_AURA_APPLIED", "WitheringBlightApplied", 341949)
	self:Log("SPELL_AURA_APPLIED_DOSE", "WitheringBlightApplied", 341949)
	self:Log("SPELL_CAST_START", "DevourFlesh", 330586)
	self:Log("SPELL_CAST_START", "Chop", 332836)
	self:Log("SPELL_CAST_START", "VileEruption", 330614)
	self:Log("SPELL_CAST_START", "BattleTrance", 342139)
	self:Log("SPELL_AURA_APPLIED", "BattleTranceApplied", 342139)
	self:Log("SPELL_CAST_START", "BrutalLeap", 342125)
	self:Log("SPELL_CAST_START", "InterruptingRoar", 342135)
	self:Log("SPELL_CAST_START", "Whirlwind", 317605)
	self:Log("SPELL_DAMAGE", "WhirlingBladeDamage", 337037)
	self:Log("SPELL_CAST_START", "GroundSmash", 332708)
	self:Log("SPELL_CAST_START", "RicochetingBlade", 333861)
	self:Log("SPELL_CAST_START", "BloodthirstyCharge", 334023)
	self:Log("SPELL_CAST_START", "DemoralizingShout", 330562)
	self:Log("SPELL_CAST_START", "SeismicStomp", 333827)
	self:Log("SPELL_CAST_START", "UnbreakableGuard", 331275)
	self:Log("SPELL_CAST_START", "UnbalancingBlow", 333845)
	self:Log("SPELL_CAST_START", "Soulstorm", 330716)
	self:Log("SPELL_AURA_APPLIED", "ShadowVulnerabilityApplied", 330725)
	self:Log("SPELL_CAST_START", "NecroticBoltVolley", 330868)
	self:Log("SPELL_AURA_APPLIED", "SoulCorruptionApplied", 333708)
	self:Log("SPELL_CAST_START", "BoneSpear", 342675)
	self:Log("SPELL_CAST_START", "Bonestorm", 331223)
	self:Log("SPELL_DAMAGE", "BonestormDamage", 331224)
	self:Log("SPELL_CAST_START", "BoneSpikes", 331237)
	self:Log("SPELL_CAST_START", "DeathWinds", 333294)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup
function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg == L.mordretha_warmup_trigger then
		-- Mordretha Warmup
		local mordrethaModule = BigWigs:GetBossModule("Mordretha, the Endless Empress", true)
		if mordrethaModule then
			mordrethaModule:Enable()
			mordrethaModule:Warmup()
		end
	end
end

-- Raging Bloodhorn
function mod:RagingTantrumApplied(args)
	if self:Dispeller("enrage", true, args.spellId) or self:Healer() then
		self:Message(args.spellId, "orange", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Diseased Horror
function mod:MeatShield(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(319290, "red", CL.casting:format(args.spellName))
	self:PlaySound(319290, "alert")
end
do
	local prev = 0
	function mod:DecayingBlightApplied(args)
		if not self:Player(args.destFlags) then -- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
			return
		end
		if self:Dispeller("disease", nil, args.spellId) then
			if args.amount > 3 then
				local t = args.time
				if t - prev > 3 then
					prev = t
					self:StackMessageOld(args.spellId, args.destName, args.amount, "purple")
					self:PlaySound(args.spellId, "alert", nil, args.destName)
				end
			end
		end
	end
end

-- Blighted Sludge-Spewer
function mod:WitheringDischarge(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end
do
	local playerList = mod:NewTargetList()
	function mod:WitheringBlightApplied(args)
		if not self:Player(args.destFlags) then -- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
			return
		end
		if self:Dispeller("disease", nil, args.spellId) then
			playerList[#playerList+1] = args.destName
			self:PlaySound(args.spellId, "alert", nil, playerList)
			self:TargetsMessageOld(args.spellId, "yellow", playerList, 5)
		end
	end
end

-- Putrid Butcher
function mod:DevourFlesh(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(332836, "red", name)
			self:PlaySound(332836, "alert", nil, name)
		end
	end
	function mod:Chop(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		if not self:Tank() then
			self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		end
	end
end

-- Rancid Gasbag
function mod:VileEruption(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Dokigg the Brutalizer / Harugia the Bloodthirsty
function mod:BattleTrance(args)
	local canInterrupt, interruptReady = self:Interrupter()
	local enrageDispeller = self:Dispeller("enrage", true)

	-- this can be interrupted or you can let the cast go through and dispel the enrage
	if canInterrupt or enrageDispeller then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		if interruptReady then
			self:PlaySound(args.spellId, "warning")
		elseif enrageDispeller then
			self:PlaySound(args.spellId, "alert")
		end
	end
end
function mod:BattleTranceApplied(args)
	if self:Dispeller("enrage", true) or self:Tank() then
		self:Message(args.spellId, "orange", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Dokigg the Brutalizer
function mod:BrutalLeap(args)
	-- target detection not possible with this spell
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Nekthara the Mangler / Heavin the Breaker
function mod:InterruptingRoar(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Nekthara the Mangler / Rek the Hardened
function mod:Whirlwind(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Nekthara the Mangler
do
	local prev = 0
	function mod:WhirlingBladeDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Heavin the Breaker
function mod:GroundSmash(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Harugia the Bloodthirsty / Advent Nevermore
do
	local function printTarget(self, name, guid)
		self:TargetMessage(333861, "red", name)
		if self:Me(guid) then
			self:Say(333861, nil, nil, "Ricocheting Blade")
			self:PlaySound(333861, "warning", nil, name)
		else
			self:PlaySound(333861, "alert", nil, name)
		end
	end
	function mod:RicochetingBlade(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
			self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		end
	end
end

-- Harugia the Bloodthirsty
function mod:BloodthirstyCharge(args)
	-- target detection not possible with this spell
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Ancient Captain
function mod:DemoralizingShout(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	local canInterrupt, interruptReady = self:Interrupter()

	if canInterrupt then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		if interruptReady then
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Advent Nevermore
function mod:SeismicStomp(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end
function mod:UnbreakableGuard(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Rek the Hardened
function mod:UnbalancingBlow(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) and UnitCanAttack("player", unit) then
		self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Portal Guardian
function mod:Soulstorm(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end
function mod:ShadowVulnerabilityApplied(args)
	if self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Maniacal Soulbinder
function mod:NecroticBoltVolley(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))

	-- ideally this should be interrupted, but it can also be stunned/etc to delay this cast for 2.75 seconds + stun duration
	local _, interruptReady = self:Interrupter()
	self:PlaySound(args.spellId, interruptReady and "warning" or "alert")
end
function mod:SoulCorruptionApplied(args)
	if not self:Player(args.destFlags) then -- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
		return
	end
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Bone Magus
function mod:BoneSpear(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Nefarious Darkspeaker
function mod:DeathWinds(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Soulforged Bonereaver
function mod:Bonestorm(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end
function mod:BonestormDamage(args)
	if not self:Tank() and self:Me(args.destGUID) then
		self:PersonalMessage(331223, "underyou")
		self:PlaySound(331223, "underyou")
	end
end
function mod:BoneSpikes(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end
