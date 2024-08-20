--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gutshot", 2520, 2472)
if not mod then return end
mod:RegisterEnableMob(186116) -- Gutshot
mod:SetEncounterID(2567)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		384827, -- Call Hyenas
		385359, -- Ensnaring Trap
		384416, -- Meat Toss
		384633, -- Master's Call
		{384353, "TANK"}, -- Gut Shot
		384577, -- Crippling Bite
	}, nil, {
		[385359] = CL.traps, -- Ensnaring Trap (Traps)
		[384416] = CL.fixate, -- Meat Toss (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallHyenas", 384827)
	self:Log("SPELL_CAST_SUCCESS", "EnsnaringTrapPrecast", 383979)
	self:Log("SPELL_AURA_APPLIED", "EnsnaringTrapCast", 385356)
	self:Log("SPELL_AURA_APPLIED", "EnsnaringTrapApplied", 384148)
	self:Log("SPELL_CAST_START", "MeatToss", 384416)
	self:Log("SPELL_AURA_APPLIED", "SmellLikeMeatApplied", 384425)
	self:Log("SPELL_CAST_START", "MastersCall", 384633)
	self:Log("SPELL_CAST_START", "GutShot", 384353)
	self:Log("SPELL_CAST_SUCCESS", "GutShotSuccess", 384353)
	self:Log("SPELL_CAST_START", "CripplingBite", 384577)
	self:Log("SPELL_AURA_APPLIED", "CripplingBiteApplied", 384575)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CripplingBiteApplied", 384575)
end

function mod:OnEngage()
	self:CDBar(385359, 8.4) -- Ensnaring Trap
	self:CDBar(384353, 12.0) -- Gut Shot
	-- this will ony be cast if Hyenas are getting trapped, CD is mostly not useful
	-- self:CDBar(384633, 15.7) -- Master's Call
	if not self:Normal() then
		self:CDBar(384416, 20.6) -- Meat Toss
	end
	self:CDBar(384827, 31.5) -- Call Hyenas
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallHyenas(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 31.6)
end

do
	local playerList = {}

	function mod:EnsnaringTrapPrecast(args)
		playerList = {}
		self:CDBar(385359, 17.0)
	end

	function mod:EnsnaringTrapCast(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(385359, "yellow", playerList, 2, CL.casting:format(CL.traps)) -- Casting Traps: player1, player2
		self:PlaySound(385359, "alert", nil, playerList)
	end
end

do
	local prev = 0
	function mod:EnsnaringTrapApplied(args)
		-- when triggered the trap will AOE root everything within 5 yards, ideally two Hyenas
		local onNpc = not self:Player(args.destFlags)
		if onNpc and self:Friendly(args.destFlags) then
			-- don't alert for pets
			return
		end
		if onNpc then
			local t = args.time
			if t - prev > 1.5 then
				-- only throttle for enemies
				prev = t
				self:TargetMessage(385359, "green", args.destName)
				self:PlaySound(385359, "info")
			end
		elseif self:Me(args.destGUID) or self:Dispeller("movement") then
			self:TargetMessage(385359, "red", args.destName)
			self:PlaySound(385359, "alarm", nil, args.destName)
		end
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:PersonalMessage(384416)
			self:PlaySound(384416, "alarm")
		else
			self:TargetMessage(384416, "orange", player)
			self:PlaySound(384416, "alert", nil, player)
		end
	end

	function mod:MeatToss(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:CDBar(args.spellId, 21.9)
	end
end

function mod:SmellLikeMeatApplied(args)
	self:TargetBar(384416, 10, args.destName, CL.fixate) -- Meat Toss (Fixate)
end

function mod:MastersCall(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	-- this will ony be cast if Hyenas are getting trapped, CD is mostly not useful
	-- self:CDBar(args.spellId, 17.0)
end

function mod:GutShot(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:GutShotSuccess(args)
	-- she can interrupt her own cast, only goes on CD when successful
	self:CDBar(args.spellId, 15.7) -- 18.2s CD - 2.5s cast time
end

do
	local prev = 0
	function mod:CripplingBite(args)
		-- cast by the Hyenas ~17.5s after summon, healing reduction + slow on closest player
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:CripplingBiteApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:StackMessage(384577, "purple", args.destName, args.amount, 1)
		self:PlaySound(384577, "warning", nil, args.destName)
	end
end
