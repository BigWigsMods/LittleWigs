if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Avanoxx", 2660, 2583)
if not mod then return end
mod:RegisterEnableMob(213179) -- Avanoxx
mod:SetEncounterID(2926)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local voraciousBiteCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{438471, "TANK_HEALER"}, -- Voracious Bite
		438476, -- Alerting Shrill
		438473, -- Gossamer Onslaught
		-- Mythic
		446794, -- Insatiable
	}, {
		[446794] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VoraciousBite", 438471)
	self:Log("SPELL_CAST_START", "AlertingShrill", 438476)
	self:Log("SPELL_CAST_START", "GossamerOnslaught", 438473)
	self:Log("SPELL_AURA_APPLIED", "InsatiableApplied", 446794)
	self:Log("SPELL_AURA_APPLIED_DOSE", "InsatiableApplied", 446794)
end

function mod:OnEngage()
	voraciousBiteCount = 1
	self:CDBar(438471, 3.3) -- Voracious Bite
	self:CDBar(438476, 10.6) -- Alerting Shrill
	self:CDBar(438473, 30.1) -- Gossamer Onslaught
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VoraciousBite(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	voraciousBiteCount = voraciousBiteCount + 1
	if voraciousBiteCount % 2 == 0 then
		self:CDBar(args.spellId, 14.5)
	else
		self:CDBar(args.spellId, 24.3)
	end
end

function mod:AlertingShrill(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 38.8)
end

function mod:GossamerOnslaught(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 40.0)
end

do
	local prev = 0
	function mod:InsatiableApplied(args)
		local stacks = args.amount or 1
		self:Message(args.spellId, "orange", CL.stack:format(stacks, args.spellName, CL.boss))
		if stacks > 1 then
			self:StopBar(CL.stack:format(stacks - 1, args.spellName, CL.boss))
		end
		self:Bar(args.spellId, 12, CL.stack:format(stacks, args.spellName, CL.boss))
		-- throttle the sound, if your group is failing the boss can eat several at once
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
