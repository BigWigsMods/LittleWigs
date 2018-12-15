
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cordana Felsong", 1493, 1470)
if not mod then return end
mod:RegisterEnableMob(95888)
mod.engageId = 1818

--------------------------------------------------------------------------------
-- Locals
--

local warnedForStealLight = nil
local warnedForCreepingDoom = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kick_combo = "Kick Combo"
	L.kick_combo_desc = "{197251}\n{197250}" -- Knockdown Kick & Turn Kick
	L.kick_combo_icon = 197251

	L.light_dropped = "%s dropped the Light."
	L.light_picked = "%s picked up the Light."

	L.warmup_text = "Cordana Felsong Active"
	L.warmup_trigger = "I have what I was after. But I stayed just so that I could put an end to you... once and for all!"
	L.warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		197333, -- Fel Glaive
		{206567, "FLASH"}, -- Stolen Light
		{197422, "FLASH"}, -- Creeping Doom
		197796, -- Avatar of Vengeance
		"kick_combo",
		204481, -- Elune's Light
		213583, -- Deepening Shadows
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:Log("SPELL_CAST_SUCCESS", "ElunesLight", 204481)
	self:Log("SPELL_CAST_SUCCESS", "FelGlaive", 197333)
	self:Log("SPELL_AURA_APPLIED", "StolenLight", 206567)
	self:Log("SPELL_AURA_REMOVED", "StolenLightRemoved", 206567)
	self:Log("SPELL_CAST_START", "CreepingDoom", 197422, 213685)
	self:Log("SPELL_AURA_REMOVED", "CreepingDoomRemoved", 197422)
	self:Log("SPELL_CAST_START", "KnockdownKick", 197251) -- used for kick_combo
	self:Death("AvatarDeath", 100351)
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	warnedForStealLight = nil
	warnedForCreepingDoom = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 17.8, L.warmup_text, "achievement_dungeon_vaultofthewardens")
	elseif msg == L.warmup_trigger_2 then
		self:UnregisterEvent(event)
		self:Bar("warmup", 5.5, L.warmup_text, "achievement_dungeon_vaultofthewardens")
	end
end

do
	local prev, prevGUID = 0, nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, castGUID, spellId)
		if unit == "boss1" then
			if spellId == 197796 then -- Avatar of Vengeance
				self:Message(spellId, "orange", "Long")
				self:Bar(spellId, 45)
			elseif spellId == 213583 or spellId == 197578 or spellId == 226312 or spellId == 213576 then -- Deepening Shadows
				local t = GetTime()
				if t-prev > 2 then
					prev = t
					self:Message(213583, "yellow", "Alarm")
				end
			end
		elseif spellId == 228210 and castGUID ~= prevGUID then -- Elune's Light picked up
			prevGUID = castGUID
			self:Message(204481, "green", "Long", L.light_picked:format(self:ColorName(self:UnitName(unit))))
		end
	end
end

function mod:ElunesLight(args)
	self:Message(args.spellId, "cyan", "Long", L.light_dropped:format(self:ColorName(args.sourceName)))
end

function mod:FelGlaive(args)
	self:Message(args.spellId, "red", "Alert")
end

function mod:StolenLight(args)
	self:TargetMessage(args.spellId, args.destName, "orange", "Alarm")
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
	self:StopBar(L.kick_combo)
end

function mod:StolenLightRemoved(args)
	self:Message(args.spellId, "cyan", "Info", CL.removed:format(args.spellName))
	self:CDBar("kick_combo", 16, L.kick_combo, L.kick_combo_icon)
end

function mod:CreepingDoom(args)
	self:Message(197422, "red", "Info", CL.incoming:format(args.spellName))
	self:Flash(197422)
	if args.spellId == 197422 then
		self:StopBar(L.kick_combo)
		self:Bar(197422, 35, CL.cast:format(args.spellName))
	end
end

function mod:CreepingDoomRemoved(args)
	self:Message(args.spellId, "cyan", "Info", CL.over:format(args.spellName))
	self:CDBar("kick_combo", 16, L.kick_combo, L.kick_combo_icon)
end

function mod:KnockdownKick()
	self:Message("kick_combo", "yellow", self:Tank() and "Warning", L.kick_combo, L.kick_combo_icon)
	self:CDBar("kick_combo", 16, L.kick_combo, L.kick_combo_icon)
end

function mod:AvatarDeath()
	self:Message(197796, "green", "Long", CL.removed:format(self:SpellName(205004))) -- Vengeance removed
end

function mod:UNIT_HEALTH_FREQUENT(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 80 and not warnedForStealLight then
		warnedForStealLight = true
		self:Message(206567, "yellow", nil, CL.soon:format(self:SpellName(206387))) -- Steal Light soon
	elseif hp < 45 and not warnedForCreepingDoom then
		warnedForCreepingDoom = true
		self:Message(197422, "red", nil, CL.soon:format(self:SpellName(197422))) -- Creeping Doom soon
		self:UnregisterUnitEvent(event, unit)
	end
end
