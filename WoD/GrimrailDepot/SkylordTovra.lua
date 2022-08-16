
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skylord Tovra", 1208, 1133)
if not mod then return end
mod:RegisterEnableMob(80005)
mod.engageId = 1736
mod.respawnTime = 5

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rakun = "Rakun"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		161801, -- Thunderous Breath
		162058, -- Spinning Spear
		161588, -- Diffused Energy
		{162066, "SAY", "FLASH"}, -- Freezing Snare
		{163447, "PROXIMITY"}, -- Hunter's Mark
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SpinningSpear", 162058)
	self:Log("SPELL_CAST_START", "FreezingSnare", 162066)
	self:Log("SPELL_CAST_START", "HuntersMark", 163447)
	self:Log("SPELL_AURA_APPLIED", "HuntersMarkApplied", 163447)
	self:Log("SPELL_AURA_REMOVED", "HuntersMarkRemoved", 163447)

	self:Log("SPELL_AURA_APPLIED", "DiffusedEnergy", 161588)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DiffusedEnergy", 161588)

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Thunder")
end

function mod:OnEngage()
	self:Bar(162066, 5.7) -- Freezing Snare
	self:Bar(162058, 14.2) -- Spinning Spear
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Thunder(_, _, _, _, _, target)
	if target == L.rakun then
		self:MessageOld(161801, "red", "long", CL.incoming:format(self:SpellName(161801)))
		self:Bar(161801, 17.3)
	end
end

function mod:SpinningSpear(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 17)
end

function mod:DiffusedEnergy(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(162066)
			self:Flash(162066)
		end
		self:TargetMessage(162066, "orange", player)
		self:PlaySound(162066, "info", nil, player)
	end
	function mod:FreezingSnare(args)
		self:Bar(args.spellId, 17)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
end

do
	local function printTarget(self, player)
		self:TargetMessageOld(163447, player, "orange", "info")
	end
	function mod:HuntersMark(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 20)
	end
	function mod:HuntersMarkApplied(args)
		if self:Me(args.destGUID) then
			self:OpenProximity(args.spellId, 8)
			self:TargetBar(args.spellId, 6, args.destName)
		else
			self:OpenProximity(args.spellId, 8, args.destName)
		end
	end
	function mod:HuntersMarkRemoved(args)
		self:CloseProximity(args.spellId)
	end
end
