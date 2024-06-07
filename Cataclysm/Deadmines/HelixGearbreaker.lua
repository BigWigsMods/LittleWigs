--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Helix Gearbreaker", 36, 90)
if not mod then return end
mod:RegisterEnableMob(47296, 47297) -- Helix Gearbreaker, Lumbering Oaf
mod:SetEncounterID(1065)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Lumbering Oaf
		88300, -- Oaf Smash
		-- Helix Gearbreaker
		{88352, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Chest Bomb
	}, nil, {
		[88352] = CL.bomb, -- Chest Bomb (Bomb)
	}
end

function mod:OnBossEnable()
	-- Lumbering Oaf
	self:Log("SPELL_CAST_SUCCESS", "Charge", 88288) -- Oaf Smash
	self:Death("LumberingOafDeath", 47297)

	-- Helix Gearbreaker
	self:Log("SPELL_AURA_APPLIED", "ChestBomb", 88352)
	self:Log("SPELL_AURA_REMOVED", "ChestBombRemoved", 88352)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(88300, 17.0) -- Oaf Smash
	if self:Heroic() then
		self:CDBar(88352, 47.7, CL.bomb) -- Chest Bomb
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Lumbering Oaf

function mod:Charge(args) -- Oaf Smash
	self:TargetMessage(88300, "red", args.destName)
	self:PlaySound(88300, "info", nil, args.destName)
	self:CDBar(88300, 51.0)
end

function mod:LumberingOafDeath()
	self:StopBar(88300) -- Oaf Smash
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
	if self:Heroic() then
		self:CDBar(88352, 12.2, CL.bomb) -- Chest Bomb
	end
end

-- Helix Gearbreaker

function mod:ChestBomb(args)
	self:TargetMessage(args.spellId, "orange", args.destName, CL.bomb)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, CL.bomb, nil, "Bomb")
		self:SayCountdown(args.spellId, 10)
	end
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 51.0, CL.bomb)
	else
		self:CDBar(args.spellId, 13.3, CL.bomb)
	end
end

function mod:ChestBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end
