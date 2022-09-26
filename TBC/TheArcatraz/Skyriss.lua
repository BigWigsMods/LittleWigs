
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Harbinger Skyriss", 552, 551)
if not mod then return end
mod:RegisterEnableMob(20912, 20904) -- Harbinger Skyriss, Warden Mellichar
mod.engageId = 1914
mod.respawnTime = 64

--------------------------------------------------------------------------------
-- Locals
--

local nextSplitWarning = 71

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	-- I knew the prince would be angry, but I... I have not been myself. I had to let them out! The great one speaks to me, you see. Wait--outsiders. Kael'thas did not send you! Good... I'll just tell the prince you released the prisoners!
	L.first_cell_trigger = "I have not been myself"
	-- Behold, yet another terrifying creature of incomprehensible power!
	L.second_and_third_cells_trigger = "of incomprehensible power"
	-- Anarchy! Bedlam! Oh, you are so wise! Yes, I see it now, of course!
	L.fourth_cell_trigger = "Anarchy! Bedlam!"
	-- It is a small matter to control the mind of the weak... for I bear allegiance to powers untouched by time, unmoved by fate. No force on this world or beyond harbors the strength to bend our knee... not even the mighty Legion!
	L.warmup_trigger = "the mighty Legion"

	L.prison_cell = "Prison Cell"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		39415, -- Fear
		37162, -- Domination
		36924, -- Mind Rend
		-5335, -- Harbringer's Illusion
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	if self:Classic() then
		self:RegisterEvent("UNIT_HEALTH")
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	else
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	end

	self:Log("SPELL_AURA_APPLIED", "Fear", 39415)
	self:Log("SPELL_AURA_REMOVED", "FearRemoved", 39415)
	self:Log("SPELL_AURA_APPLIED", "Domination", 37162, 39019) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "MindRend", 36924, 36929, 39017, 39021) -- normal (real one, illusion), heroic (real one, illusion)
end

function mod:OnEngage()
	nextSplitWarning = 71 -- 66% and 33%
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg:find(L.first_cell_trigger, nil, true) then
		self:Bar("warmup", 37.7, CL.count:format(L.prison_cell, 1), "achievement_boss_harbinger_skyriss")
	elseif msg:find(L.second_and_third_cells_trigger, nil, true) then
		self:Bar("warmup", 8.1, CL.count:format(L.prison_cell, 2), "achievement_boss_harbinger_skyriss") -- Millhouse Manastorm
		self:Bar("warmup", 35.7, CL.count:format(L.prison_cell, 3), "achievement_boss_harbinger_skyriss")
	elseif msg:find(L.fourth_cell_trigger, nil, true) then
		self:Bar("warmup", 14.5, CL.count:format(L.prison_cell, 4), "achievement_boss_harbinger_skyriss")
	elseif msg:find(L.warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 30.2, CL.active, "achievement_boss_harbinger_skyriss")
	end
end

function mod:Fear(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:TargetBar(args.spellId, 4, args.destName)
end

function mod:FearRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Domination(args)
	self:TargetMessageOld(37162, args.destName, "orange")
	self:TargetBar(37162, 6, args.destName)
end

function mod:MindRend(args)
	self:TargetMessageOld(36924, args.destName, "red")
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 20912 then -- Harbinger Skyriss
		local hp = self:GetHealth(unit)
		if hp < nextSplitWarning then
			nextSplitWarning = nextSplitWarning - 33
			self:MessageOld(-5335, "green", nil, CL.soon:format(self:SpellName(19570)), false) -- 19570 = Split
			if nextSplitWarning < 33 then
				if self:Classic() then
					self:UnregisterEvent(event)
				else
					self:UnregisterUnitEvent(event, unit)
				end
			end
		end
	end
end

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(event, unit, castId, spellId)
		if (spellId == 36931 or spellId == 36932) and castId ~= prev then -- 66% / 33% illusions
			prev = castId
			if spellId == 36932 then
				if self:Classic() then
					self:UnregisterEvent(event)
				else
					self:UnregisterUnitEvent(event, unit)
				end
			end
			self:MessageOld(-5335, "cyan", nil, CL.spawned:format(self:SpellName(-5335)))
		end
	end
end
