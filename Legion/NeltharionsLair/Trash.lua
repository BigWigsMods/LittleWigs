--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharions Lair Trash", 1065)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	113998, -- Mightstone Breaker
	90997, -- Mightstone Breaker
	92612, -- Mightstone Breaker
	113538, -- Mightstone Breaker
	91000 -- Vileshard Hulk
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.breaker = "Mightstone Breaker"
	L.hulk = "Vileshard Hulk"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Mightstone Breaker ]]--
		183088, -- Avalanche

		--[[ Vileshard Hulk ]]--
		226296 -- Piercing Shards
	}, {
		[183088] = L.breaker,
		[226296] = L.hulk
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "Avalanche", 183088)
	self:Log("SPELL_CAST_START", "PiercingShards", 226296)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Mightstone Breaker
function mod:Avalanche(args)
	self:Message(args.spellId, "Attention", "Long")
end

-- Vileshard Hulk
function mod:PiercingShards(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end
