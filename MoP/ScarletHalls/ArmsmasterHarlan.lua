--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Armsmaster Harlan", 1001, 654)
if not mod then return end
mod:RegisterEnableMob(58632)
mod:SetEncounterID(1421)
mod:SetRespawnTime(21)

--------------------------------------------------------------------------------
-- Locals
--

local callForHelpCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		111217, -- Dragon's Reach
		{111216, "CASTBAR"}, -- Blades of Light
		-5378, -- Call for Help
	}, nil, {
		[111217] = self:SpellName(15284), -- Dragon's Reach (Cleave)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DragonsReach", 111217)
	self:Log("SPELL_CAST_START", "BladesOfLight", 111216)
	self:Log("SPELL_AURA_APPLIED", "BladesOfLightApplied", 111216)
	self:Log("SPELL_AURA_REMOVED", "BladesOfLightRemoved", 111216)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Call for Help
end

function mod:OnEngage()
	self:CDBar(111217, 7.1, 15284) -- Dragon's Reach
	self:CDBar(-5378, 20) -- Call for Help
	self:CDBar(111216, 41) -- Blades of Light
	callForHelpCount = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DragonsReach(args)
	self:Message(args.spellId, "purple", 15284)
	self:CDBar(args.spellId, 7.1, 15284)
end

function mod:BladesOfLight(args)
	self:StopBar(15284) -- Dragon's Reach (Cleave)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:BladesOfLightApplied(args)
	self:Message(args.spellId, "orange", CL.duration:format(args.spellName, "22"))
	self:CastBar(args.spellId, 22)
end

function mod:BladesOfLightRemoved(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:CDBar(args.spellId, 33)
	self:PlaySound(args.spellId, "info")
end

do
	local timers = { 30, 25, 22, 20, 18, 16, 14 }
	function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
		-- |TInterface\\Icons\\ability_warrior_battleshout.blp:20|tArmsmaster Harlan calls on two of his allies to join the fight!
		if msg:find("ability_warrior_battleshout", nil, true) then -- Call for Help
			self:Message(-5378, "cyan")
			self:CDBar(-5378, timers[callForHelpCount] or 13)
			callForHelpCount = callForHelpCount + 1
			self:PlaySound(-5378, "info")
		end
	end
end
