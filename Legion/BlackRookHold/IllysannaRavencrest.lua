--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Illysanna Ravencrest", 1501, 1653)
if not mod then return end
mod:RegisterEnableMob(98696)
mod:SetEncounterID(1833)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local vengefulShearRemaining = 6
local darkRushRemaining = 2
local brutalGlaiveRemaining = 6
local eyeBeamsRemaining = 3

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Vengeance
		{197418, "TANK_HEALER"}, -- Vengeful Shear
		{197478, "SAY", "SAY_COUNTDOWN"}, -- Dark Rush
		{197546, "SAY"}, -- Brutal Glaive
		-- Stage Two: Fury
		{197696, "SAY"}, -- Eye Beams
		197797, -- Arcane Blitz
		197974, -- Bonecrushing Strike
	}, {
		[197418] = -12277, -- Stage One: Vengeance
		[197696] = -12281, -- Stage Two: Fury
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_SUCCESS", "Leap", 197622)
	self:Log("SPELL_CAST_SUCCESS", "GainingEnergy", 197394)

	-- Stage One: Vengeance
	self:Log("SPELL_CAST_START", "VengefulShear", 197418)
	self:Log("SPELL_CAST_SUCCESS", "DarkRush", 197478)
	self:Log("SPELL_AURA_APPLIED", "DarkRushApplied", 197478)
	self:Log("SPELL_AURA_REMOVED", "DarkRushRemoved", 197478)
	self:Log("SPELL_CAST_START", "BrutalGlaive", 197546)
	self:Log("SPELL_CAST_SUCCESS", "BrutalGlaiveSuccess", 197546)

	-- Stage Two: Fury
	self:Log("SPELL_CAST_SUCCESS", "EyeBeams", 197687)
	self:Log("SPELL_CAST_START", "ArcaneBlitz", 197797)
	self:Log("SPELL_AURA_APPLIED", "ArcaneBlitzApplied", 197797)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ArcaneBlitzApplied", 197797)
	self:Log("SPELL_AURA_REMOVED", "ArcaneBlitzRemoved", 197797)
	self:Log("SPELL_CAST_START", "BonecrushingStrike", 197974)
end

function mod:OnEngage()
	darkRushRemaining = 1
	eyeBeamsRemaining = 3
	self:SetStage(1)
	self:CDBar(197546, 5.1) -- Brutal Glaive
	self:CDBar(197418, 8.3) -- Vengeful Shear
	self:CDBar(197478, 11.9) -- Dark Rush
	if self:Mythic() then
		vengefulShearRemaining = 2
		brutalGlaiveRemaining = 2
		-- cast at 100 energy, starts at 65 energy: 32s energy gain + 3.2s delay
		self:CDBar("stages", 35.2, -12281, 197622) -- Stage Two: Fury, Leap
	else -- Heroic, Normal
		vengefulShearRemaining = 3
		brutalGlaiveRemaining = 3
		-- cast at 100 energy, starts at 50 energy: 45s energy gain + 3.2s delay
		self:CDBar("stages", 48.2, -12281, 197622) -- Stage Two: Fury, Leap
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:Leap(args)
	eyeBeamsRemaining = 3
	self:StopBar(197418) -- Vengeful Shear
	self:StopBar(197478) -- Dark Rush
	self:StopBar(197546) -- Brutal Glaive
	self:StopBar(-12281) -- Stage Two: Fury
	self:SetStage(2)
	self:Message("stages", "cyan", -12281, args.spellId) -- Stage Two: Fury
	self:PlaySound("stages", "long")
	self:CDBar(197696, 1.5) -- Eye Beams
	self:CDBar("stages", 45.0, -12277, 197394) -- Stage One: Vengeance, Gaining Energy
end

function mod:GainingEnergy(args)
	if not self:IsEngaged() then
		-- this is cast upon respawn
		return
	end
	vengefulShearRemaining = 6
	darkRushRemaining = 2
	brutalGlaiveRemaining = 6
	self:StopBar(197696) -- Eye Beams
	self:StopBar(-12277) -- Stage One: Vengeance
	self:SetStage(1)
	self:Message("stages", "cyan", -12277, args.spellId) -- Stage One: Vengeance
	self:PlaySound("stages", "long")
	self:CDBar(197546, 6.1) -- Brutal Glaive
	self:CDBar(197478, 12.2) -- Dark Rush
	self:CDBar(197418, 13.0) -- Vengeful Shear
	-- cast at 100 energy, 90s energy gain + 3.4s delay
	self:CDBar("stages", 93.4, -12281, 197622) -- Stage Two: Fury, Leap
end

-- Stage One: Vengeance

function mod:VengefulShear(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	vengefulShearRemaining = vengefulShearRemaining - 1
	if vengefulShearRemaining > 0 then
		self:CDBar(args.spellId, 11.0)
	else
		self:StopBar(args.spellId)
	end
end

do
	local playerList = {}

	function mod:DarkRush(args)
		playerList = {}
		darkRushRemaining = darkRushRemaining - 1
		if darkRushRemaining > 0 then
			self:CDBar(args.spellId, 31.0)
		else
			self:StopBar(args.spellId)
		end
	end

	function mod:DarkRushApplied(args)
		playerList[#playerList + 1] = args.destName
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		self:TargetsMessage(args.spellId, "red", playerList, 3)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Dark Rush")
			self:SayCountdown(args.spellId, 6)
		end
	end
end

function mod:DarkRushRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(197546, "yellow", name)
		self:PlaySound(197546, "alert", nil, name)
		if self:Me(guid) then
			self:Say(197546, nil, nil, "Brutal Glaive")
		end
	end

	function mod:BrutalGlaive(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		-- only decrement brutalGlaiveRemaining in SUCCESS as this will just be recast if the target
		-- uses invisibility/vanish/etc
		if brutalGlaiveRemaining > 1 then
			self:CDBar(args.spellId, 14.5)
		else
			self:StopBar(args.spellId)
		end
	end
end

function mod:BrutalGlaiveSuccess(args)
	brutalGlaiveRemaining = brutalGlaiveRemaining - 1
end

-- Stage Two: Fury

function mod:EyeBeams(args)
	self:TargetMessage(197696, "red", args.destName)
	self:PlaySound(197696, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(197696, nil, nil, "Eye Beams")
	end
	eyeBeamsRemaining = eyeBeamsRemaining - 1
	if eyeBeamsRemaining > 0 then
		self:CDBar(197696, 13.5)
	else
		self:StopBar(197696)
	end
end

function mod:BonecrushingStrike(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local blitzTracker = {}

	function mod:ArcaneBlitz(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		local amount = blitzTracker[args.sourceGUID] or 0
		local _, interruptReady = self:Interrupter()
		if interruptReady or (self:Dispeller("magic") and amount >= 2) then
			if amount >= 1 then
				self:Message(args.spellId, "yellow", CL.casting:format(CL.count:format(args.spellName, amount)))
			else
				self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			end
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:ArcaneBlitzApplied(args)
		blitzTracker[args.destGUID] = args.amount or 1
	end

	function mod:ArcaneBlitzRemoved(args)
		blitzTracker[args.destGUID] = nil
	end
end
