
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Theater Of Pain Trash", 2293)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	164506, -- Ancient Captain
	174210, -- Blighted Sludge-Spewer
	163086, -- Rancid Gasbag
	160495, -- Maniacal Soulbinder
	170882 -- Bone Magus
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ancient_captain = "Ancient Captain"
	L.blighted_sludge_spewer = "Blighted Sludge-Spewer"
	L.rancid_gasbag = "Rancid Gasbag"
	L.maniacal_soulbinder = "Maniacal Soulbinder"
	L.bone_magus = "Bone Magus"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ancient Captain
		330562, -- Demoralizing Shout
		-- Blighted Sludge-Spewer
		341969, -- Withering Discharge
		-- Rancid Gasbag
		330614, -- Vile Eruption
		-- Maniacal Soulbinder
		330868, -- Necrotic Bolt Volley
		-- Bone Magus
		342675, -- Bone Spear
	}, {
		[330562] = L.ancient_captain,
		[341969] = L.blighted_sludge_spewer,
		[330614] = L.rancid_gasbag,
		[330868] = L.maniacal_soulbinder,
		[342675] = L.bone_magus
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DemoralizingShout", 330562)
	self:Log("SPELL_CAST_START", "WitheringDischarge", 341969)
	self:Log("SPELL_CAST_START", "VileEruption", 330614)
	self:Log("SPELL_CAST_START", "NecroticBoltVolley", 330868)
	self:Log("SPELL_CAST_START", "BoneSpear", 342675)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Ancient Captain
function mod:DemoralizingShout(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
end

-- Blighted Sludge-Spewer
function mod:WitheringDischarge(args)
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
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
end

-- Bone Magus
function mod:BoneSpear(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
