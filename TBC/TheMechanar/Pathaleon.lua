--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Pathaleon the Calculator", 554, 565)
if not mod then return end
mod:RegisterEnableMob(19220)
-- mod.engageId = 1931 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.despawn_message = "Nether Wraiths Despawning Soon"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		35285, -- Summon Nether Wraith
		35280, -- Domination
	}
end

function mod:OnBossEnable()
	-- no boss frames, so doing this manually
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("ENCOUNTER_END")

	-- There are four spellId's for this summon, and seeing as how I put a time check in
	-- original code I suspect that he casts each of the four spells once, so we only
	-- need to check for one to be cast, the four Ids are 35285, 35286, 35287, 35288
	self:Log("SPELL_SUMMON", "NetherWraith", 35285)
	self:Log("SPELL_AURA_APPLIED", "Domination", 35280)
	self:Log("SPELL_AURA_REMOVED", "DominationRemoved", 35280)
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "target", "focus")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, engageId)
	if engageId == 1931 then
		self:Engage()
	end
end

function mod:ENCOUNTER_END(_, engageId, _, _, _, status)
	if engageId == 1931 then
		if status == 0 then
			self:Wipe()
		else
			self:Win()
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 19220 then return end
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 28 then
		self:UnregisterUnitEvent(event, "target", "focus")
		self:MessageOld(35285, "red", nil, L.despawn_message)
	end
end

function mod:NetherWraith()
	self:MessageOld(35285, "red")
end

function mod:Domination(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:DominationRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
