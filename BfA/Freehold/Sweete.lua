--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harlan Sweete", 1754, 2095)
if not mod then return end
mod:RegisterEnableMob(126983)
mod:SetEncounterID(2096)
mod:SetRespawnTime(15)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages", -- Loaded Dice
		257278, -- Swiftwind Saber
		{257305, "SAY"}, -- Cannon Barrage
		413136, -- Whirling Dagger
		257316, -- Avast, ye!
		{257314, "SAY"}, -- Black Powder Bomb
	}, nil, {
		[257316] = CL.add,
		[257314] = CL.fixate,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LoadedDiceAllHands", 257402)
	self:Log("SPELL_CAST_START", "LoadedDiceManOWar", 257458)
	self:Log("SPELL_CAST_START", "SwiftwindSaber", 413147, 413145) -- Regular version, All Hands version
	self:Log("SPELL_AURA_APPLIED", "CannonBarrage", 257305)
	self:Log("SPELL_CAST_START", "WhirlingDagger", 413131, 413136) -- Regular version, All Hands version
	self:Log("SPELL_CAST_SUCCESS", "AvastYe", 257316)
	self:Log("SPELL_AURA_APPLIED", "BlackPowderBomb", 257314)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(257278, 10.9) -- Swiftwind Saber
	self:CDBar(413136, 14.1) -- Whirling Dagger
	self:CDBar(257305, 20.6) -- Cannon Barrage
	self:CDBar(257316, 31.9, CL.next_add) -- Avast, ye!
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LoadedDiceAllHands(args)
	self:SetStage(2)
	self:Message("stages", "cyan", CL.percent:format(60, args.spellName), args.spellId)
	self:PlaySound("stages", "long", "stage")
	self:Bar(257278, 10.9) -- Swiftwind Saber
	self:Bar(413136, 14.6) -- Whirling Dagger
	self:Bar(257305, 15.8) -- Cannon Barrage
	self:CDBar(257316, 21.9, CL.next_add) -- Avast, ye!
end

function mod:LoadedDiceManOWar(args)
	self:SetStage(3)
	self:Message("stages", "cyan", CL.percent:format(30, args.spellName), args.spellId)
	self:PlaySound("stages", "long", "stage")
	self:Bar(257278, 10.9) -- Swiftwind Saber
	self:Bar(413136, 14.6) -- Whirling Dagger
	self:Bar(257305, 15.8) -- Cannon Barrage
	self:CDBar(257316, 21.9, CL.next_add) -- Avast, ye!
end

function mod:SwiftwindSaber(args)
	if self:GetStage() == 1 then
		-- aims at tank
		self:Message(257278, "purple")
		self:CDBar(257278, 18.2)
	elseif self:GetStage() == 2 then
		-- aims in 5 directions but not at tank
		self:Message(257278, "yellow")
		self:CDBar(257278, 18.2)
	else -- Stage 3
		-- aims in 5 directions but not at tank, shorter CD
		self:Message(257278, "yellow")
		self:CDBar(257278, 13.4)
	end
	self:PlaySound(257278, "alert", "watchstep")
end

do
	local onMe, scheduled = nil, nil
	local function warn(self) -- It's either on 1 person or on everyone in the later stage, targetlist warnings are not not needed
		if onMe then
			self:PersonalMessage(257305)
			self:PlaySound(257305, "alarm", "moveout")
		else -- on everyone
			self:Message(257305, "orange") -- Cannon Barrage
			self:PlaySound(257305, "alarm", "watchstep")
		end
		onMe = nil
		scheduled = nil
	end

	function mod:CannonBarrage(args)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Cannon Barrage")
			onMe = true
		end
		if not scheduled then
			scheduled = self:ScheduleTimer(warn, 0.1, self)
			if self:GetStage() ~= 3 then -- Stage 1, 2
				self:CDBar(args.spellId, 25.4)
			else -- Stage 3
				self:CDBar(args.spellId, 15.8)
			end
		end
	end
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(413136, "yellow", name)
			self:PlaySound(413136, "alert", nil, name)
		end
	end

	function mod:WhirlingDagger(args)
		if args.spellId == 413131 then -- Stage 1
			-- just applies the debuff to the targeted player in stage 1
			self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		else -- 413136, Stage 2, 3
			-- this chains to other players in stage 2 and 3 so target scanning isn't useful
			self:Message(413136, "yellow")
			self:PlaySound(413136, "alert")
		end
		if self:GetStage() ~= 3 then -- Stage 1, 2
			self:CDBar(413136, 17.6)
		else -- Stage 3
			self:CDBar(413136, 13.4)
		end
	end
end

function mod:AvastYe(args)
	self:Message(257316, "red", CL.add_spawned)
	self:PlaySound(257316, "info", "addincoming")
	if self:GetStage() ~= 3 then -- Stage 1, 2
		self:CDBar(257316, 25.5, CL.next_add) -- Avast, ye!
	else -- Stage 3
		self:CDBar(257316, 20.7, CL.next_add) -- Avast, ye!
	end
end

function mod:BlackPowderBomb(args)
	if args.sourceGUID ~= args.destGUID then -- The add buffs itself with the same spell id
		self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate, args.spellId)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning", nil, args.destName)
			self:Say(args.spellId, CL.fixate, nil, "Fixate")
		else
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end
