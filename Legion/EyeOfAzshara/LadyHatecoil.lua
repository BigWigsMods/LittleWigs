--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lady Hatecoil", 1456, 1490)
if not mod then return end
mod:RegisterEnableMob(91789)
mod:SetEncounterID(1811)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning"
	L.custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r."

	L.water_safe = "%s (water is safe)"
	L.land_safe = "%s (land is safe)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		193597, -- Static Nova
		193611, -- Focused Lightning
		"custom_on_show_helper_messages",
		193698, -- Curse of the Witch
		193682, -- Beckon Storm
		196610, -- Monsoon
	}, {
		[196610] = "heroic",
	}, {
		[193682] = CL.adds, -- Beckon Storm (Adds)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "StaticNova", 193597)
	self:Log("SPELL_CAST_START", "FocusedLightning", 193611)
	self:Log("SPELL_AURA_APPLIED", "CurseOfTheWitchApplied", 193698)
	self:Log("SPELL_AURA_REMOVED", "CurseOfTheWitchRemoved", 193698)
	self:Log("SPELL_CAST_SUCCESS", "BeckonStorm", 193682)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:CDBar(193597, 10) -- Static Nova
	self:CDBar(193611, 25) -- Focused Lightning
	self:CDBar(193682, 21, CL.adds) -- Beckon Storm
	if not self:Normal() then
		self:CDBar(196610, 31) -- Monsoon
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StaticNova(args)
	self:Message(args.spellId, "orange", self:GetOption("custom_on_show_helper_messages") and L.land_safe:format(args.spellName))
	self:CDBar(args.spellId, 34) -- pull:10.8, 35.2, 34.0 / m pull:10.8, 35.2, 36.4, 37.6, 34.0
	self:PlaySound(args.spellId, "warning")
end

function mod:FocusedLightning(args)
	self:Message(args.spellId, "yellow", self:GetOption("custom_on_show_helper_messages") and L.water_safe:format(args.spellName))
	self:CDBar(args.spellId, 35) -- pull:25.4, 36.4, 35.2 / m pull:25.3, 36.4, 36.4, 37.6
	self:PlaySound(args.spellId, "alert")
end

function mod:CurseOfTheWitchApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		local tbl = self:GetPlayerAura(args.spellId) -- Random lengths
		if tbl and tbl.duration then
			self:TargetBar(args.spellId, tbl.duration, args.destName)
		end
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:CurseOfTheWitchRemoved(args)
	if self:Me(args.destGUID) then
		self:PesronalMessage(args.spellId, "removed")
		self:StopBar(args.spellName, args.destName)
	end
end

function mod:BeckonStorm()
	self:Message(193682, "red", CL.spawned:format(CL.adds))
	self:CDBar(193682, 47, CL.adds) -- pull:21.3, 47.4 / m pull:21.3, 49.8, 47.4
	self:PlaySound(193682, "info")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	-- Starts by using 196629 then randomly swaps to using 196634
	if spellId == 196634 or spellId == 196629 then -- Monsoon
		self:Message(196610, "yellow")
		self:CDBar(196610, 20)
	end
end
