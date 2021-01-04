
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rezan", 1763, 2083)
if not mod then return end
mod:RegisterEnableMob(122963)
mod.engageId = 2086
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		255371, -- Terrifying Visage
		{257407, "SAY"}, -- Pursuit
		{255434, "TANK"}, -- Serrated Teeth
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TerrifyingVisage", 255371)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Pursuit
	self:Log("SPELL_CAST_SUCCESS", "SerratedTeeth", 255434)
end

function mod:OnEngage()
	self:Bar(255371, 12) -- Terrifying Visage
	self:Bar(257407, 22) -- Pursuit
	self:CDBar(255434, 6) -- Serrated Teeth
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TerrifyingVisage(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "lineofsight")
	self:CastBar(args.spellId, 5)
	self:Bar(args.spellId, 35.2)
end


function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("255421") then -- Devour
		self:TargetMessage(257407, "orange", destName)
		local guid = self:UnitGUID(destName)
		if self:Me(guid) then
			self:PlaySound(257407, "alarm", "runaway")
			self:Say(257407)
		end
		self:Bar(257407, 35.2)
	end
end

function mod:SerratedTeeth(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "defensive")
	self:CDBar(args.spellId, 35.2)
end
