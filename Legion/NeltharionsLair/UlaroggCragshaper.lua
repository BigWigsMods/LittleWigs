--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ularogg Cragshaper", 1458, 1665)
if not mod then return end
mod:RegisterEnableMob(91004)
mod:SetEncounterID(1791)
mod:SetRespawnTime(15)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local totemsAlive = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.totems = "Totems"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198564, -- Stance of the Mountain
		193375, -- Bellow of the Deeps
		198428, -- Strike of the Mountain
		{198496, "TANK_HEALER"}, -- Sunder
	}, nil, {
		[193375] = L.totems,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Death("IntermissionTotemsDeath", 100818)
	self:Log("SPELL_CAST_START", "BellowOfTheDeeps", 193375)
	self:Log("SPELL_CAST_START", "StrikeOfTheMountain", 198428)
	self:Log("SPELL_CAST_START", "Sunder", 198496)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(198496, 7.4) -- Sunder
	self:CDBar(198428, 15.9) -- Strike of the Mountain
	self:CDBar(193375, 20.8) -- Bellow of the Deeps
	if self:Mythic() then
		-- 50s energy gain + .2s to ~10s delay
		self:CDBar(198564, 50.2) -- Stance of the Mountain
	else
		-- TODO check
		self:CDBar(198564, 36.4) -- Stance of the Mountain
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("198510", nil, true) then -- Stance of the Mountain
		self:SetStage(2)
		totemsAlive = self:Normal() and 3 or 5
		self:StopBar(198496) -- Sunder
		self:StopBar(198428) -- Strike of the Mountain
		self:StopBar(193375) -- Bellow of the Deeps
		self:StopBar(198564) -- Stance of the Mountain
		self:Message(198564, "cyan")
		self:PlaySound(198564, "long")
	end
end

function mod:IntermissionTotemsDeath()
	totemsAlive = totemsAlive - 1
	if totemsAlive == 0 then -- all of them fire UNIT_DIED
		self:SetStage(1)
		self:Message(198564, "green", CL.over:format(self:SpellName(198564))) -- Stance of the Mountain
		self:PlaySound(198564, "info")
		if self:Mythic() then
			-- 50s energy gain + delay
			self:CDBar(198564, 50.6) -- Stance of the Mountain
		else
			-- TODO check
			self:CDBar(198564, 70.7) -- Stance of the Mountain
		end
	end
end

function mod:BellowOfTheDeeps(args)
	self:Message(args.spellId, "orange", CL.incoming:format(L.totems))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 33.7)
end

function mod:StrikeOfTheMountain(args)
	-- TODO get target?
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.8)
end

function mod:Sunder(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 8.1)
end
