-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Novos the Summoner", 534, 589)
if not mod then return end
mod:RegisterEnableMob(26631)
mod.engageId = 1976
mod.respawnTime = 0

-------------------------------------------------------------------------------
--  Initialization
--

local crystalHandlersLeft = 4

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		47346, -- Arcane Field
		-6378, -- Crystal Handler
		50089, -- Wrath of Misery
		59910, -- Summon Minions
	}, {
		["stages"] = "general",
		[47346] = CL.stage:format(1),
		[50089] = CL.stage:format(2),
	}
end

function mod:OnBossEnable()
	-- Stage 1
	self:Log("SPELL_AURA_APPLIED", "ArcaneField", 47346)
	self:Log("SPELL_PERIODIC_DAMAGE", "ArcaneField", 47346)
	self:Log("SPELL_PERIODIC_MISSED", "ArcaneField", 47346)

	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Death("AddDied", 26627)

	-- Stage 2
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "WrathOfMisery", 50089, 59856) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "WrathOfMiseryRemoved", 50089, 59856)

	self:Log("SPELL_CAST_SUCCESS", "SummonMinions", 59910)
end

function mod:OnEngage()
	crystalHandlersLeft = 4
	self:Message("stages", "Neutral", nil, CL.stage:format(1), false)
	self:CDBar(-6378, 16.4)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

-- Stage 1
do
	local prev = 0
	function mod:ArcaneField(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", "Alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, _, target, _, _) -- Crystal Handler spawned
	if target == self:SpellName(-6378) then -- This message is targetted at them.
		self:Message(-6378, "Important", "Alarm", CL.spawned:format(target), false)
		self:CDBar(-6378, 15.8)
	end
end

function mod:AddDied(args)
	crystalHandlersLeft = crystalHandlersLeft - 1
	self:Message("stages", "Neutral", nil, CL.mob_remaining(args.destName, addsLeft), false)
	if crystalHandlersLeft == 0 then
		self:Bar("stages", 3.5, CL.stage:format(2), "inv_trinket_naxxramas06") -- icon that's used in the "Defeat Kel'thuzad" achievement
	end
end

-- Stage 2
function mod:UNIT_TARGETABLE_CHANGED(unit)
	-- Submerge
	if UnitCanAttack("player", unit) then
		self:Message("stages", "Neutral", nil, CL.stage:format(2), false)
		self:CDBar(59910, 1.5) -- Summon Minions
	end
end

function mod:WrathOfMisery(args)
	if self:Me(args.destGUID) or self:Healer() or self:Dispeller("curse") then
		self:TargetMessage(50089, args.destName, "Urgent")
		self:TargetBar(50089, 8, args.destName)
	end
end

function mod:WrathOfMiseryRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:SummonMinions(args)
	self:Message(args.spellId, "Attention", nil, CL.spawned:format(CL.adds))
	self:CDBar(args.spellId, 39.8) -- time until the next SPELL_CAST_START, 39.8 - 42.3s
end
