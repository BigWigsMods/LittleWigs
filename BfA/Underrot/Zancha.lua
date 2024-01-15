--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sporecaller Zancha", 1841, 2130)
if not mod then return end
mod:RegisterEnableMob(131383)
mod:SetEncounterID(2112)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local festeringHarvestCount = 1
local shockwaveCount = 1
local upheavalCount = 1
local volatilePodsCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		259732, -- Festering Harvest
		259830, -- Boundless Rot
		272457, -- Shockwave
		{259718, "SAY", "SAY_COUNTDOWN"}, -- Upheaval
		273285, -- Volatile Pods
	}, {
		[259732] = "general",
		[273285] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FesteringHarvest", 259732)
	self:Log("SPELL_CAST_SUCCESS", "BoundlessRot", 259830)
	self:Log("SPELL_CAST_START", "Shockwave", 272457)
	self:Log("SPELL_AURA_APPLIED", "UpheavalApplied", 259718)
	self:Log("SPELL_AURA_REMOVED", "UpheavalRemoved", 259718)

	-- Heroic+
	self:Log("SPELL_CAST_SUCCESS", "VolatilePods", 273285)
end

function mod:OnEngage()
	festeringHarvestCount = 1
	shockwaveCount = 1
	upheavalCount = 1
	volatilePodsCount = 1
	if self:Normal() then
		self:CDBar(272457, 10.5) -- Shockwave
		self:CDBar(259718, 16.0) -- Upheaval
		self:CDBar(259732, 46.0, CL.count:format(self:SpellName(259732), festeringHarvestCount)) -- Festering Harvest
	else -- Heroic, Mythic
		self:CDBar(272457, 10.6) -- Shockwave
		self:CDBar(259718, 16.6) -- Upheaval
		self:CDBar(273285, 21.6) -- Volatile Pods
		self:CDBar(259732, 45.9, CL.count:format(self:SpellName(259732), festeringHarvestCount)) -- Festering Harvest
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FesteringHarvest(args)
	local festeringHarvestMessage = CL.count:format(args.spellName, festeringHarvestCount)
	self:StopBar(festeringHarvestMessage)
	self:Message(args.spellId, "red", festeringHarvestMessage)
	self:PlaySound(args.spellId, "alarm")
	festeringHarvestCount = festeringHarvestCount + 1
	if self:Normal() then
		self:CDBar(args.spellId, 55.9, CL.count:format(args.spellName, festeringHarvestCount))
	else
		self:Bar(args.spellId, 51.1, CL.count:format(args.spellName, festeringHarvestCount))
	end
end

function mod:BoundlessRot(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "watchstep")
	-- doesn't need its own timer, it occurs immediately on pull and
	-- 3.5s after each Festering Harvest after that.
end

function mod:Shockwave(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	shockwaveCount = shockwaveCount + 1
	if self:Normal() then
		if shockwaveCount == 2 then
			self:Bar(args.spellId, 14.6)
		elseif shockwaveCount == 4 then
			self:Bar(args.spellId, 30.4)
		elseif shockwaveCount % 2 == 0 then
			self:Bar(args.spellId, 40.1)
		else
			self:Bar(args.spellId, 15.8)
		end
	else -- Heroic, Mythic
		if shockwaveCount == 2 then
			self:Bar(args.spellId, 14.6)
		elseif shockwaveCount == 3 then
			self:Bar(args.spellId, 45.1)
		elseif shockwaveCount % 2 == 0 then
			self:Bar(args.spellId, 20.7)
		else
			self:Bar(args.spellId, 30.4)
		end
	end
end

do
	local playerList = {}
	local prev = 0
	function mod:UpheavalApplied(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			-- Upheaval gets double cast by the boss if there's more than 1 person alive,
			-- so just use the debuff application with a throttle for the timer.
			playerList = {}
			upheavalCount = upheavalCount + 1
			if self:Normal() then
				if upheavalCount == 3 then
					self:Bar(args.spellId, 30.4)
				elseif upheavalCount % 3 == 0 then
					self:Bar(args.spellId, 24.3)
				else
					self:Bar(args.spellId, 15.8)
				end
			else -- Heroic, Mythic
				if upheavalCount == 3 then
					self:Bar(args.spellId, 24.3)
				elseif upheavalCount % 2 == 0 then
					self:Bar(args.spellId, 20.7)
				else
					self:Bar(args.spellId, 30.4)
				end
			end
		end
		playerList[#playerList + 1] = args.destName
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning", "runout")
			self:Say(args.spellId, nil, nil, "Upheaval")
			self:SayCountdown(args.spellId, 6)
		end
		self:TargetsMessage(args.spellId, "orange", playerList, 2)
	end
end

function mod:UpheavalRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

-- Heroic+

do
	local prev = 0
	function mod:VolatilePods(args)
		local t = args.time
		if t - prev > 2 then -- throttle because each of the 4 Volatile Pod NPCs casts this simultaneously
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "long")
			volatilePodsCount = volatilePodsCount + 1
			if volatilePodsCount == 4 then
				self:CDBar(args.spellId, 27.9)
			else
				self:CDBar(args.spellId, 25.5)
			end
		end
	end
end
