
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Drahga Shadowburner", 670, 133)
if not mod then return end
mod:RegisterEnableMob(40319)
mod.engageId = 1048
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		75218, -- Invocation of Flame
		90950, -- Devouring Flames
	}
end

function mod:OnBossEnable()
	-- normal
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "InvocationOfFlame")
	-- heroic
	self:Log("SPELL_CAST_START", "DevouringFlames", 90950)
end

function mod:VerifyEnable()
	if not UnitInVehicle("player") then return true end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InvocationOfFlame(_, msg)
	if msg:find(self:SpellName(75218)) then
		self:MessageOld(75218, "yellow", "alarm", CL.add_spawned)
	end
end

function mod:DevouringFlames(args)
	self:MessageOld(args.spellId, "red", "long")
end

