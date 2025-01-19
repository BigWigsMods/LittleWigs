local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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
	self:CDBar(436592, 8.1) -- Cash Cannon
	self:CDBar(436644, 16.6) -- Burning Richochet
	if isElevenDotOne then
		self:CDBar(435622, 40.9) -- Let It Hail!
	else -- XXX remove when 11.1 is live
		self:CDBar(435622, 36.1) -- Let It Hail!
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpreadTheLove(args)
	self:Message(args.spellId, "cyan")
	if isElevenDotOne then
		self:CDBar(args.spellId, 55.6)
	else -- XXX remove when 11.1 is live
		self:CDBar(args.spellId, 50.5)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:LetItHail(args)
	self:Message(args.spellId, "yellow")
	if isElevenDotOne then
		-- cast at 100 energy, 4.5s cast time + 5s channel + 8.7s RP + 36s energy gain + 1.6s delay
		self:CDBar(args.spellId, 55.8)
	else -- XXX remove when 11.1 is live
		self:CDBar(args.spellId, 51.0)
	end
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
			if isElevenDotOne then
				self:CDBar(436644, 41.3)
			else -- XXX remove when 11.1 is live
				self:CDBar(436644, 36.4)
			end
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
	if isElevenDotOne then
		if cashCannonCount % 3 ~= 1 then -- 2, 3, 5, 6...
			self:CDBar(args.spellId, 14.6)
		else -- 4, 7...
			self:CDBar(args.spellId, 26.7)
		end
	else -- XXX remove when 11.1 is live
		if cashCannonCount % 2 == 0 then
			self:CDBar(args.spellId, 14.6)
		else
			self:CDBar(args.spellId, 36.4)
		end
	end
	self:PlaySound(args.spellId, "alert")
end
