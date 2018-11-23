
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
		268752, -- Withdraw
		268230, -- Crimson Swipe
		268260, -- Broadside
		268963, -- Unstable Ordnance
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3", "boss4")

	self:Log("SPELL_AURA_APPLIED", "Evasive", 272471)
	self:Log("SPELL_CAST_START", "CleartheDeck", 269029)
	self:Log("SPELL_CAST_START", "CrimsonSwipe", 268230)
end

function mod:OnEngage()
	withdrawn = 0
	self:CDBar(269029, 4.5) -- Clear the Deck
	self:CDBar(268752, 13.5) -- Withdraw
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_START(_, _, _, spellId)
	if spellId == 268260 then -- Broadside
		self:Message2(spellId, "orange")
		self:PlaySound(spellId, "alarm")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 268752 then -- Withdraw
		withdrawn = 1
		self:Message2(spellId, "yellow")
		self:PlaySound(spellId, "long")

		self:StopBar(269029) -- Clear the Deck
		self:StopBar(268752) -- Withdraw

		self:CDBar(268260, 16) -- Broadside
	elseif spellId == 268745 then -- Energy Tracker / Jump Back
		if withdrawn == 1 then
			self:Message2(268752, "green", CL.over:format(self:SpellName(268752)))
			self:PlaySound(268752, "long")

			self:CDBar(269029, 7) -- Clear the Deck
			self:Bar(268752, 36) -- Withdraw
		end
	elseif spellId == 268963 then -- Unstable Ordnance (Dropped)
		self:Message2(spellId, "cyan", L.ordanance_dropped)
		self:PlaySound(spellId, "info")
	end
end

function mod:Evasive(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:CleartheDeck(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18)
end

do
	local prev = 0
	function mod:CrimsonSwipe(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message2(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
			self:CDBar(args.spellId, 9)
		end
	end
end
