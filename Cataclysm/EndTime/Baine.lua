
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Baine", 938, 340)
if not mod then return end
mod:RegisterEnableMob(54431)
mod.engageId = 1881
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.totemDrop = "Totem dropped"
	L.totemThrow = "Totem thrown by %s"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{-4140, "ICON"}, -- Pulverize
		-4141, -- Throw Totem
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "Blitz")
	self:Log("SPELL_SUMMON", "TotemDown", 101614)
	self:Log("SPELL_AURA_REMOVED", "TotemUp", 101614)
end

function mod:OnEngage()
	self:Bar(-4140, 25) -- Pulverize
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Blitz(_, msg, _, _, _, player)
	if msg:find(self:SpellName(-4140)) then
		if player then
			self:TargetMessage(-4140, player, "Important", "Alert")
			self:PrimaryIcon(-4140, player)
			self:ScheduleTimer("PrimaryIcon", 4, -4140)
		else
			self:Message(-4140, "Important", "Alert")
		end
	end
end

function mod:TotemDown()
	self:Message(-4141, "Important", "Alarm", L.totemDrop)
	self:Bar(-4141, 20, L.totemDrop)
end

function mod:TotemUp(args)
	self:Message(-4141, "Positive", "Info", L.totemThrow:format(args.destName))
	self:StopBar(L.totemDrop)
end

