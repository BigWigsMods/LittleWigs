
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lady Hatecoil", 1046, 1490)
if not mod then return end
mod:RegisterEnableMob(91789)
mod.engageId = 1811

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.blob = "{193682} ({-12139})" -- Beckon Storm (Saltsea Globule)
	L.blob_desc = 193682
	L.blob_icon = 193682
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		193597, -- Static Nova
		193611, -- Focused Lightning
		193698, -- Curse of the Witch
		"blob",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "StaticNova", 193597)
	self:Log("SPELL_CAST_START", "FocusedLightning", 193611)
	self:Log("SPELL_AURA_APPLIED", "CurseOfTheWitch", 193698)
	self:Log("SPELL_AURA_REMOVED", "CurseOfTheWitchRemoved", 193698)
	self:Log("SPELL_CAST_SUCCESS", "BeckonStorm", 193682)
end

function mod:OnEngage()
	self:CDBar(193597, 10) -- Static Nova
	self:CDBar(193611, 25) -- Focused Lightning
	self:CDBar("blob", 21, -12139, L.blob_icon) -- Saltsea Globule
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StaticNova(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 34) -- pull:10.8, 35.2, 34.0
end

function mod:FocusedLightning(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:CDBar(args.spellId, 35) -- pull:25.4, 36.4, 35.2
end

function mod:CurseOfTheWitch(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Alarm")
		local _, _, _, _, _, duration = UnitDebuff("player", args.spellName) -- Random lengths
		self:Bar(args.spellId, duration or 6)
	end
end

function mod:CurseOfTheWitchRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Positive", nil, CL.removed:format(args.spellName))
		self:StopBar(args.spellName)
	end
end

function mod:BeckonStorm(args)
	self:Message("blob", "Positive", "Info", CL.spawned:format(self:SpellName(-12139)), L.blob_icon) -- Saltsea Globule
	self:CDBar("blob", 47, -12139, L.blob_icon) -- Saltsea Globule -- pull:21.3, 47.4
end

