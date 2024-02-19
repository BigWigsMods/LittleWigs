--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skylord Tovra", 1208, 1133)
if not mod then return end
mod:RegisterEnableMob(80005) -- Skylord Tovra
mod:SetEncounterID(1736)
mod:SetRespawnTime(5)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		161801, -- Thunderous Breath
		162058, -- Spinning Spear
		161588, -- Diffused Energy
		{162066, "SAY", "FLASH"}, -- Freezing Snare
		163447, -- Hunter's Mark
	}, {
		[163447] = CL.heroic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Thunderous Breath
	self:Log("SPELL_AURA_APPLIED", "DiffusedEnergy", 161588)
	self:Log("SPELL_CAST_START", "FreezingSnare", 162066)
	self:Log("SPELL_AURA_APPLIED", "FreezingSnareApplied", 162065)
	self:Log("SPELL_CAST_START", "SpinningSpear", 162058)

	-- Heroic-only mechanic (not present in Mythic, M+, or Timewalking)
	self:Log("SPELL_CAST_START", "HuntersMark", 163447)
	self:Log("SPELL_AURA_APPLIED", "HuntersMarkApplied", 163447)
end

function mod:OnEngage()
	self:Bar(162066, 5.7) -- Freezing Snare
	self:Bar(161801, 7.9) -- Thunderous Breath
	self:Bar(162058, 14.2) -- Spinning Spear
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EncounterEvent(args) -- Thunderous Breath
	self:Message(161801, "red", CL.incoming:format(self:SpellName(161801)))
	self:PlaySound(161801, "long")
	self:Bar(161801, 17.4)
end

function mod:DiffusedEnergy(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

function mod:SpinningSpear(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 17)
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(162066, nil, nil, "Freezing Snare")
			self:Flash(162066)
		end
		self:TargetMessage(162066, "orange", player)
		self:PlaySound(162066, "info", nil, player)
	end

	function mod:FreezingSnare(args)
		self:Bar(args.spellId, 17)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:FreezingSnareApplied(args)
	if self:Player(args.destFlags) and (self:Me(args.destGUID) or self:Dispeller("movement")) then
		self:TargetMessage(162066, "yellow", args.destName)
		self:PlaySound(162066, "alert", nil, args.destName)
	end
end

do
	local function printTarget(self, player)
		self:TargetMessage(163447, "orange", player)
		self:PlaySound(163447, "info", nil, player)
	end

	function mod:HuntersMark(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 20)
	end

	function mod:HuntersMarkApplied(args)
		if self:Me(args.destGUID) then
			self:TargetBar(args.spellId, 6, args.destName)
		end
	end
end
