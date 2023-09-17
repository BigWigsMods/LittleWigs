--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shade of Xavius", 1466, 1657)
if not mod then return end
mod:RegisterEnableMob(99192)
mod:SetEncounterID(1839)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{200182, "TANK_HEALER"}, -- Festering Rip
		200238, -- Feed on the Weak
		200185, -- Nightmare Bolt
		{200243, "ICON", "SAY"}, -- Waking Nightmare
		{200289, "ICON", "SAY"}, -- Growing Paranoia
		200050, -- Apocalyptic Nightmare
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "FesteringRipApplied", 200182)
	self:Log("SPELL_CAST_START", "GrowingParanoia", 200289)
	self:Log("SPELL_AURA_APPLIED", "GrowingParanoiaApplied", 200289)
	self:Log("SPELL_AURA_REMOVED", "GrowingParanoiaRemoved", 200289)
	self:Log("SPELL_CAST_START", "NightmareBolt", 212834, 200185) -- Normal, Heroic+
	self:Log("SPELL_AURA_APPLIED", "WakingNightmareApplied", 200243)
	self:Log("SPELL_AURA_REMOVED", "WakingNightmareRemoved", 200243)
	self:Log("SPELL_AURA_APPLIED", "FeedOnTheWeakApplied", 200238)
	self:Log("SPELL_CAST_START", "ApocalypticNightmare", 200050)
end

function mod:OnEngage()
	self:CDBar(200182, 3.5) -- Festering Rip
	self:CDBar(200185, 6.2) -- Nightmare Bolt
	self:CDBar(200238, 16.9) -- Feed on the Weak
	self:CDBar(200289, 25.5) -- Growing Paranoia
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FesteringRipApplied(args)
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:CDBar(args.spellId, 19.4)
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(200289, "orange", player)
		self:PlaySound(200289, "alarm", nil, player)
		if self:Me(guid) then
			self:Say(200289)
		end
	end

	function mod:GrowingParanoia(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 27.9)
	end

	function mod:GrowingParanoiaApplied(args)
		self:PrimaryIcon(args.spellId, args.destName)
	end

	function mod:GrowingParanoiaRemoved(args)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:FeedOnTheWeakApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:CDBar(args.spellId, 30.3)
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(200185, "yellow", player)
		self:PlaySound(200185, "info", nil, player)
	end

	function mod:NightmareBolt(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(200185, 27.5)
	end
end

function mod:WakingNightmareApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
	self:SecondaryIcon(args.spellId, args.destName)
end

function mod:WakingNightmareRemoved(args)
	self:SecondaryIcon(args.spellId)
end

function mod:ApocalypticNightmare(args)
	self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "long")
end
