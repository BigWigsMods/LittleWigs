if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kyrioss", 2648, 2566)
if not mod then return end
mod:RegisterEnableMob(209230) -- Kyrioss
mod:SetEncounterID(2816)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{424148, "SAY"}, -- Chain Lightning
		{420739, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Unstable Charge
		444123, -- Lightning Torrent
		419870, -- Lightning Dash
		-- TODO Stormheart? (Mythic-only)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChainLightning", 424148)
	self:Log("SPELL_CAST_START", "UnstableCharge", 420739)
	self:Log("SPELL_AURA_APPLIED", "UnstableChargeApplied", 420739)
	self:Log("SPELL_AURA_REMOVED", "UnstableChargeRemoved", 420739)
	self:Log("SPELL_CAST_START", "LightningTorrent", 444123)
	self:Log("SPELL_CAST_START", "LightningDash", 419870)
end

function mod:OnEngage()
	self:CDBar(419870, 2.2) -- Lightning Dash
	self:CDBar(424148, 5.8) -- Chain Lightning
	self:CDBar(420739, 15.6) -- Unstable Charge
	self:CDBar(444123, 32.5) -- Lightning Torrent
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage(424148, "red", name)
		self:PlaySound(424148, "alert", nil, name)
		if self:Me(guid) then
			self:Say(424148, nil, nil, "Chain Lightning")
		end
	end

	function mod:ChainLightning(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:CDBar(args.spellId, 14.5)
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(420739, "yellow", name)
		if self:Me(guid) then
			self:PlaySound(420739, "warning", nil, name)
			self:Say(420739, nil, nil, "Unstable Charge")
		else
			self:PlaySound(420739, "info", nil, name)
		end
	end

	function mod:UnstableCharge(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:CDBar(args.spellId, 31.5)
	end
end

function mod:UnstableChargeApplied(args)
	if self:Me(args.destGUID) then
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:UnstableChargeRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:LightningTorrent(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 30.2)
end

function mod:LightningDash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 32.7)
end
