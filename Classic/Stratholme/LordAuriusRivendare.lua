--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Aurius Rivendare", 329, 456)
if not mod then return end
mod:RegisterEnableMob(mod:Retail() and 45412 or 10440) -- Lord Aurius Rivendare, Baron Rivendare
mod:SetEncounterID(484)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.death_pact_trigger = "attempts to cast Death Pact on his servants!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		17473, -- Raise Dead
		17471, -- Death Pact
		17434, -- Shadow Bomb
	}
end

function mod:OnBossEnable()
	if self:Retail() then
		self:Log("SPELL_CAST_START", "RaiseDead", 17473)
	else -- Classic
		self:Log("SPELL_SUMMON", "RaiseDeadSummon", 17475) -- no cast event on Classic, use one of the summon events
	end
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:Log("SPELL_CAST_START", "ShadowBomb", 17434)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 45412)
	end
end

function mod:OnEngage()
	if self:Retail() then
		self:CDBar(17473, 6.1) -- Raise Dead
	else -- Classic
		self:CDBar(17473, 7.1) -- Raise Dead
	end
	self:CDBar(17434, 18.2) -- Shadow Bomb
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RaiseDead(args)
	self:Message(args.spellId, "cyan") -- Raise Dead
	self:CDBar(args.spellId, 15.8) -- Raise Dead
	-- Death Pact occurs 12s after the summon, which is 1s after cast start
	self:Bar(17471, 13.0) -- Death Pact
	self:PlaySound(args.spellId, "info") -- Raise Dead
end

function mod:CHAT_MSG_MONSTER_EMOTE(_, msg)
	if msg:find(L.death_pact_trigger, nil, true) then
		self:Message(17471, "yellow") -- Death Pact
		self:StopBar(17471) -- Death Pact
	end
end

function mod:ShadowBomb(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 30.4)
	self:PlaySound(args.spellId, "alert")
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:RaiseDeadSummon()
	self:Message(17473, "cyan") -- Raise Dead
	self:CDBar(17473, 15.8) -- Raise Dead
	-- Death Pact occurs 12s after the summon
	self:Bar(17471, 12.0) -- Death Pact
	self:PlaySound(17473, "info") -- Raise Dead
end
