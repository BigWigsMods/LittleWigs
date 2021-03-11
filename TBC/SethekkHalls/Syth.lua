-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkweaver Syth", 556, 541)
if not mod then return end
mod:RegisterEnableMob(18472)
mod.engageId = 1903
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local elementalsWarnings = 1

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{15659, "SAY", "ICON"}, -- Chain Lightning
		12548, -- Frost Shock
		-5235, -- Summon Elementals
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_CAST_START", "ChainLightning", 15659, 15305) -- normal, heroic
	self:Log("SPELL_CAST_SUCCESS", "ChainLightningSuccess", 15659, 15305)
	self:Log("SPELL_AURA_APPLIED", "FrostShock", 12548, 21401) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "FrostShockRemoved", 12548, 21401)
	self:Log("SPELL_SUMMON", "SummonElementals", 33538) -- 33538 is the spell summoning the Arcane one but he spawns 4 simultaneously
end

function mod:OnEngage()
	elementalsWarnings = 1
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local function announce(self, target, guid)
		if self:Me(guid) then
			self:Say(15659)
		end
		self:TargetMessageOld(15659, target, "yellow")
		self:PrimaryIcon(15659, target)
	end

	function mod:ChainLightning(args)
		self:GetBossTarget(announce, 0.4, args.sourceGUID)
		self:CastBar(15659, 3)
	end

	function mod:ChainLightningSuccess()
		self:PrimaryIcon(15659)
	end
end

function mod:FrostShock(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(12548, args.destName, "orange")
		self:TargetBar(12548, 8, args.destName)
	end
end

function mod:FrostShockRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:SummonElementals()
	self:MessageOld(-5235, "red", nil, CL.spawned:format(CL.adds))
end

do
	local warnAt = { 95, 60, 20 }
	function mod:UNIT_HEALTH(event, unit)
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < warnAt[elementalsWarnings] then
			elementalsWarnings = elementalsWarnings + 1
			self:MessageOld(-5235, "red", nil, CL.soon:format(self:SpellName(-5235))) -- Summon Elementals

			while elementalsWarnings <= #warnAt and hp < warnAt[elementalsWarnings] do
				-- account for high-level characters hitting multiple thresholds
				elementalsWarnings = elementalsWarnings + 1
			end

			if elementalsWarnings > #warnAt then
				self:UnregisterUnitEvent(event, unit)
			end
		end
	end
end
