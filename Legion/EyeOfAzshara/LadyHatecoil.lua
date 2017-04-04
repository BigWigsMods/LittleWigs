
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
		196610, -- Monsoon
	}, {
		[196610] = "heroic"
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "StaticNova", 193597)
	self:Log("SPELL_CAST_START", "FocusedLightning", 193611)
	self:Log("SPELL_AURA_APPLIED", "CurseOfTheWitch", 193698)
	self:Log("SPELL_AURA_REMOVED", "CurseOfTheWitchRemoved", 193698)
	self:Log("SPELL_CAST_SUCCESS", "BeckonStorm", 193682)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:CDBar(193597, 10) -- Static Nova
	self:CDBar(193611, 25) -- Focused Lightning
	self:CDBar("blob", 21, -12139, L.blob_icon) -- Saltsea Globule
	if not self:Normal() then
		self:CDBar(196610, 31) -- Monsoon
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StaticNova(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 34) -- pull:10.8, 35.2, 34.0 / m pull:10.8, 35.2, 36.4, 37.6, 34.0
end

function mod:FocusedLightning(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:CDBar(args.spellId, 35) -- pull:25.4, 36.4, 35.2 / m pull:25.3, 36.4, 36.4, 37.6
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
		self:Message(args.spellId, "Personal", nil, CL.removed:format(args.spellName))
		self:StopBar(args.spellName)
	end
end

function mod:BeckonStorm(args)
	self:Message("blob", "Important", "Info", CL.spawned:format(self:SpellName(-12139)), L.blob_icon) -- Saltsea Globule
	self:CDBar("blob", 47, -12139, L.blob_icon) -- Saltsea Globule -- pull:21.3, 47.4 / m pull:21.3, 49.8, 47.4
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	-- Starts by using 196629 then randomly swaps to using 196634 (mythic)
	if spellId == 196634 or spellId == 196629 then -- Monsoon
		self:Message(196610, "Positive")
		self:CDBar(196610, 20)
	end
end
