-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Grandmaster Vorpil", 724, 546)
if not mod then return end
--mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18732)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.teleport = "Teleport"
	L.teleport_desc = "Warning for when Grandmaster Vorpil will Teleport."
	L.teleport_message = "Teleport!"
	L.teleport_warning = "Teleport in ~5sec!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"teleport",
		38791, -- Banish
	},{
		["teleport"] = "general",
		[38791] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Teleport", 33563)
	self:Log("SPELL_AURA_APPLIED", "Banish", 38791)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 18732)
end

function mod:OnEngage()
	self:CDBar("teleport", 40, L.teleport, args.spellId)
	self:DelayedMessage("teleport", 35, "Attention", L.teleport_warning, args.spellId)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Teleport(args)
	self:Message("teleport", "Urgent", nil, L.teleport_message, args.spellId)
	self:CDBar("teleport", 37, L.teleport, args.spellId)
	self:DelayedMessage("teleport", 32, "Attention", L.teleport_warning, args.spellId)
end

function mod:Banish(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 8, args.destName)
end
