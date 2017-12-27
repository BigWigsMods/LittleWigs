--TO DO
--add stages and descriptions
--had only 1 go on last phase to get ID's and timers so could do a rerun to see if last phase works correctly
--could add stage descriptions
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Erdris Thorn", nil, nil, 1710)
if not mod then return end
mod:RegisterEnableMob(118529, -- Lord Erdris Thorn
	118447, -- Jarod Shadowsong
	118492, -- Corrupted Risen Arbalest
	118491, -- Corrupted Risen Mage
	118489 -- Corrupted Risen Soldier
)
mod.otherMenu = 1716 -- Broken Shore Mage Tower

--------------------------------------------------------------------------------
-- Locals
--
local castCollector = {}
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then

	L.warmup_trigger = "Your arrival is well-timed."
	L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up
	L.erdris = "Lord Erdris Thorn"
	L.mage = "Corrupted Risen Mage"
	L.soldier = "Corrupted Risen Soldier"
	L.arbalest = "Corrupted Risen Arbalest"

end
mod.displayName = L.erdris

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		235984, -- Mana Sting
		235833, -- Arcane Blitz
		235823, -- Knife Dance
		236720, -- Frenzied Assault
		237188, -- Ignite Soul
		237191, -- Fel Stomp
	},{
		["warmup"] = "general",
		[235984] = L.arbalest,
		[235833] = L.mage,
		[235823] = L.soldier,
		[237188] = L.erdris
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:Log("SPELL_CAST_START", "ArcaneBlitz", 235833)
	self:Log("SPELL_CAST_START", "KnifeDance", 235823)
	self:Log("SPELL_CAST_SUCCESS", "FrenziedAssault", 236720)
	self:Log("SPELL_CAST_SUCCESS", "IgniteSoul", 237188)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_SAY(event, msg, npcname)
	if msg:find(L.warmup_trigger, nil, true) then -- starting sequence
		self:Bar("warmup", 29, CL.active, "spell_mage_focusingcrystal")
		wipe(castCollector)
	end

	if msg:find(L.warmup_trigger2, nil, true) then
		self:Bar("warmup", 22, CL.active, "spell_mage_focusingcrystal")
	end

end

function mod:UNIT_SPELLCAST_CHANNEL_START(_, _, spellName, _, castGUID, spellId)
	if castCollector[castGUID] then return end
	if spellId == 235984 then -- Mana Sting
		castCollector[castGUID] = true
		self:CDBar(spellId, 14.6)
		self:Message(spellId, "Important", "Alert", CL.casting:format(spellName))
	end
end

function mod:ArcaneBlitz(args)
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
	if unit then
		local _, _, _, amount = UnitBuff(unit, args.spellName)
		if amount and amount > 3  then
			self:Message(args.spellId, "Attention", "Alert", CL.count:format(args.spellName, amount))
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellName, _, castGUID, spellId)
	if castCollector[castGUID] then return end
	if spellId == 237191 then -- Fel Stomp
		castCollector[castGUID] = true
		self:Message(spellId, "Urgent", "Alarm", CL.incoming:format(spellName))
		self:CDBar(spellId, 11)
	end
end

function mod:IgniteSoul(args)
	self:CDBar(args.spellId, 18)
	self:Message(args.spellId, "Important", "Warning", CL.incoming:format(args.spellName))
end

function mod:KnifeDance(args)
	self:CDBar(args.spellId, 23)
	self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
end

function mod:FrenziedAssault(args)
	self:CDBar(args.spellId, 19)
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(args.spellName))
end
