
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Elder Leaxa", 1841, 2157)
if not mod then return end
mod:RegisterEnableMob(131318)
mod.engageId = 2111

--------------------------------------------------------------------------------
-- Locals
--

local effigySpawned = 0
local effigyKilled = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260879, -- Blood Bolt
		260894, -- Creeping Rot
		264603, -- Blood Mirror
		264757, -- Sanguine Feast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BloodBolt", 260879)
	self:Log("SPELL_CAST_START", "CreepingRot", 260894)
	self:Log("SPELL_CAST_START", "BloodMirror", 264603)
	self:Death("EffigyDeath", 134701)

	-- Heroic+
	self:Log("SPELL_CAST_START", "SanguineFeast", 264757)
end

function mod:OnEngage()
	effigySpawned = 0
	effigyKilled = 0
	self:Bar(260894, 12) -- Creeping Rot
	self:Bar(264603, 15.5) -- Blood Mirror
	if not self:Normal() then
		self:Bar(264757, 9) -- Sanguine Feast
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:BloodBolt(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message2(args.spellId, "orange")
			if self:Interrupter() then
				self:PlaySound(args.spellId, "alert", "interrupt")
			end
		end
	end
end

do
	local prev = 0
	function mod:CreepingRot(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message2(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm", "watchstep")
		end
		local mobID = self:MobId(args.sourceGUID)
		if mobID == 131318 then -- Actual Boss
			self:CDBar(args.spellId, 15.8)
		end
	end
end

function mod:BloodMirror(args)
	effigySpawned = self:Normal() and 1 or effigySpawned + 1 -- XXX Always 1 in normal?
	effigyKilled = 0
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "long", "intermission")
end

function mod:EffigyDeath(args)
	effigyKilled = effigyKilled + 1
	if effigyKilled == effigySpawned then
		self:Message2(264603, "green", CL.over:format(self:SpellName(264603)))
		self:PlaySound(264603, "long", "stage")
	else
		self:Message2(264603, "cyan", CL.mob_killed:format(args.destName, effigyKilled, effigySpawned))
		self:PlaySound(264603, "info")
	end
end

function mod:SanguineFeast(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm", "watchstep")
	self:Bar(args.spellId, 30.5)
end
