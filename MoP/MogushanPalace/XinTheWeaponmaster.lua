--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xin the Weaponmaster", 994, 698)
if not mod then return end
mod:RegisterEnableMob(61398) -- Xin the Weaponmaster
mod:SetEncounterID(1441)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local circleOfFlameCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		119684, -- Ground Slam
		-5973, -- Circle of Flame
		-5971, -- Whirlwinding Axes
		-5972, -- Blade Trap
		-5974, -- Death From Above!
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GroundSlam", 119684)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Circle of Flame
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Stages
end

function mod:OnEngage()
	circleOfFlameCount = 1
	self:SetStage(1)
	self:CDBar(119684, 14.4) -- Ground Slam
	self:CDBar(-5973, 9.5) -- Circle of Flame
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GroundSlam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18.2)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 120109 then -- Summon Staff (Circle of Flame)
		self:Message(-5973, "red")
		self:PlaySound(-5973, "alert")
		circleOfFlameCount = circleOfFlameCount + 1
		if circleOfFlameCount <= 9 then
			-- this is cast a maximum of 9 times
			self:CDBar(-5973, 20.6)
		else
			self:StopBar(-5973)
		end
	end
end

-- Stages

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("119374", nil, true) then -- Whirlwind (Whirlwinding Axes)
		self:SetStage(2)
		self:Message(-5971, "cyan", CL.percent:format(95, self:SpellName(-5971)))
		self:PlaySound(-5971, "long")
	elseif msg:find("119311", nil, true) then -- Stream of Blades (Blade Trap)
		self:SetStage(3)
		self:Message(-5972, "cyan", CL.percent:format(66, self:SpellName(-5972)))
		self:PlaySound(-5972, "long")
	elseif msg:find("120142", nil, true) then -- Dart (Death From Above!)
		self:SetStage(4)
		self:Message(-5974, "cyan", CL.percent:format(33, self:SpellName(-5974)))
		self:PlaySound(-5974, "long")
	end
end
