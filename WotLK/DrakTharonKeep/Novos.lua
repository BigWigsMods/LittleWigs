-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Novos the Summoner", 600, 589)
if not mod then return end
mod:RegisterEnableMob(26631)
mod:SetEncounterID(mod:Classic() and 371 or 1976)
mod:SetRespawnTime(30)
mod:SetStage(1)

-------------------------------------------------------------------------------
--  Locals
--

local crystalHandlersSpawned = 1 -- to decide whether CDBar needs to be displayed
local crystalHandlersLeft = 4 -- to display CL.mob_remaining messages

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L.adds = -6378 -- Crystal Handler
	L.adds_desc = -6375 -- The description of the first stage that mentions that 4 of those need to be killed.
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		"adds", -- Crystal Handler
		47346, -- Arcane Field
		49034, -- Blizzard
		50089, -- Wrath of Misery
		59910, -- Summon Minions
	}, {
		["stages"] = "general",
		["adds"] = CL.stage:format(1),
		[49034] = CL.stage:format(2),
	}
end

function mod:OnBossEnable()
	-- Arcane Field, normal/heroic Blizzard
	self:Log("SPELL_AURA_APPLIED", "GroundDamage", 47346, 49034, 59854)
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundDamage", 47346)
	self:Log("SPELL_PERIODIC_MISSED", "GroundDamage", 47346)

	-- Stage 1
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Death("AddDied", 26627)

	-- Stage 2
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "WrathOfMisery", 50089, 59856) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "WrathOfMiseryRemoved", 50089, 59856)
	self:Log("SPELL_CAST_SUCCESS", "WrathOfMiseryCastSuccess", 50089, 59856)

	self:Log("SPELL_CAST_SUCCESS", "SummonMinions", 59910)
end

function mod:OnEngage()
	crystalHandlersSpawned = 1
	crystalHandlersLeft = 4
	self:SetStage(1)
	self:Message("stages", "cyan", CL.stage:format(1), false)
	self:CDBar("adds", 15.5, CL.count:format(self:SpellName(-6378), crystalHandlersSpawned), "spell_shadow_raisedead")
end

-------------------------------------------------------------------------------
--  Event Handlers
--

-- Arcane Field, normal/heroic Blizzard
do
	local prev = 0
	function mod:GroundDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId == 59854 and 49034 or args.spellId, "blue", "alert", CL.you:format(args.spellName)) -- SetOption:47346,49034:::
			end
		end
	end
end

-- Stage 1

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, source, _, _, target) -- Crystal Handler spawned
	if source == self.displayName then -- cross-module safety, this is the only BOSS_EMOTE present in this encounter.
		self:StopBar(CL.count:format(target, crystalHandlersSpawned))
		self:Message("adds", "yellow", CL.spawned:format(target), false)
		self:PlaySound("adds", "info")
		crystalHandlersSpawned = crystalHandlersSpawned + 1
		if crystalHandlersSpawned <= 4 then
			self:CDBar("adds", 15.8, CL.count:format(target, crystalHandlersSpawned), "spell_shadow_raisedead")
		end
	end
end

function mod:AddDied(args)
	crystalHandlersLeft = crystalHandlersLeft - 1
	self:Message("stages", "cyan", CL.mob_remaining:format(args.destName, crystalHandlersLeft), false)
	if crystalHandlersLeft == 0 then
		self:Bar("stages", 6.5, CL.stage:format(2), "inv_trinket_naxxramas06") -- icon that's used in the "Defeat Kel'thuzad" achievement
	end
end

-- Stage 2

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 26631 or self:GetStage() == 2 then return end
	if UnitCanAttack("player", unit) then
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:CDBar(50089, 6) -- Wrath of Misery
		if not self:Normal() then
			self:CDBar(59910, 1.5) -- Summon Minions
		end
	end
end

function mod:WrathOfMisery(args)
	if self:Me(args.destGUID) or self:Healer() or self:Dispeller("curse") then
		self:TargetMessage(50089, "orange", args.destName)
		self:TargetBar(50089, 8, args.destName)
	end
end

function mod:WrathOfMiseryRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:WrathOfMiseryCastSuccess()
	self:CDBar(50089, 8.5) -- 8.5 - 15.8s
end

function mod:SummonMinions(args)
	self:Message(args.spellId, "yellow", CL.adds_spawned)
	self:CDBar(args.spellId, 39.8) -- time until the next SPELL_CAST_START, 39.8 - 42.3s
end
