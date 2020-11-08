-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nalorakk", 568, 187)
if not mod then return end
mod:RegisterEnableMob(23576)
mod.engageId = 1190
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L.troll_message = "Troll Form"
	L.troll_trigger = "Make way for da Nalorakk!"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		42402, -- Surge
		42398, -- Deafening Roar
	}, {
		[42402] = L.troll_message,
		[42398] = 7090, -- Bear Form
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "Surge", 42402)
	self:Log("SPELL_AURA_REFRESH", "Surge", 42402)
	self:Log("SPELL_AURA_REMOVED", "SurgeRemoved", 42402)
	self:Log("SPELL_DAMAGE", "SurgeDamage", 42402) -- for self:CDBar(). There are no SPELL_CAST_* / USCS events, SPELL_AURA_* ones can be immuned
	self:Log("SPELL_MISSED", "SurgeDamage", 42402)
	self:Log("SPELL_AURA_APPLIED", "DeafeningRoar", 42398)
end

function mod:OnEngage()
	self:Bar("stages", 30, 7090, "ability_hunter_pet_bear") -- 7090 = Bear Form
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.troll_trigger then
		self:MessageOld("stages", "red", nil, L.troll_message, "achievement_character_troll_male")
		self:Bar("stages", 30, 7090, "ability_hunter_pet_bear") -- 7090 = Bear Form
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 42377 then -- Shape of the Bear
		self:StopBar(42402) -- Surge's CD
		self:MessageOld("stages", "red", nil, 7090, "ability_hunter_pet_bear") -- 7090 = Bear Form
		self:Bar("stages", 30, L.troll_message, "achievement_character_troll_male")
	end
end

function mod:Surge(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, true)
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:SurgeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:SurgeDamage(args)
	self:CDBar(args.spellId, 8)
end

do
	local playerList = mod:NewTargetList()
	function mod:DeafeningRoar(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "yellow", "info", nil, nil, true)
		end
	end
end
