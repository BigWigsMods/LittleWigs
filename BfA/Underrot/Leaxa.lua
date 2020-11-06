
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Elder Leaxa", 1841, 2157)
if not mod then return end
mod:RegisterEnableMob(131318)
mod.engageId = 2111
mod.respawnTime = 30

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
	self:Bar(260894, 12) -- Creeping Rot
	self:CDBar(264603, 15.5) -- Blood Mirror
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
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm", "watchstep")
		end
		local mobID = self:MobId(args.sourceGUID)
		if mobID == 131318 then -- Actual Boss
			self:CDBar(args.spellId, 15.8)
		end
	end
end

function mod:BloodMirror(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 47.4)
end

function mod:SanguineFeast(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm", "watchstep")
	self:Bar(args.spellId, 30.5)
end
