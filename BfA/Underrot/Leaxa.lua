--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Elder Leaxa", 1841, 2157)
if not mod then return end
mod:RegisterEnableMob(131318) -- Elder Leaxa
mod:SetEncounterID(2111)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local bloodMirrorCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260879, -- Blood Bolt
		260894, -- Creeping Rot
		264603, -- Blood Mirror
		264757, -- Sanguine Feast
	}, {
		[260879] = "general",
		[264757] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BloodBolt", 260879)
	self:Log("SPELL_CAST_START", "CreepingRot", 260894)
	self:Log("SPELL_CAST_START", "BloodMirror", 264603)

	-- Heroic+
	self:Log("SPELL_CAST_START", "SanguineFeast", 264757)
end

function mod:OnEngage()
	bloodMirrorCount = 1
	if not self:Normal() then
		self:CDBar(264757, 6.2) -- Sanguine Feast
	end
	self:CDBar(260894, 12.2) -- Creeping Rot
	self:CDBar(264603, 15.5, CL.count:format(self:SpellName(264603), bloodMirrorCount)) -- Blood Mirror (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:BloodBolt(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			local _, interruptReady = self:Interrupter()
			if interruptReady then
				self:PlaySound(args.spellId, "alert", "interrupt")
			end
		end
	end
end

do
	local prev = 0
	function mod:CreepingRot(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm", "watchstep")
		end
		if self:MobId(args.sourceGUID) == 131318 then -- Elder Leaxa, Effigies cast this too
			self:CDBar(args.spellId, 15.4)
		end
	end
end

function mod:BloodMirror(args)
	local bloodMirrorMessage = CL.count:format(args.spellName, bloodMirrorCount)
	self:StopBar(bloodMirrorMessage)
	self:Message(args.spellId, "cyan", bloodMirrorMessage)
	self:PlaySound(args.spellId, "long")
	bloodMirrorCount = bloodMirrorCount + 1
	self:CDBar(args.spellId, 47.4, CL.count:format(args.spellName, bloodMirrorCount))
end

function mod:SanguineFeast(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm", "watchstep")
	if self:MobId(args.sourceGUID) == 131318 then -- Elder Leaxa, Effigies cast this too
		self:CDBar(args.spellId, 30.1)
	end
end
