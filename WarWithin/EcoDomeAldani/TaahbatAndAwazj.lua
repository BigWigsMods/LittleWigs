--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taah'bat and A'wazj", 2830, 2676)
if not mod then return end
mod:RegisterEnableMob(
	234933, -- Taah'bat
	237514 -- A'wazj
)
mod:SetEncounterID(3108)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local arcaneBlitzCount = 1
local bindingJavelinCount = 1
local riftClawsCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_112_achievement_dungeon_ecodome"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		-- Stage 1
		1236130, -- Binding Javelin
		1227918, -- Warp Strike
		{1219482, "TANK_HEALER"}, -- Rift Claws
		-- Stage 2
		1219700, -- Arcane Blitz
		1219457, -- Incorporeal
		{1219731, "CASTBAR"}, -- Destabilized
	}, {
		[1236130] = CL.stage:format(1),
		[1219700] = CL.stage:format(2),
	}
end

function mod:OnBossEnable()
	-- Stage 1
	self:Log("SPELL_CAST_START", "BindingJavelin", 1236130)
	self:Log("SPELL_AURA_APPLIED", "BindingJavelinApplied", 1236126)
	self:Log("SPELL_CAST_START", "WarpStrikeStage1", 1227918)
	self:Log("SPELL_CAST_START", "RiftClaws", 1219482)

	-- Stage 2
	self:Log("SPELL_CAST_START", "ArcaneBlitz", 1219700)
	self:Log("SPELL_AURA_APPLIED", "IncorporealApplied", 1219457)
	self:Log("SPELL_AURA_REMOVED_DOSE", "IncorporealApplied", 1219457)
	self:Log("SPELL_AURA_APPLIED", "DestabilizedApplied", 1219731) -- Arcane Blitz over
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Stage 2 Warp Strike
end

function mod:OnEngage()
	arcaneBlitzCount = 1
	bindingJavelinCount = 1
	riftClawsCount = 1
	self:SetStage(1)
	self:StopBar(CL.active)
	self:CDBar(1219482, 5.2, CL.count:format(self:SpellName(1219482), riftClawsCount)) -- Rift Claws
	self:CDBar(1236130, 10.8, CL.count:format(self:SpellName(1236130), bindingJavelinCount)) -- Binding Javelin
	self:CDBar(1227918, 22.2) -- Warp Strike
	self:CDBar(1219700, 33.1, CL.count:format(self:SpellName(1219700), arcaneBlitzCount)) -- Arcane Blitz
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- triggered from trash module on CHAT_MSG_MONSTER_YELL
	-- 0.00 [CHAT_MSG_MONSTER_YELL] I have no time for this. Taah'bat! Be certain they follow no further.#Soul-Scribe
	-- 11.83 [ENCOUNTER_START] 3108#Taah'bat and A'wazj#205#5",
	self:Bar("warmup", 11.8, CL.active, L.warmup_icon)
end

-- Stage 1

do
	local playerList = {}

	function mod:BindingJavelin(args)
		playerList = {}
		self:StopBar(CL.count:format(args.spellName, bindingJavelinCount))
		bindingJavelinCount = bindingJavelinCount + 1
		self:CDBar(args.spellId, 26.7, CL.count:format(args.spellName, bindingJavelinCount))
	end

	function mod:BindingJavelinApplied(args)
		if self:Mythic() then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(1236130, "red", playerList, 2)
			self:PlaySound(1236130, "info", nil, playerList)
		else -- Heroic, Normal
			self:TargetMessage(1236130, "red", args.destName)
			self:PlaySound(1236130, "info", nil, args.destName)
		end
	end
end

do
	local castStartTarget, castStartGUID

	function mod:WarpStrikeTarget(event, bossUnit)
		self:UnregisterUnitEvent(event, bossUnit)
		-- the boss immediately targets the true target, then detargets right after, then 1s later targets the true target again.
		-- if the boss detargets right away without switching targets first, that means it's on the tank (stored in castStartTarget).
		-- therefore we always know the true target on the first UNIT_TARGET event.
		local bossTargetUnit = bossUnit.."target"
		local name = self:UnitName(bossTargetUnit) or castStartTarget
		local guid = self:UnitGUID(bossTargetUnit) or castStartGUID
		if name then
			self:TargetMessage(1227918, "orange", name)
			if self:Me(guid) then
				self:PlaySound(1227918, "warning", nil, name)
			else
				self:PlaySound(1227918, "alarm", nil, name)
			end
		else -- fallback, should never occur
			self:Message(1227918, "orange")
			self:PlaySound(1227918, "alarm")
		end
	end

	function mod:WarpStrikeStage1(args)
		-- target's aura 1227142 is hidden
		local bossUnit = self:GetBossId(args.sourceGUID)
		local bossTargetUnit = bossUnit.."target"
		castStartTarget = self:UnitName(bossTargetUnit)
		castStartGUID = self:UnitGUID(bossTargetUnit)
		self:RegisterUnitEvent("UNIT_TARGET", "WarpStrikeTarget", bossUnit)
		self:CDBar(args.spellId, 26.7)
	end
end

function mod:RiftClaws(args)
	self:StopBar(CL.count:format(args.spellName, riftClawsCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, riftClawsCount))
	riftClawsCount = riftClawsCount + 1
	self:CDBar(args.spellId, 24.3, CL.count:format(args.spellName, riftClawsCount))
	self:PlaySound(args.spellId, "alert")
end

-- Stage 2

function mod:ArcaneBlitz(args)
	self:StopBar(CL.count:format(self:SpellName(1236130), bindingJavelinCount)) -- Binding Javelin
	self:StopBar(1227918) -- Warp Strike
	self:StopBar(CL.count:format(self:SpellName(1219482), riftClawsCount)) -- Rift Claws
	self:StopBar(CL.count:format(args.spellName, arcaneBlitzCount))
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, arcaneBlitzCount))
	arcaneBlitzCount = arcaneBlitzCount + 1
	self:PlaySound(args.spellId, "long")
end

function mod:IncorporealApplied(args)
	local amount = args.amount or (self:Mythic() and 6 or 3) -- starting stacks varies by difficulty
	self:Message(args.spellId, "yellow", CL.stackboss:format(amount, args.spellName))
	if not args.amount then -- initial application
		self:PlaySound(args.spellId, "info")
	end
end

function mod:DestabilizedApplied(args)
	-- cast simultaneously by both bosses
	if self:GetStage() == 2 then
		self:SetStage(1)
		self:CastBar(args.spellId, 15)
		self:Message(1219700, "green", CL.over:format(self:SpellName(1219700))) -- Arcane Blitz
		self:CDBar(1219482, 24.2, CL.count:format(self:SpellName(1219482), riftClawsCount)) -- Rift Claws
		self:CDBar(1236130, 30.3, CL.count:format(self:SpellName(1236130), bindingJavelinCount)) -- Binding Javelin
		self:CDBar(1227918, 41.2) -- Warp Strike
		self:CDBar(1219700, 78.9, CL.count:format(self:SpellName(1219700), arcaneBlitzCount)) -- Arcane Blitz
		self:PlaySound(1219700, "long")
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg)
	-- target's aura 1220427 is hidden
	if msg:find("1227137", nil, true) then -- Warp Strike (Stage 2)
		-- [CHAT_MSG_RAID_BOSS_WHISPER] |TInterface\\ICONS\\Spell_Arcane_Blink.blp:20|t You are targeted for |cFFFF0000|Hspell:1227137|h[Warp Strike]|h|r!#A'wazj
		self:PersonalMessage(1227918)
		self:PlaySound(1227918, "warning")
	end
end
