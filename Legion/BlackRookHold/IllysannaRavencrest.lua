--------------------------------------------------------------------------------
-- Module Declaration
--

--TO do List Eye beam is completely missing in transcriptor logs in any means ??
--Dark Rush and Eye beam Say's should be Tested
--Arcane blitz warning message could be changed into "Interrupt (sourceGuid)"
local mod, CL = BigWigs:NewBoss("Illysanna Ravencrest", 1501, 1653)
if not mod then return end
mod:RegisterEnableMob(98696)

--------------------------------------------------------------------------------
-- Locals
--

local Hud = Oken.Hud

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{197418, "TANK"}, -- Vengeful Shear
		{197478, "SAY", "AURA"}, -- Dark Rush
		{197546, "HUD"}, -- Brutal Glaive
		{197687, "SAY", "AURA"}, -- Eye Beam
		197797, -- Arcane Blitz
		{197974, "HUD"}, -- Bonecrushing Strike
	}, {
		[197797] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BrutalGlaive", 197546)
	self:Log("SPELL_CAST_SUCCESS", "VengefulShear", 197418)
	self:Log("SPELL_CAST_START", "ArcaneBlitz", 197797)
	self:Log("SPELL_CAST_START", "BonecrushingStrike", 197974)
	self:Log("SPELL_AURA_APPLIED", "DarkRushApplied",197478)
	self:Log("SPELL_AURA_REMOVED", "DarkRushRemoved",197478)
	self:Log("SPELL_CAST_SUCCESS", "EyeBeams", 197687)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 98696)
end

function mod:OnEngage()
	self:Bar(197546, 5.5) -- Brutal Glaive
	self:Bar(197418, 8.3) -- Vengeful Shear
	self:CDBar(197478, 12) -- Dark Rush
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local rangeCheck
	local rangeObject
	-- local area
	local text

	function mod:CheckBrutalGlaiveRange()
		for unit in mod:IterateGroup() do
			if not UnitIsUnit(unit, "player") and not UnitIsDead(unit) and mod:Range(unit) <= 10 then
				rangeObject:SetColor(1, 0, 0)
				-- area:SetColor(1, 0, 0)
				return
			end
		end
		rangeObject:SetColor(0, 1, 0)
		-- area:SetColor(0, 1, 0)
	end

	function mod:BrutalGlaive(args) -- add timer
		self:CDBar(args.spellId, 14.5)
		self:StopBar(197696)

		if self:Me(args.destGUID) and self:Hud(args.spellId) then
			rangeObject = Hud:DrawSpinner("player", 70):SetOffset(0, -10)
			-- area = Hud:DrawArea("player", 60):SetOffset(0, -10)
			-- text = Hud:DrawText("player", "Glaive"):SetOffset(0, -10)
			rangeCheck = self:ScheduleRepeatingTimer("CheckBrutalGlaiveRange", 0.2)
			self:CheckBrutalGlaiveRange()
			C_Timer.After(2.5, function()
				self:CancelTimer(rangeCheck)
				-- area:Remove()
				-- text:Remove()
				rangeObject:Remove()
				rangeObject = nil
			end)
		end
	end
end

function mod:DarkRushApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:ShowAura(args.spellId, "Rush")
	end
end

function mod:DarkRushRemoved(args)
	if self:Me(args.destGUID) then
		self:HideAura(args.spellId)
	end
end

function mod:VengefulShear(args)
	self:CDBar(args.spellId, 11)
end

function mod:EyeBeams(args) -- eye beam missing timer xxx fix this
	self:StopBar(197546) -- Brutal Glaive
	self:StopBar(197418) -- Vengeful Shear
	self:Bar(197687, 15) -- Eye Beam
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:ShowAura(args.spellId, 12, "Beam", true)
	end
end

function mod:ArcaneBlitz(args)
	if self:Interrupter(args.sourceGUID) then
		self:TargetMessage(args.spellId, args.sourceName, "Attention", "Alarm")
	end
end

function mod:BonecrushingStrike(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
	if self:Hud(args.spellId) then
		local area = Hud:DrawArea(args.sourceGUID, 50):SetColor(0.75,0.75,0.75):SetOffset(0, -50)
		local spinner = Hud:DrawSpinner(args.sourceGUID, 50, 3):SetColor(0.75,0.75,0.75):SetOffset(0, -50)
		local text = Hud:DrawText(args.sourceGUID, "Cleave"):SetOffset(0, -50)
		C_Timer.After(3, function()
			area:Remove()
			spinner:Remove()
			text:Remove()
		end)
	end
end
