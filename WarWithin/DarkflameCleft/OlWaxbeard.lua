--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ol' Waxbeard", 2651, 2569)
if not mod then return end
mod:RegisterEnableMob(
	210149, -- Ol' Waxbeard (boss)
	210153 -- Ol' Waxbeard (mount)
)
mod:SetEncounterID(2829)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{422116, "SAY", "SAY_COUNTDOWN"}, -- Reckless Charge
		{422245, "TANK_HEALER"}, -- Rock Buster
		{423693, "ME_ONLY_EMPHASIZE"}, -- Luring Candleflame
		-- TODO Underhanded Track-tics (Mythic)
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss1") -- Reckless Charge
	self:Log("SPELL_CAST_START", "RockBuster", 422245)
	self:Log("SPELL_AURA_APPLIED", "LuringCandleflameApplied", 423693)
end

function mod:OnEngage()
	self:CDBar(422245, 1.3) -- Rock Buster
	self:CDBar(423693, 11.0) -- Luring Candleflame
	self:CDBar(422116, 28.8) -- Reckless Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid, elapsed)
		self:TargetMessage(422116, "orange", name)
		self:PlaySound(422116, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(422116, nil, nil, "Reckless Charge")
			self:SayCountdown(422116, 5 - elapsed)
		end
	end

	function mod:UNIT_SPELLCAST_START(_, unit, _, spellId)
		if spellId == 422116 then -- Reckless Charge
			-- there is an emote for this with a target, but the emote often lists the wrong player
			self:GetUnitTarget(printTarget, 0.1, self:UnitGUID(unit))
			self:CDBar(spellId, 35.2)
		end
	end
end

function mod:RockBuster(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 13.3)
end

function mod:LuringCandleflameApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
	self:CDBar(args.spellId, 38.5)
end
