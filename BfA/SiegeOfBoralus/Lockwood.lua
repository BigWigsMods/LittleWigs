local isTWWS1 = select(4, GetBuildInfo()) >= 110002 -- XXX remove when 11.0.2 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dread Captain Lockwood", 1822, 2173)
if not mod then return end
mod:RegisterEnableMob(129208) -- Dread Captain Lockwood
mod:SetEncounterID(2109)
mod:SetRespawnTime(34)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local withdrawCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ordnance_dropped = "Unstable Ordnance dropped"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Dread Captain Lockwood
		269029, -- Clear the Deck
		{273470, "TANK"}, -- Gut Shot
		268752, -- Withdraw
		463185, -- Mass Bombardment
		463182, -- Fiery Ricochet
		-- Ashvane Deckhand
		268230, -- Crimson Swipe
		-- Ashvane Cannoneer
		268260, -- Broadside
		268963, -- Unstable Ordnance
	}, {
		[269029] = self.displayName, -- Dread Captain Lockwood
		[268230] = -18230, -- Ashvane Deckhand
		[268260] = -18232, -- Ashvane Cannoneer
	}
end

if not isTWWS1 then
	function mod:GetOptions()
		return {
			-- Dread Captain Lockwood
			269029, -- Clear the Deck
			{273470, "TANK"}, -- Gut Shot
			268752, -- Withdraw
			-- Ashvane Deckhand
			268230, -- Crimson Swipe
			-- Ashvane Cannoneer
			268260, -- Broadside
			268963, -- Unstable Ordnance
		}, {
			[269029] = self.displayName, -- Dread Captain Lockwood
			[268230] = -18230, -- Ashvane Deckhand
			[268260] = -18232, -- Ashvane Cannoneer
		}
	end
end

function mod:OnBossEnable()
	-- Dread Captain Lockwood
	self:Log("SPELL_CAST_START", "ClearTheDeck", 269029)
	if isTWWS1 then
		self:Log("SPELL_CAST_START", "GutShot", 273470)
		self:Log("SPELL_AURA_APPLIED", "SightedArtilleryApplied", 272421) -- Mass Bombardment
		self:Log("SPELL_CAST_START", "FieryRicochet", 463182)
	else
		self:Log("SPELL_CAST_SUCCESS", "GutShot", 273470) -- XXX remove when 11.0.2 is live
	end
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3", "boss4") -- boss and adds
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1") -- TODO replace with EncounterEvent

	-- Ashvane Deckhand
	self:Log("SPELL_DAMAGE", "CrimsonSwipeDamage", 268230)

	-- Ashvane Cannoneer
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4") -- Broadside
end

function mod:OnEngage()
	withdrawCount = 1
	self:SetStage(1)
	self:CDBar(269029, 4.5) -- Clear the Deck
	if isTWWS1 then
		self:CDBar(463182, 8.0) -- Fiery Ricochet
		if self:Mythic() then
			self:CDBar(463185, 25.0) -- Mass Bombardment
		end
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Dread Captain Lockwood

function mod:ClearTheDeck(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18.2)
end

do
	local prev = 0
	function mod:GutShot(args)
		-- only cast when nobody is in melee range
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:SightedArtilleryApplied(args)
		-- throttle because this is applied to everyone
		local t = args.time
		if t - prev > 2 and self:MobId(args.sourceGUID) == 129208 then -- Dread Captain Lockwood
			prev = t
			self:Message(463185, "yellow") -- Mass Bombardment
			self:PlaySound(463185, "info")
			self:CDBar(463185, 25.0)
		end
	end
end

function mod:FieryRicochet(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 18.2)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 268752 then -- Withdraw (Stage 2)
		self:StopBar(269029) -- Clear the Deck
		if isTWWS1 then -- XXX remove check when 11.0.2 is live
			self:StopBar(463182) -- Fiery Ricochet
			if self:Mythic() then
				self:StopBar(463185) -- Mass Bombardment
			end
		end
		self:SetStage(2)
		if isTWWS1 then -- XXX remove check when 11.0.2 is live
			local percent = withdrawCount == 1 and 66 or 33
			self:Message(spellId, "cyan", CL.percent:format(percent, self:SpellName(spellId)))
		else
			self:Message(spellId, "cyan")
		end
		self:PlaySound(spellId, "long")
		withdrawCount = withdrawCount + 1
		self:CDBar(268260, 11.2) -- Broadside
	elseif spellId == 268963 then -- Unstable Ordnance (Dropped)
		self:Message(spellId, "cyan", L.ordnance_dropped)
		self:PlaySound(spellId, "info")
		self:StopBar(268260) -- Broadside
	end
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if self:GetStage() == 2 and UnitCanAttack("player", unit) then
		self:SetStage(1)
		self:Message(268752, "green", CL.over:format(self:SpellName(268752))) -- Withdraw
		self:PlaySound(268752, "info")
		self:CDBar(269029, 4.7) -- Clear the Deck
		if isTWWS1 then
			self:CDBar(463182, 8.2) -- Fiery Ricochet
			--if self:Mythic() then
				-- TODO timer
				--self:CDBar(463185, 25.0) -- Mass Bombardment
			--end
		else
			-- XXX remove when 11.0.2 is live
			self:Bar(268752, 35.7) -- Withdraw
		end
	end
end

-- Ashvane Deckhand

do
	local prev = 0
	function mod:CrimsonSwipeDamage(args)
		-- unavoidable for tanks, show alert for others that they're standing in the frontal
		if not self:Tank() and self:Me(args.destGUID) and self:MobId(args.sourceGUID) == 136483 then -- Ashvane Deckhand (boss summon)
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

-- Ashvane Cannoneer

function mod:UNIT_SPELLCAST_START(_, unit, _, spellId)
	if spellId == 268260 then -- Broadside
		if self:MobId(self:UnitGUID(unit)) == 136549 then -- Ashvane Cannoneer (boss summon)
			self:Message(spellId, "orange")
			self:PlaySound(spellId, "alarm")
			self:CDBar(spellId, 10.9)
		end
	end
end
