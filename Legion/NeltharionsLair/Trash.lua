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
	113538 -- Mightstone Breaker
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.breaker = "Mightstone Breaker"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		183088 -- Avalanche
	}, {
		[183088] = L.breaker
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "Avalanche", 183088)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Avalanche(args)
	self:Message(args.spellId, "Attention", "Long")
end
