
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Kael'thas Sunstrider Magisters' Terrace", 585, 533)
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
		{36819, "CASTBAR"}, -- Pyroblast
	}, {
		[44224] = "general",
		[-5180] = "heroic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	self:Log("SPELL_CAST_START", "GravityLapse", 44224)
	self:Log("SPELL_CAST_START", "Pyroblast", 36819)
	self:Log("SPELL_SUMMON", "Phoenix", 44194)
	self:Log("SPELL_SUMMON", "FlameStrike", 44192, 46162)
	self:Log("SPELL_AURA_APPLIED", "ShockBarrier", 46165)

	if self:Classic() then
		self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
		self:RegisterEvent("UNIT_HEALTH")
	else
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	end
	self:Death("Win", 24664)
end

function mod:OnEngage()
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL") -- if you engage him before killing the trash pack in front of him, he skips roleplaying
	if self:Classic() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	end
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

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 24664 then
		local hp = self:GetHealth(unit)
		if hp < 55 then
			if self:Classic() then
				self:UnregisterEvent(event)
			else
				self:UnregisterUnitEvent(event, unit)
			end
			self:MessageOld(44224, "green", nil, CL.soon:format(self:SpellName(44224)), false) -- Gravity Lapse
		end
	end
end

function mod:GravityLapse(args)
	self:StopBar(-5180) -- Shock Barrier
	self:Bar(args.spellId, 35)
end

function mod:Phoenix(args)
	self:MessageOld(args.spellId, "orange", "info", CL.spawned:format(args.spellName))
end

function mod:FlameStrike()
	self:MessageOld(-5167, "red")
end

function mod:ShockBarrier()
	self:MessageOld(-5180, "yellow")
end

function mod:Pyroblast(args)
	self:CastBar(args.spellId, 4)
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
end
