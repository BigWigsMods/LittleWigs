
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xeri'tac", 1279, 1209)
if not mod then return end
mod:RegisterEnableMob(84550)
mod.engageId = 1752
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Pale One
		-10502,
		169248, -- Consume
		169233, -- Inhale
		-- Spiderlings
		-10492,
		173080, -- Fixate
		"stages",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Consume", 169248)
	self:Log("SPELL_CAST_START", "Inhale", 169233)
	self:Log("SPELL_AURA_APPLIED", "Fixate", 173080)

	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")
	self:Death("SpiderlingDeath", 84552)
end

function mod:OnEngage()
	deaths = 0
	self:Bar(-10502, 20, CL.next_add, "spell_festergutgas")
	self:ScheduleTimer("AddSpawn", 20)
	self:Bar(-10492, 30, 155139, "spell_yorsahj_bloodboil_green") -- 155139 = Spiders
	self:ScheduleTimer("SpidersSpawn", 30)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpiderlingDeath()
	deaths = deaths + 1
	if deaths < 9 then
		self:Message("stages", "cyan", nil, CL.add_killed:format(deaths, 8), false)
	end
end

function mod:SpidersSpawn()
	--self:Message(-10492, "yellow", nil, 155139, false) -- 155139 = Spiders
	self:Bar(-10492, 30, 155139, "spell_yorsahj_bloodboil_green") -- 155139 = Spiders
	self:ScheduleTimer("SpidersSpawn", 30)
end

function mod:Fixate(args)
	if self:Me(args.destGUID) then
		self:Message(173080, "blue", "Alarm", CL.you:format(args.spellName))
	end
end

function mod:AddSpawn()
	self:Message(-10502, "yellow", "Info", CL.add_spawned, false)
	self:Bar(-10502, 30, CL.next_add, "spell_festergutgas")
	self:ScheduleTimer("AddSpawn", 30)
end

function mod:Consume(args)
	self:Message(args.spellId, "orange", "Warning")
	self:Bar(args.spellId, 10)
end

function mod:Inhale(args)
	self:Message(args.spellId, "red", "Info")
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if UnitCanAttack("player", unit) then
		self:Message("stages", "red", "Info", CL.incoming:format(self.displayName), "inv_misc_monsterspidercarapace_01")
	end
end
