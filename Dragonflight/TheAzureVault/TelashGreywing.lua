--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Telash Greywing", 2515, 2483)
if not mod then return end
mod:RegisterEnableMob(186737) -- Telash Greywing
mod:SetEncounterID(2583)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		388008, -- Absolute Zero
		386781, -- Frost Bomb
		{387151, "SAY"}, -- Icy Devastator
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AbsoluteZero", 388008)
	self:Log("SPELL_CAST_START", "FrostBomb", 386781)
	self:Log("SPELL_AURA_APPLIED", "FrostBombApplied", 386881)
	self:Log("SPELL_CAST_START", "IcyDevastator", 387151)
end

function mod:OnEngage()
	self:Bar(386781, 3.6) -- Frost Bomb
	self:CDBar(387151, 14.6) -- Icy Devastator
	-- cast at 100 energy, 20s energy gain + 1.2s delay
	self:Bar(388008, 21.2) -- Absolute Zero
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AbsoluteZero(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 8) -- 8s cast
	-- cast at 100 energy, 8s cast + 50s energy gain + ~5.1s delay
	self:Bar(args.spellId, 63.1)
end

function mod:FrostBomb(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	-- TODO pattern seems to be FB->AZ then FB->FB->FB->AZ repeating
	-- if this pattern is consistent then timers can be improved
	self:CDBar(args.spellId, 15.8)
end

function mod:FrostBombApplied(args)
	if self:Me(args.destGUID) then
		self:TargetBar(386781, 5, args.destName)
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(387151)
			self:PlaySound(387151, "alarm")
		else
			self:PlaySound(387151, "alert", nil, player)
		end
		self:TargetMessage(387151, "orange", player)
	end

	function mod:IcyDevastator(args)
		self:GetBossTarget(printTarget, 0.2, args.sourceGUID)
		self:CDBar(args.spellId, 30.3)
	end
end
