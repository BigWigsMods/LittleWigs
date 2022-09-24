if not IsTestBuild() then return end
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
		388008, -- Below Zero
		386781, -- Frost Bomb
		{387151, "SAY"}, -- Icy Devastator
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BelowZero", 387928)
	self:Log("SPELL_CAST_START", "FrostBomb", 386781)
	self:Log("SPELL_AURA_APPLIED", "FrostBombApplied", 386881)
	self:Log("SPELL_CAST_START", "IcyDevastator", 387151)
end

function mod:OnEngage()
	self:Bar(386781, 3.6) -- Frost Bomb
	self:CDBar(387151, 10.9) -- Icy Devastator
	self:Bar(388008, 22.9) -- Below Zero
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BelowZero(args)
	self:Message(388008, "red")
	self:PlaySound(388008, "long")
	self:Bar(388008, 60.7)
	self:CastBar(388008, 9) -- 1s delay, 8s cast
end

function mod:FrostBomb(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
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
		self:CDBar(args.spellId, 23.1)
	end
end
