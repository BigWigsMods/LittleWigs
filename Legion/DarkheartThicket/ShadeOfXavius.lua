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
		{200182, "DISPEL"}, -- Festering Rip
		200238, -- Feed on the Weak
		200185, -- Nightmare Bolt
		{200243, "ICON", "SAY"}, -- Waking Nightmare
		{200289, "ICON", "SAY"}, -- Growing Paranoia
		200050, -- Apocalyptic Nightmare
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FesteringRip", 200182)
	self:Log("SPELL_AURA_APPLIED", "FesteringRipApplied", 200182)
	self:Log("SPELL_CAST_START", "GrowingParanoia", 200289)
	self:Log("SPELL_AURA_APPLIED", "GrowingParanoiaApplied", 200289)
	self:Log("SPELL_AURA_REMOVED", "GrowingParanoiaRemoved", 200289)
	self:Log("SPELL_CAST_START", "NightmareBolt", 212834, 200185) -- Normal, Heroic+
	self:Log("SPELL_AURA_APPLIED", "WakingNightmareApplied", 200243)
	self:Log("SPELL_AURA_REMOVED", "WakingNightmareRemoved", 200243)
	self:Log("SPELL_CAST_SUCCESS", "FeedOnTheWeak", 200238)
	self:Log("SPELL_AURA_APPLIED", "FeedOnTheWeakApplied", 200238)
	self:Log("SPELL_CAST_START", "ApocalypticNightmare", 200050)
end

function mod:OnEngage()
	self:CDBar(200182, 3.2) -- Festering Rip
	if not self:Solo() then
		self:CDBar(200185, 6.2) -- Nightmare Bolt
	end
	self:CDBar(200238, 15.4) -- Feed on the Weak
	self:CDBar(200289, 22.7) -- Growing Paranoia
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FesteringRip(args)
	self:CDBar(args.spellId, 19.4)
end

function mod:FesteringRipApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(200289, "orange", player)
		self:PlaySound(200289, "alarm", nil, player)
		if self:Me(guid) then
			self:Say(200289, nil, nil, "Growing Paranoia")
		end
	end

	function mod:GrowingParanoia(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 22.7)
	end
end

function mod:GrowingParanoiaApplied(args)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:GrowingParanoiaRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:FeedOnTheWeak(args)
	self:CDBar(args.spellId, 19.4)
end

function mod:FeedOnTheWeakApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(200185, "yellow", player)
		self:PlaySound(200185, "info", nil, player)
	end

	function mod:NightmareBolt(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(200185, 22.7)
	end
end

function mod:WakingNightmareApplied(args)
	if self:Me(args.destGUID) then
		self:Yell(args.spellId, nil, nil, "Waking Nightmare")
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
