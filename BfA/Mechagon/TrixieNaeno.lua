--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trixie & Naeno", 2097, 2360)
if not mod then return end
mod:RegisterEnableMob(150712, 153755) -- Trixie Tazer, Naeno Megacrash
mod:SetEncounterID(2312)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		299153, -- Turbo Boost
		{302682, "ME_ONLY_EMPHASIZE"}, -- Mega Taze
		298946, -- Roadkill
		298940, -- Bolt Buster
		298571, -- Burnout
		298898, -- Roll Out
		{298651, "CASTBAR"}, -- Pedal to the Metal
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TurboBoostApplied", 299153)
	self:Log("SPELL_CAST_START", "MegaTaze", 302682)
	self:Log("SPELL_CAST_START", "Roadkill", 298946)
	self:Log("SPELL_CAST_START", "BoltBuster", 298940)
	self:Log("SPELL_CAST_SUCCESS", "Burnout", 298571)
	self:Log("SPELL_CAST_SUCCESS", "RollOut", 298898)
	self:Log("SPELL_CAST_START", "PedalToTheMetal", 298651, 299164) -- First cast, second cast
	self:Death("TrixieDeath", 150712)
	self:Death("NaenoDeath", 153755)
end

function mod:OnEngage()
	self:CDBar(302682, 26.4) -- Mega Taze
	self:Bar(298946, 30) -- Roadkill
	self:Bar(298940, 35.1) -- Bolt Buster
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TurboBoostApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "info")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(302682, "orange", name)
		self:TargetBar(302682, 8, name)
		self:PlaySound(302682, "alarm", nil, name)
	end

	function mod:MegaTaze(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 25.5)
	end
end

function mod:Roadkill(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 52.3)
end

function mod:BoltBuster(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 52.3)
end

function mod:Burnout(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:Bar(298651, 2.9) -- Pedal to the Metal
end

function mod:RollOut(args)
	self:CDBar(args.spellId, 53.5)
	self:Bar(298651, 2) -- Pedal to the Metal
end

function mod:PedalToTheMetal(args)
	self:Message(298651, "red")
	self:PlaySound(298651, "alert")
	self:CastBar(298651, 4.5) -- Pedal to the Metal
end

function mod:TrixieDeath(args)
	self:StopBar(302682) -- Mega Taze
end

function mod:NaenoDeath(args)
	self:StopBar(298946) -- Roadkill
end
