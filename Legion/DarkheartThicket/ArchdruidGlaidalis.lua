--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archdruid Glaidalis", 1466, 1654)
if not mod then return end
mod:RegisterEnableMob(96512)
mod:SetEncounterID(1836)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198379, -- Primal Rampage
		198408, -- Nightfall
		{198477, "SAY", "ME_ONLY"}, -- Fixate
		196376, -- Grievous Tear
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PrimalRampage", 198379)
	self:Log("SPELL_CAST_SUCCESS", "Nightfall", 212464)
	self:Log("SPELL_AURA_APPLIED", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_DAMAGE", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_MISSED", "NightfallDamage", 198408)
	self:Log("SPELL_AURA_APPLIED", "FixateApplied", 198477)
	self:Log("SPELL_AURA_APPLIED", "GrievousTearApplied", 196376)
end

function mod:OnEngage()
	self:CDBar(196376, 5.0) -- Grievous Tear
	self:CDBar(198379, 12.4) -- Primal Rampage
	self:CDBar(198408, 26.8) -- Nightfall
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PrimalRampage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 29.2) -- pull:12.7, 30.3 / m pull:12.6, 31.6, 29.9, 27.9
end

function mod:Nightfall(args)
	self:Message(198408, "yellow")
	self:PlaySound(198408, "info")
	self:CDBar(198408, 21.9) -- pull:26.8, 21.9, 30.4, 31.6
	-- TODO mark add? no summon event
end

do
	local prev = 0
	function mod:NightfallDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", nil, args.destName)
			end
		end
	end
end

function mod:GrievousTearApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:CDBar(args.spellId, 13.3) -- pull:5.7, 14.5, 13.3 / m pull:6.8, 15.5, 16.1, 15.3, 12.5, 14.3
end

function mod:FixateApplied(args)
	if self:MobId(args.sourceGUID) == 102962 then -- Nightmare Abomination (boss version)
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
		end
	end
end
