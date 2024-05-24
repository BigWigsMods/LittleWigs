--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkmaster Gandling", 1007, 684)
if not mod then return end
mod:RegisterEnableMob(59080) -- Darkmaster Gandling
mod:SetEncounterID(1430)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		113395, -- Harsh Lesson
		113143, -- Rise
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Harsh Lesson
	self:Log("SPELL_AURA_APPLIED", "Rise", 113143)
end

function mod:OnEngage()
	if not self:Solo() then
		self:CDBar(113395, 16.7) -- Harsh Lesson
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	-- |TInterface\\Icons\\inv_misc_book_01.blp:20|t%s assigns destName a |cFFFF0000|Hspell:113395|h[Harsh Lesson]|h|r!#Darkmaster Gandling
	if msg:find("113395", nil, true) then -- Harsh Lesson
		self:TargetMessage(113395, "red", destName)
		self:PlaySound(113395, "info", nil, destName)
		self:CDBar(113395, 30.3)
	end
end

function mod:Rise(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	-- only happens if/when the tank or healer is chosen for Harsh Lesson, so it's not
	-- possible to show a bar for this ability.
end
