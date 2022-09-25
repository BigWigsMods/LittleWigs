--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharions Lair Trash", 1458)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	113998, -- Mightstone Breaker
	90997, -- Mightstone Breaker
	92612, -- Mightstone Breaker
	113538, -- Mightstone Breaker
	91000, -- Vileshard Hulk
	91006, -- Rockback Gnasher
	102232 -- Rockbound Trapper
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.breaker = "Mightstone Breaker"
	L.hulk = "Vileshard Hulk"
	L.gnasher = "Rockback Gnasher"
	L.trapper = "Rockbound Trapper"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Mightstone Breaker ]]--
		183088, -- Avalanche

		--[[ Vileshard Hulk ]]--
		226296, -- Piercing Shards

		--[[ Rockback Gnasher ]]--
		202181, -- Stone Gaze

		--[[ Rockbound Trapper ]]--
		193585, -- Bound
	}, {
		[183088] = L.breaker,
		[226296] = L.hulk,
		[202181] = L.gnasher,
		[193585] = L.trapper,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "Avalanche", 183088)
	self:Log("SPELL_CAST_START", "PiercingShards", 226296)
	self:Log("SPELL_CAST_START", "StoneGaze", 202181)
	self:Log("SPELL_CAST_START", "Bound", 193585)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Mightstone Breaker
function mod:Avalanche(args)
	self:MessageOld(args.spellId, "yellow", "long")
end

-- Vileshard Hulk
function mod:PiercingShards(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

-- Rockback Gnasher
function mod:StoneGaze(args)
	self:MessageOld(args.spellId, "red", "alarm", CL.casting:format(args.spellName))
end

-- Rockbound Trapper
function mod:Bound(args)
	self:MessageOld(args.spellId, "red", "alarm", CL.casting:format(args.spellName))
end
