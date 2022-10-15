if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chrono-Lord Deios", 2451, 2479)
if not mod then return end
mod:RegisterEnableMob(184125) -- Chrono-Lord Deios
mod:SetEncounterID(2559)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		376325, -- Eternity Zone
		376208, -- Rewind Timeflow
		376049, -- Wing Buffet
		{377405, "DISPEL", "SAY"}, -- Time Sink
		375727, -- Sand Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EternityZoneApplied", 376325)
	self:Log("SPELL_CAST_START", "RewindTimeflow", 376208)
	self:Log("SPELL_CAST_SUCCESS", "RewindTimeflowStart", 376208)
	self:Log("SPELL_AURA_REMOVED", "RewindTimeflowOver", 376208)
	self:Log("SPELL_CAST_START", "WingBuffet", 376049)
	self:Log("SPELL_AURA_APPLIED", "TimeSinkApplied", 377405)
	self:Log("SPELL_CAST_START", "SandBreath", 375727)
end

function mod:OnEngage()
	self:CDBar(376049, 6.3) -- Wing Buffet
	self:CDBar(375727, 12.3) -- Sand Breath
	self:Bar(376208, 25.3) -- Rewind Timeflow
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:EternityZoneApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

function mod:RewindTimeflow(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 46.1)
end

function mod:RewindTimeflowStart(args)
	self:CastBar(args.spellId, 12)
end

function mod:RewindTimeflowOver(args)
	self:Message(args.spellId, "yellow", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:WingBuffet(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17)
end

function mod:TimeSinkApplied(args)
	local onMe = self:Me(args.destGUID)
	if self:Dispeller("magic", false, args.spellId) or onMe then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
		if onMe then
			self:Say(args.spellId)
		end
	end
end

function mod:SandBreath(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.8)
end
