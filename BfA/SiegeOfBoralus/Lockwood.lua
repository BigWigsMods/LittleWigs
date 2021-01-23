
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dread Captain Lockwood", 1822, 2173)
if not mod then return end
mod:RegisterEnableMob(129208) -- Dread Captain Lockwood
mod.engageId = 2109
mod.respawnTime = 36

--------------------------------------------------------------------------------
-- Locals
--

local withdrawn = 0

--------------------------------------------------------------------------------
-- Locales
--

local L = mod:GetLocale()
if L then
	L.ordanance_dropped = "Unstable Ordnance Dropped"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		272471, -- Evasive
		269029, -- Clear the Deck
		273470, -- Gut Shot
		268752, -- Withdraw
		{268230, "TANK"}, -- Crimson Swipe
		268260, -- Broadside
		268963, -- Unstable Ordnance
	}, {
		[272471] = "general",
		[268230] = -18230, -- Ashvane Deckhand
		[268260] = -18232, -- Ashvane Cannoneer
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3", "boss4")

	self:Log("SPELL_AURA_APPLIED", "Evasive", 272471)
	self:Log("SPELL_CAST_START", "CleartheDeck", 269029)
	self:Log("SPELL_CAST_START", "CrimsonSwipe", 268230)
	self:Log("SPELL_CAST_SUCCESS", "GutShot", 273470)
end

function mod:OnEngage()
	withdrawn = 0
	self:Bar(269029, 3.5) -- Clear the Deck
	self:Bar(268752, 12.1) -- Withdraw
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_START(_, unit, _, spellId)
	if spellId == 268260 then -- Broadside
		local guid = self:UnitGUID(unit)
		if self:MobId(guid) == 136549 then -- Boss add, trash cannoneers have a different id
			self:Message(spellId, "orange")
			self:PlaySound(spellId, "alarm")
			self:Bar(268260, 12) -- Broadside
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 268752 then -- Withdraw
		withdrawn = 1
		self:Message(spellId, "yellow")
		self:PlaySound(spellId, "long")

		self:StopBar(269029) -- Clear the Deck
		self:StopBar(268752) -- Withdraw

		self:Bar(268260, 11.2) -- Broadside
	elseif spellId == 268745 then -- Energy Tracker / Jump Back
		if withdrawn == 1 then
			self:Message(268752, "green", CL.over:format(self:SpellName(268752)))
			self:PlaySound(268752, "long")

			self:Bar(269029, 7) -- Clear the Deck
			self:Bar(268752, 35.7) -- Withdraw
		end
	elseif spellId == 268963 then -- Unstable Ordnance (Dropped)
		self:Message(spellId, "cyan", L.ordanance_dropped)
		self:PlaySound(spellId, "info")
	end
end

function mod:Evasive(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:CleartheDeck(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 18)
end

do
	local prev = 0
	function mod:CrimsonSwipe(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:GutShot(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
