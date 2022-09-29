--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fleshrender Nok'gar", 1195, 1235)
if not mod then return end
mod:RegisterEnableMob(81297, 81305) -- Dreadfang, Fleshrender Nok'gar
mod:SetEncounterID(1749)
mod:SetRespawnTime(33)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{164426, "FLASH"}, -- Reckless Provocation
		164632, -- Burning Arrows
		166923, -- Barbed Arrow Barrage
		{164837, "ICON"}, -- Savage Mauling
		164835, -- Bloodletting Howl
		164734, -- Shredding Swipes
	}, {
		["stages"] = "general",
		[164426] = -10433, -- Fleshrender Nok'gar
		[164837] = -10437, -- Dreadfang
	}
end

function mod:OnBossEnable()
	-- Stages
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss2")
	self:Log("SPELL_CAST_SUCCESS", "Dismount", 175755)

	-- Fleshrender Nok'gar
	self:Log("SPELL_CAST_SUCCESS", "BurningArrows", 164635)
	self:Log("SPELL_CAST_SUCCESS", "BarbedArrowBarrage", 166923)
	self:Log("SPELL_CAST_START", "RecklessProvocationInc", 164426)
	self:Log("SPELL_AURA_APPLIED", "RecklessProvocation", 164426)
	self:Log("SPELL_AURA_REMOVED", "RecklessProvocationOver", 164426)

	-- Dreadfang
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss2")
	self:Log("SPELL_CAST_SUCCESS", "SavageMauling", 164837)
	self:Log("SPELL_AURA_APPLIED", "SavageMaulingApplied", 164837)
	self:Log("SPELL_AURA_REMOVED", "SavageMaulingRemoved", 164837)
	self:Log("SPELL_CAST_SUCCESS", "BloodlettingHowl", 164835)
	self:Death("DreadfangDeath", 81297)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(164632, 15.9) -- Burning Arrows
	self:Bar(166923, 32.4) -- Barbed Arrow Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:UNIT_HEALTH(event, unit)
	if self:GetHealth(unit) < 55 then
		self:UnregisterUnitEvent(event, unit)
		self:Message("stages", "yellow", CL.soon:format(CL.stage:format(2)), false)
		self:PlaySound("stages", "info")
	end
end

function mod:Dismount(args)
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
	self:CDBar(164426, 16) -- Reckless Provocation
	self:Bar(164632, 14.6) -- Burning Arrows
	self:Bar(166923, 28) -- Barbed Arrow Barrage
	self:CDBar(164837, 10) -- Savage Mauling
end

-- Fleshrender Nok'gar

function mod:BurningArrows(args)
	self:Message(164632, "red")
	self:PlaySound(164632, "long")
	self:Bar(164632, self:GetStage() == 1 and 30.4 or 40.1)
end

function mod:BarbedArrowBarrage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, self:GetStage() == 1 and 32.4 or 42.5)
end

function mod:RecklessProvocationInc(args)
	self:Bar(args.spellId, 42.5)
	self:Message(args.spellId, "orange", CL.incoming:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:Flash(args.spellId)
end

function mod:RecklessProvocation(args)
	self:Bar(args.spellId, 5, CL.onboss:format(args.spellName))
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

function mod:RecklessProvocationOver(args)
	self:StopBar(CL.onboss:format(args.spellName))
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

-- Dreadfang

function mod:BloodlettingHowl(args)
	self:Message(args.spellId, "yellow")
	if self:Dispeller("enrage", true) then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
	self:Bar(args.spellId, 25.5)
end

function mod:SavageMauling(args)
	self:CDBar(args.spellId, 10.7)
end

function mod:SavageMaulingApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert")
	self:TargetBar(args.spellId, 6, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SavageMaulingRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(args.spellId)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 164730 then
		self:Message(164734, "yellow")
		self:PlaySound(164734, "alarm")
		self:CDBar(164734, 17)
	end
end

function mod:DreadfangDeath()
	self:StopBar(164835) -- Bloodletting Howl
	self:StopBar(164734) -- Shredding Swipes
	self:StopBar(164837) -- Savage Mauling
end
