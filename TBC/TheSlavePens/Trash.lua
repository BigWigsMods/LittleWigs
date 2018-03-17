--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Slave Pens Trash", 547)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	17958, -- Coilfang Defender
	17961, -- Coilfang Enchantress
	21126, -- Coilfang Scale-Healer
	17962, -- Coilfang Collaborator
	21128 -- Coilfang Ray
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.defender = "Coilfang Defender"
	L.enchantress = "Coilfang Enchantress"
	L.healer = "Coilfang Scale-Healer"
	L.collaborator = "Coilfang Collaborator"
	L.ray = "Coilfang Ray"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Coilfang Defender ]]--
		15655, -- Shield Slam
		31554, -- Spell Reflection
		--[[ Coilfang Enchantress ]]--
		32173, -- Entangling Roots
		--[[ Coilfang Scale-Healer ]]--
		39378, -- Heal
		--[[ Coilfang Coilfang Collaborator ]]--
		33787, -- Cripple
		--[[ Coilfang Ray ]]--
		{34984, "SAY"}, -- Psychic Horror
	}, {
		[15655] = L.defender,
		[32173] = L.enchantress,
		[39378] = L.healer,
		[33787] = L.collaborator,
		[34984] = L.ray,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_AURA_APPLIED", "ShieldSlam", 15655)
	self:Log("SPELL_AURA_APPLIED", "SpellReflection", 31554)

	self:Log("SPELL_AURA_APPLIED", "EntanglingRoots", 32173)
	self:Log("SPELL_AURA_REMOVED", "EntanglingRootsRemoved", 32173)

	self:Log("SPELL_CAST_START", "Heal", 34945, 39378) -- normal, heroic

	self:Log("SPELL_AURA_APPLIED", "Cripple", 33787)
	self:Log("SPELL_AURA_REMOVED", "CrippleRemoved", 33787)

	self:Log("SPELL_AURA_APPLIED", "PsychicHorror", 34984)
	self:Log("SPELL_AURA_REMOVED", "PsychicHorrorRemoved", 34984)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShieldSlam(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alarm", nil, nil, self:Healer())
	self:TargetBar(args.spellId, 2, args.destName)
end

do
	local prev = 0
	function mod:SpellReflection(args)
		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:TargetMessage(args.spellId, args.destName, "Attention", "Long", nil, nil, true)
		end
	end
end

do
	local playerList, playersAffected = mod:NewTargetList(), 0
	function mod:EntanglingRoots(args)
		playersAffected = playersAffected + 1
		playerList[#playerList + 1] = args.destName
		if #playerList == 1 then
			self:Bar(args.spellId, 8)
			self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "Urgent", "Info", nil, nil, self:Dispeller("magic"))
		end
	end

	function mod:EntanglingRootsRemoved(args)
		playersAffected = playersAffected - 1
		if playersAffected == 0 then
			self:StopBar(args.spellName)
		end
	end
end

do
	local prev = 0
	function mod:Heal(args)
		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:Message(39378, "Urgent", "Alarm", CL.casting:format(args.spellName))
		end
	end
end

function mod:Cripple(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, args.destName, "Attention", "Info", nil, nil, true)
		self:TargetBar(args.spellId, 15, args.destName)
	end
end

function mod:CrippleRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:PsychicHorror(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId) -- helps prioritizing dispelling those who are about to run into some pack
	end
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 3, args.destName)
end

function mod:PsychicHorrorRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
