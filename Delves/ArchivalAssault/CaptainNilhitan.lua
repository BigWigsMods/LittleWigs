--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Captain Nil'hitan", 2803)
if not mod then return end
mod:RegisterEnableMob(244384) -- Captain Nil'hitan
mod:SetEncounterID(3279)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.captain_nilhitan = "Captain Nil'hitan"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.captain_nilhitan
end

function mod:GetOptions()
	return {
		1239350, -- All Hands!
		{1239427, "DISPEL"}, -- Scuttle That One!
		1239445, -- Broadside
		1239533, -- Cosmic Waste
		-- Ethereal Scallywag
		{1239407, "NAMEPLATE"}, -- Run Through
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AllHands", 1239350)
	self:Log("SPELL_CAST_START", "ScuttleThatOne", 1239427)
	self:Log("SPELL_AURA_APPLIED", "ScuttleThatOneApplied", 1239427)
	self:Log("SPELL_CAST_START", "Broadside", 1239445)
	self:Log("SPELL_PERIODIC_DAMAGE", "CosmicWasteDamage", 1239533)
	self:Log("SPELL_PERIODIC_MISSED", "CosmicWasteDamage", 1239533)

	-- Ethereal Scallywag
	self:Log("SPELL_SUMMON", "AllHandsSummon", 1239859, 1239350)
	self:Log("SPELL_CAST_START", "RunThrough", 1239407)
	self:Death("EtherealScallywagDeath", 245722)
end

function mod:OnEngage()
	self:CDBar(1239350, 10.7) -- All Hands!
	self:CDBar(1239427, 20.4) -- Scuttle That One!
	self:CDBar(1239445, 30.1) -- Broadside
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AllHands(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 31.9)
	self:PlaySound(args.spellId, "info")
end

function mod:ScuttleThatOne(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 30.3)
	self:PlaySound(args.spellId, "alert")
end

function mod:ScuttleThatOneApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:Broadside(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 32.7)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:CosmicWasteDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then -- 1s tick rate
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Ethereal Scallywag

function mod:AllHandsSummon(args)
	self:Nameplate(1239407, 3.2, args.destGUID) -- Run Through
end

function mod:RunThrough(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 10.9, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:EtherealScallywagDeath(args)
	self:ClearNameplate(args.destGUID)
end
