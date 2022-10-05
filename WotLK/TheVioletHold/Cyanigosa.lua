--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cyanigosa", 608, 632)
if not mod then return end
mod:RegisterEnableMob(31134)
-- mod.engageId = 0 -- no IEEU and ENCOUNTER_* events
-- mod.respawnTime = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{58688, "TANK_HEALER"}, -- Uncontrollable Energy
		58694, -- Arcane Vacuum
		58693, -- Blizzard
		{59374, "DISPEL"}, -- Mana Destruction
	}, {
		[58688] = "normal",
		[59374] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "UncontrollableEnergy", 58688, 59281) -- Normal, Heroic
	self:Log("SPELL_CAST_SUCCESS", "ArcaneVacuum", 58694)
	self:Log("SPELL_AURA_APPLIED", "Blizzard", 58693, 59369) -- Normal, Heroic
	self:Log("SPELL_PERIODIC_DAMAGE", "Blizzard", 58693, 59369)
	self:Log("SPELL_PERIODIC_MISSED", "Blizzard", 58693, 59369)
	self:Log("SPELL_AURA_APPLIED", "ManaDestruction", 59374)
	self:Log("SPELL_AURA_REMOVED", "ManaDestructionRemoved", 59374)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 31134)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:CDBar(58688, 7) -- Uncontrollable Energy
	self:CDBar(58694, 26) -- Arcane Vacuum

	-- if self:Heroic and self:Dispeller("magic", nil, 59374) then
	-- 	self:CDBar(59374, 0) -- Mana Destruction
	-- end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UncontrollableEnergy(args)
	self:Message(58688, "purple", CL.casting:format(args.spellName))
	self:PlaySound(58688, "alert")
	self:CDBar(58688, 20)
end

do
	local prev = 0
	function mod:Blizzard(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t

				self:PersonalMessage(58693)
				self:PlaySound(58693, "alarm")
			end
		end
	end
end

function mod:ArcaneVacuum(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 26.7)
end

function mod:ManaDestruction(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetBar(args.spellId, 8, args.destName)
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
		-- self:CDBar(args.spellId, 0)
	end
end

function mod:ManaDestructionRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
