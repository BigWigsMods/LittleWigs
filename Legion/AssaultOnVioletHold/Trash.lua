
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Assault on Violet Hold Trash", 1544)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	102278, -- Lieutenant Sinclari
	102302, -- Portal Keeper
	102335, -- Portal Guardian
	102336, -- Portal Keeper
	102337, -- Portal Guardian
	102398 -- Blazing Infernal
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects Lieutenant Sinclaris gossip option to start the Assault on Violet Hold."
	L.custom_on_autotalk_icon = "ui_chat"
	L.keeper = "Portal Keeper"
	L.guardian = "Portal Guardian"
	L.infernal = "Blazing Infernal"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk", -- Lieutenant Sinclari
		204901, -- Carrion Swarm
		204876, -- Fel Destruction
		204140, -- Shield of Eyes
		204608, -- Fel Prison
		205088, -- Blazing Hellfire
	}, {
		["custom_on_autotalk"] = "general",
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

	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Casts(args)
	self:MessageOld(args.spellId, "red", "alert")
end

function mod:FelPrison(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, true)
end

-- Lieutenant Sinclari
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 102278 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1)
		end
	end
end
