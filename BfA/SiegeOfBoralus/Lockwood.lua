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

function mod:OnBossEnable()
	-- Dread Captain Lockwood
	self:Log("SPELL_CAST_START", "ClearTheDeck", 269029)
	self:Log("SPELL_CAST_START", "GutShot", 273470)
	--self:Log("SPELL_CAST_SUCCESS", "MassBombardment", 463185) TODO eventually
	self:Log("SPELL_AURA_APPLIED", "SightedArtilleryApplied", 471578) -- Mass Bombardment
	self:Log("SPELL_CAST_START", "FieryRicochet", 463182)
	self:Log("SPELL_CAST_SUCCESS", "Withdraw", 268752)
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Withdraw over

	-- Ashvane Deckhand
	self:Log("SPELL_DAMAGE", "CrimsonSwipeDamage", 268230)

	-- Ashvane Cannoneer
	self:Log("SPELL_CAST_START", "Broadside", 268260)
	self:Log("SPELL_CAST_SUCCESS", "UnstableOrdnance", 268963) -- Unstable Ordnance dropped
end

function mod:OnEngage()
	withdrawCount = 1
	self:SetStage(1)
	self:CDBar(269029, 4.5) -- Clear the Deck
	self:CDBar(463182, 8.0) -- Fiery Ricochet
	if self:Mythic() then
		self:CDBar(463185, 25.0) -- Mass Bombardment
	end
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Siege of Boralus Trash", true)
	if trashMod then
		trashMod:Enable()
		trashMod:LockwoodDefeated()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Dread Captain Lockwood

function mod:ClearTheDeck(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 18.2)
	self:PlaySound(args.spellId, "alarm")
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
		if t - prev > 5 then
			prev = t
			self:Message(463185, "yellow") -- Mass Bombardment
			self:CDBar(463185, 25.0)
			self:PlaySound(463185, "info")
		end
	end
end

function mod:FieryRicochet(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 18.2)
end

function mod:Withdraw(args)
	local percent = withdrawCount == 1 and 66 or 33
	withdrawCount = withdrawCount + 1
	self:StopBar(269029) -- Clear the Deck
	self:StopBar(463182) -- Fiery Ricochet
	if self:Mythic() then
		self:StopBar(463185) -- Mass Bombardment
	end
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.percent:format(percent, args.spellName))
	self:CDBar(268260, 11.2) -- Broadside
	self:PlaySound(args.spellId, "long")
end

function mod:EncounterEvent() -- Withdraw over
	self:SetStage(1)
	self:Message(268752, "green", CL.over:format(self:SpellName(268752))) -- Withdraw
	self:CDBar(269029, 3.3) -- Clear the Deck
	self:CDBar(463182, 8.2) -- Fiery Ricochet
	if self:Mythic() then
		self:CDBar(463185, 25.0) -- Mass Bombardment
	end
	self:PlaySound(268752, "info")
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

function mod:Broadside(args)
	if self:MobId(args.sourceGUID) == 136549 then -- Ashvane Cannoneer (boss summon)
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 10.9)
	end
end

function mod:UnstableOrdnance(args)
	self:Message(args.spellId, "cyan", L.ordnance_dropped)
	self:PlaySound(args.spellId, "info")
	self:StopBar(268260) -- Broadside
end
