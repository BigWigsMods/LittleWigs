--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Pathaleon the Calculator", 554, 565)
if not mod then return end
--mod.otherMenu = "Tempest Keep"
mod:RegisterEnableMob(19220)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.despawn_message = "Nether Wraiths Despawning Soon!"
	L.despawn_trigger = "I prefer the direct"
	L.despawn_trigger2 = "I prefer to be hands"
	L.despawn_done = "Nether Wraiths despawning!"
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
	-- There are four spellId's for this summon, and seeing as how I put a time check in
	-- original code I suspect that he casts each of the four spells once, so we only
	-- need to check for one to be cast, the four Ids are 35285, 35286, 35287, 35288
	self:Log("SPELL_SUMMON", "NetherWraith", 35285)
	self:Log("SPELL_AURA_APPLIED", "Domination", 35280)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 19220)
end

function mod:OnEngage()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("UNIT_HEALTH")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg:find(L.despawn_trigger, nil, true) or msg:find(L.despawn_trigger2, nil, true) then
		self:Message(35285, "Important", nil, L.despawn_done)
	end
end

function mod:UNIT_HEALTH(_, unit)
	if UnitName(unit) ~= self.displayName then return end
	local health = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if health > 23 and health <= 28 then
		self:UnregisterEvent("UNIT_HEALTH")
		self:Message(35285, "Important", nil, L.despawn_message)
	end
end

function mod:NetherWraith(args)
	self:Message(35285, "Important")
end

function mod:Domination(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 10, args.destName) -- Double check time once we know exact spellId
end
