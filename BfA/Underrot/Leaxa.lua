if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

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

local effigyKilled = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260879, -- Blood Bolt
		260894, -- Creeping Rot
		264603, -- Blood Mirror
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BloodBolt", 260879)
	self:Log("SPELL_CAST_START", "CreepingRot", 260894)
	self:Log("SPELL_CAST_START", "BloodMirror", 264603)
	self:Death("EffigyDeath", 134701)
end

function mod:OnEngage()
	effigyKilled = 3 -- Set to 3 as check to see what stage it is
	self:Bar(260894, 12) -- Creeping Rot
	self:Bar(264603, 20) -- Blood Mirror
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:BloodBolt(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			if self:Interrupter() then
				self:PlaySound(args.spellId, "alert", "interrupt")
			end
		end
	end
end

do
	local prev = 0
	function mod:CreepingRot(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm", "watchstep")
			if effigyKilled == 3 then -- Don't show bars during Blood Mirror
				self:Bar(args.spellId, 12) -- XXX Need timers
			end
		end
	end
end

function mod:BloodMirror(args)
	effigyKilled = 0
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long", "intermission")
end

function mod:EffigyDeath(args)
	effigyKilled = effigyKilled + 1
	if effigyKilled == 3 then
		self:Message(264603, "green", nil, CL.over:format(self:SpellName(264603)))
		self:PlaySound(264603, "long", "stage")
	else
		self:Message(264603, "cyan", nil, CL.mob_killed:format(args.destName, effigyKilled, 3))
		self:PlaySound(264603, "info")
	end
end
