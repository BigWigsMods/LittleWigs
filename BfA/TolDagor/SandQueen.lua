
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Sand Queen", 1771, 2097)
if not mod then return end
mod:RegisterEnableMob(127479) -- The Sand Queen
mod.engageId = 2101
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		257092, -- Sand Trap
		257495, -- Sandstorm
		{257608, "SAY"}, -- Upheaval
		257609, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SandTrap", 257092)
	self:Log("SPELL_CAST_START", "Sandstorm", 257495)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Upheaval Target
	self:Log("SPELL_CAST_SUCCESS", "Upheaval", 257608)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 257609)
end

function mod:OnEngage()
	self:Bar(257092, 8.5) -- Sand Trap
	self:Bar(257608, 14.5) -- Upheaval
	self:Bar(257495, 30) -- Sandstorm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SandTrap(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 14.5)
end

function mod:Sandstorm(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 35)
end

function mod:Upheaval(args)
	self:Bar(args.spellId, 42)
	self:CastBar(args.spellId, 4.35)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("257617") then -- Upheaval
		self:TargetMessage(257608, "red", destName)
		self:PlaySound(257608, "alarm", nil, destName)
		local guid = self:UnitGUID(destName)
		if self:Me(guid) then
			self:Say(257608)
		end
	end
end

function mod:Enrage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
