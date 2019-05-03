if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trixie & Naeno", 2097, 2360)
if not mod then return end
mod:RegisterEnableMob(150712, 153755) -- Trixie Tazer, Naeno Megacrash
--mod.engageId = XXX

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		299241, -- Turbo Boost
		298718, -- Mega Taze
		298946, -- Roadkill
		298940, -- Bolt Buster
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TurboBoostApplied", 299241)
	self:Log("SPELL_CAST_START", "MegaTaze", 298718)
	self:Log("SPELL_CAST_START", "Roadkill", 298946)
	self:Log("SPELL_CAST_START", "BoltBuster", 298940)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TurboBoostApplied(args)
	self:TargetMessage2(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "info")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(298718, "orange", name)
		self:PlaySound(298718, "alarm", nil, name)
	end

	function mod:MegaTaze(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CastBar(args.spellId, 5)
	end
end

function mod:Roadkill(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:BoltBuster(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end
