
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Assault on Violet Hold Trash", 1066)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	102302, -- Portal Keeper
	102335, -- Portal Guardian
	102336, -- Portal Keeper
	102337, -- Portal Guardian
	102398 -- Blazing Infernal
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.keeper = "Portal Keeper"
	L.guardian = "Portal Guardian"
	L.infernal = "Blazing Infernal"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		204901, -- Carrion Swarm
		204876, -- Fel Destruction
		204140, -- Shield of Eyes
		204608, -- Fel Prison
		205088, -- Blazing Hellfire
	}, {
		[204901] = L.keeper,
		[204140] = L.guardian,
		[205088] = L.infernal,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "Casts", 204901) -- Carrion Swarm
	self:Log("SPELL_AURA_APPLIED", "Casts", 204876) -- Fel Destruction
	self:Log("SPELL_CAST_SUCCESS", "Casts", 205088, 204140) -- Blazing Hellfire, Shield of Eyes
	self:Log("SPELL_AURA_APPLIED", "FelPrison", 204608)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Casts(args)
	self:Message(args.spellId, "Important", "Alert")
end

function mod:FelPrison(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm", nil, nil, true)
end
