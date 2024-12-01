--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Stomper Kreeg", 429, 412)
if not mod then return end
mod:RegisterEnableMob(14322) -- Stomper Kreeg
mod:SetEncounterID(363)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		22833, -- Booze Spit
		16740, -- War Stomp
		15578, -- Whirlwind
		22835, -- Drunken Rage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BoozeSpit", 22833)
	self:Log("SPELL_CAST_SUCCESS", "WarStomp", 16740)
	self:Log("SPELL_CAST_SUCCESS", "Whirlwind", 15578)
	self:Log("SPELL_AURA_APPLIED", "DrunkenRageApplied", 22835)
end

function mod:OnEngage()
	self:CDBar(22833, 8.3) -- Booze Spit
	self:CDBar(16740, 10.7) -- War Stomp
	self:CDBar(15578, 12.2) -- Whirlwind
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BoozeSpit(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 19.4)
	self:PlaySound(args.spellId, "alarm")
end

function mod:WarStomp(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alert")
end

function mod:Whirlwind(args)
	if self:MobId(args.sourceGUID) == 14322 then -- Stomper Kreeg
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 13.4)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:DrunkenRageApplied(args)
	self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "long")
end
