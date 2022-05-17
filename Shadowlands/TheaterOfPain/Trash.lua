
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Theater Of Pain Trash", 2293)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	167538, -- Dokigg the Brutalizer
	162744, -- Nekthara the Mangler
	167532, -- Heavin the Breaker
	167536, -- Harugia the Bloodthirsty
	164506, -- Ancient Captain
	167533, -- Advent Nevermore
	167534, -- Rek the Hardened
	174210, -- Blighted Sludge-Spewer
	163086, -- Rancid Gasbag
	160495, -- Maniacal Soulbinder
	170882, -- Bone Magus
	169893 -- Nefarious Darkspeaker
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
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
	L.blighted_sludge_spewer = "Blighted Sludge-Spewer"
	L.rancid_gasbag = "Rancid Gasbag"
	L.maniacal_soulbinder = "Maniacal Soulbinder"
	L.bone_magus = "Bone Magus"
	L.nefarious_darkspeaker = "Nefarious Darkspeaker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
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
		333861, -- Ricocheting Blade
		-- Harugia the Bloodthirsty
		334025, -- Bloodthirsty Charge
		-- Ancient Captain
		330562, -- Demoralizing Shout
		-- Advent Nevermore
		333827, -- Seismic Stomp
		331275, -- Unbreakable Guard
		-- Rek the Hardened
		333845, -- Unbalancing Blow TODO tank only
		-- Blighted Sludge-Spewer
		341969, -- Withering Discharge
		-- Rancid Gasbag
		330614, -- Vile Eruption
		-- Maniacal Soulbinder
		330868, -- Necrotic Bolt Volley
		-- Bone Magus
		342675, -- Bone Spear
		-- Nefarious Darkspeaker
		333294, -- Death Winds
	}, {
		[342139] = L.dokigg_the_brutalizer_harugia_the_bloodthirsty,
		[342125] = L.dokigg_the_brutalizer,
		[342135] = L.nekthara_the_mangler_heavin_the_breaker,
		[317605] = L.nekthara_the_mangler_rek_the_hardened,
		[337037] = L.nekthara_the_mangler,
		[332708] = L.heavin_the_breaker,
		[333861] = L.harugia_the_bloodthirsty_advent_nevermore,
		[334025] = L.harugia_the_bloodthirsty,
		[330562] = L.ancient_captain,
		[333827] = L.advent_nevermore,
		[333845] = L.rek_the_hardened,
		[341969] = L.blighted_sludge_spewer,
		[330614] = L.rancid_gasbag,
		[330868] = L.maniacal_soulbinder,
		[342675] = L.bone_magus,
		[333294] = L.nefarious_darkspeaker
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BattleTrance", 342139)
	self:Log("SPELL_AURA_APPLIED", "BattleTranceApplied", 342139)
	self:Log("SPELL_CAST_START", "BrutalLeap", 342125)
	self:Log("SPELL_CAST_START", "InterruptingRoar", 342135)
	self:Log("SPELL_CAST_START", "Whirlwind", 317605)
	self:Log("SPELL_DAMAGE", "WhirlingBladeDamage", 337037)
	self:Log("SPELL_CAST_START", "GroundSmash", 332708)
	self:Log("SPELL_CAST_START", "RicochetingBlade", 333861)
	self:Log("SPELL_CAST_START", "BloodthirstyCharge", 334025)
	self:Log("SPELL_CAST_START", "DemoralizingShout", 330562)
	self:Log("SPELL_CAST_START", "SeismicStomp", 333827)
	self:Log("SPELL_CAST_START", "UnbreakableGuard", 331275)
	self:Log("SPELL_CAST_START", "UnbalancingBlow", 333845)
	self:Log("SPELL_CAST_START", "WitheringDischarge", 341969)
	self:Log("SPELL_CAST_START", "VileEruption", 330614)
	self:Log("SPELL_CAST_START", "NecroticBoltVolley", 330868)
	self:Log("SPELL_CAST_START", "BoneSpear", 342675)
	self:Log("SPELL_CAST_START", "DeathWinds", 333294)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Dokigg the Brutalizer / Harugia the Bloodthirsty
function mod:BattleTrance(args)
	-- TODO higher priority for interrupters only
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end
function mod:BattleTranceApplied(args)
	if self:Dispeller("enrage", true) then
		self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Dokigg the Brutalizer
function mod:BrutalLeap(args)
	-- TODO get target and make higher priority?
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Nekthara the Mangler / Heavin the Breaker
function mod:InterruptingRoar(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Nekthara the Mangler / Rek the Hardened
function mod:Whirlwind(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
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
function mod:RicochetingBlade(args)
	-- TODO get target and make higher priority?
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Harugia the Bloodthirsty
function mod:BloodthirstyCharge(args)
	-- TODO get target and make higher priority?
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Ancient Captain
function mod:DemoralizingShout(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
end

-- Advent Nevermore
function mod:SeismicStomp(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
function mod:UnbreakableGuard(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

-- Rek the Hardened
function mod:UnbalancingBlow(args)
	-- TODO tank scope only
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Blighted Sludge-Spewer
function mod:WitheringDischarge(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Rancid Gasbag
function mod:VileEruption(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Maniacal Soulbinder
function mod:NecroticBoltVolley(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
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
