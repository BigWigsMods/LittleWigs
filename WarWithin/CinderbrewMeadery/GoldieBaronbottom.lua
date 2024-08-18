--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Goldie Baronbottom", 2661, 2589)
if not mod then return end
mod:RegisterEnableMob(214661) -- Goldie Baronbottom
mod:SetEncounterID(2930)
mod:SetRespawnTime(30)

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
	-- Spread the Love! is cast immediately on pull
	self:CDBar(436592, 8.2) -- Cash Cannon
	self:CDBar(436644, 16.6) -- Burning Richochet
	self:CDBar(435622, 36.1) -- Let It Hail!
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpreadTheLove(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 50.5)
end

function mod:LetItHail(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 51.0)
end

do
	local playerList = {}

	function mod:BurningRichochet(args)
		playerList = {}
		burningRichochetCount = burningRichochetCount + 1
		if burningRichochetCount % 2 == 0 then
			self:CDBar(436644, 14.6)
		else
			self:CDBar(436644, 36.4)
		end
	end

	function mod:BurningRichochetApplied(args)
		playerList[#playerList + 1] = args.destName
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		self:TargetsMessage(args.spellId, "orange", playerList, 2)
	end
end

function mod:CashCannon(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	cashCannonCount = cashCannonCount + 1
	if cashCannonCount % 2 == 0 then
		self:CDBar(args.spellId, 14.5)
	else
		self:CDBar(args.spellId, 36.4)
	end
end
