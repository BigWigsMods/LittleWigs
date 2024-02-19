--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gulping Goliath", 2527, 2507)
if not mod then return end
mod:RegisterEnableMob(189722) -- Gulping Goliath
mod:SetEncounterID(2616)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local gulpCount = 0
local toxicEffluviaCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		385551, -- Gulp
		385187, -- Overpowering Croak
		{385531, "SAY"}, -- Belly Slam
		385442, -- Toxic Effluvia
		{374389, "DISPEL"}, -- Gulp Swog Toxin
		385743, -- Hangry
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Gulp", 385551)
	self:Log("SPELL_CAST_START", "OverpoweringCroak", 385181)
	self:Log("SPELL_CAST_START", "BellySlam", 385531)
	self:Log("SPELL_CAST_START", "ToxicEffluvia", 385442)
	self:Log("SPELL_AURA_APPLIED_DOSE", "GulpSwogToxinApplied", 374389)
	self:Log("SPELL_AURA_APPLIED", "HangryApplied", 385743)
	self:Log("SPELL_AURA_REMOVED", "HangryRemoved", 385743)
end

function mod:OnEngage()
	gulpCount = 0
	toxicEffluviaCount = 0
	self:Bar(385187, 8.4) -- Overpowering Croak
	self:Bar(385551, 18.1) -- Gulp
	self:Bar(385442, 30.3) -- Toxic Effluvia
	self:Bar(385531, 38.8) -- Belly Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Gulp(args)
	gulpCount = gulpCount + 1
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if gulpCount == 1 then
		self:Bar(args.spellId, 47.3)
	else
		self:Bar(args.spellId, 38.8)
	end
end

function mod:OverpoweringCroak(args)
	self:Message(385187, "yellow")
	self:PlaySound(385187, "long")
	self:Bar(385187, 38.8)
end


do
	local function printTarget(self, player, guid)
		self:TargetMessage(385531, "red", player)
		self:PlaySound(385531, "alarm", nil, player)
		if self:Me(guid) then
			self:Say(385531, nil, nil, "Belly Slam")
		end
	end

	function mod:BellySlam(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:Bar(args.spellId, 38.8)
	end
end

function mod:ToxicEffluvia(args)
	toxicEffluviaCount = toxicEffluviaCount + 1
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	if toxicEffluviaCount == 1 then
		self:Bar(args.spellId, 26.7)
	else
		self:Bar(args.spellId, 38.8)
	end
end

do
	local prev = 0
	function mod:GulpSwogToxinApplied(args)
		if self:MobId(args.sourceGUID) ~= 190366 then -- don't handle trash version
			local amount = args.amount
			if amount >= 4 and (self:Dispeller("poison", nil, args.spellId) or self:Me(args.destGUID)) then
				local t = args.time
				-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
				-- but always display the 9 stack warning for each player since 10 stacks kills instantly.
				if amount == 9 or t - prev > 1.5 then
					prev = t

					-- insta-kill at 10 stacks
					self:StackMessage(args.spellId, "red", args.destName, amount, 7)
					if amount < 7 then
						self:PlaySound(args.spellId, "alert", nil, args.destName)
					else
						self:PlaySound(args.spellId, "warning", nil, args.destName)
					end
				end
			end
		end
	end
end

function mod:HangryApplied(args)
	-- this is a dispellable enrage in Normal/Heroic, but not dispellable in Mythic
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 60, CL.onboss:format(args.spellName))
end

function mod:HangryRemoved(args)
	self:StopBar(CL.onboss:format(args.spellName))
end
