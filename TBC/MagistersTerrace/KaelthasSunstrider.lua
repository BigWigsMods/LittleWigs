
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Kael'thas Sunstrider ", 585, 533) -- Space is intentional to prevent conflict with Kael'thas from Tempest Keep/The Eye
if not mod then return end
mod:RegisterEnableMob(24664)
-- mod.engageId = 1894 - doesn't fire ENCOUNTER_END on a wipe
-- mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	L.warmup_trigger = "Don't look so smug!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		44224, -- Gravity Lapse
		44194, -- Phoenix
		-5167, -- Flame Strike
		-5180, -- Shock Barrier
		36819, -- Pyroblast
	}, {
		[44224] = "general",
		[-5180] = "heroic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")

	self:Log("SPELL_CAST_START", "GravityLapse", 44224)
	self:Log("SPELL_CAST_START", "Pyroblast", 36819)
	self:Log("SPELL_SUMMON", "Phoenix", 44194)
	self:Log("SPELL_SUMMON", "FlameStrike", 44192, 46162)
	self:Log("SPELL_AURA_APPLIED", "ShockBarrier", 46165)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 24664)
end

function mod:OnEngage()
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL") -- if you engage him before killing the trash pack in front of him, he skips roleplaying
	if not self:Normal() then
		self:CDBar(-5180, 60) -- Shock Barrier
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 36.2, CL.active, "achievement_boss_kael'thassunstrider_01")
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 55 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(44224, "Positive", nil, CL.soon:format(self:SpellName(44224)), false) -- Gravity Lapse
	end
end

function mod:GravityLapse(args)
	self:StopBar(-5180) -- Shock Barrier
	self:Bar(args.spellId, 35)
end

function mod:Phoenix(args)
	self:Message(args.spellId, "Urgent", "Info", CL.spawned:format(args.spellName))
end

function mod:FlameStrike(args)
	self:Message(-5167, "Important")
end

function mod:ShockBarrier(args)
	self:Message(-5180, "Attention")
end

function mod:Pyroblast(args)
	self:CastBar(args.spellId, 4)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
end
