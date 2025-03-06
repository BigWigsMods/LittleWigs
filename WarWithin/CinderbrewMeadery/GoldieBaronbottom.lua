--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Goldie Baronbottom", 2661, 2589)
if not mod then return end
mod:RegisterEnableMob(214661) -- Goldie Baronbottom
mod:SetEncounterID(2930)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_achievement_dungeon_cinderbrewmeadery"
end

--------------------------------------------------------------------------------
-- Locals
--

local burningRichochetCount = 1
local cashCannonCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		435560, -- Spread the Love!
		435622, -- Let It Hail!
		436644, -- Burning Richochet
		436592, -- Cash Cannon
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SpreadTheLove", 435560)
	self:Log("SPELL_CAST_START", "LetItHail", 435622)
	self:Log("SPELL_CAST_START", "BurningRichochet", 436637)
	self:Log("SPELL_AURA_APPLIED", "BurningRichochetApplied", 436644)
	self:Log("SPELL_CAST_START", "CashCannon", 436592)
end

function mod:OnEngage()
	burningRichochetCount = 1
	cashCannonCount = 1
	self:StopBar(CL.active)
	-- Spread the Love! is cast immediately on pull
	self:CDBar(436592, 8.1) -- Cash Cannon
	self:CDBar(436644, 16.6) -- Burning Richochet
	self:CDBar(435622, 40.9) -- Let It Hail!
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	-- 82.62 [CLEU] UNIT_DIED##nil#Creature-0-2085-2661-23348-219588#Yes Man
	-- 92.13 [NAME_PLATE_UNIT_ADDED] Goldie Baronbottom#Creature-0-2085-2661-23348-214661
	self:Bar("warmup", 9.5, CL.active, L.warmup_icon)
end

function mod:SpreadTheLove(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 55.6)
	self:PlaySound(args.spellId, "info")
end

function mod:LetItHail(args)
	self:Message(args.spellId, "yellow")
	-- cast at 100 energy, 4.5s cast time + 5s channel + 8.7s RP + 36s energy gain + 1.6s delay
	self:CDBar(args.spellId, 55.8)
	self:PlaySound(args.spellId, "long")
end

do
	local playerList = {}

	function mod:BurningRichochet(args)
		playerList = {}
		burningRichochetCount = burningRichochetCount + 1
		if burningRichochetCount % 2 == 0 then
			self:CDBar(436644, 14.6)
		else
			self:CDBar(436644, 41.3)
		end
	end

	function mod:BurningRichochetApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "orange", playerList, 2)
		self:PlaySound(args.spellId, "alarm", nil, playerList)
	end
end

function mod:CashCannon(args)
	self:Message(args.spellId, "purple")
	cashCannonCount = cashCannonCount + 1
	if cashCannonCount % 3 ~= 1 then -- 2, 3, 5, 6...
		self:CDBar(args.spellId, 14.6)
	else -- 4, 7...
		self:CDBar(args.spellId, 26.7)
	end
	self:PlaySound(args.spellId, "alert")
end
