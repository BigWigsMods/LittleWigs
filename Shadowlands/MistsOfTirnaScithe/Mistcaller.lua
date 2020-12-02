
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mistcaller", 2290, 2406)
if not mod then return end
mod:RegisterEnableMob(164501) -- Mistcaller
mod.engageId = 2392
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		336499, -- Guessing Game
		321834, -- Dodge Ball
		321828, -- Patty Cake
		326180, -- Freeze Tag
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GuessingGame", 336499)
	self:Log("SPELL_CAST_START", "DodgeBall", 321834)
	self:Log("SPELL_CAST_START", "PattyCake", 321828)
	self:Log("SPELL_CAST_START", "FreezeTag", 326180)
end

function mod:OnEngage()
	self:CDBar(321834, 7) -- Dodge Ball
	self:CDBar(321828, 14.5) -- Patty Cake
	self:CDBar(326180, 22) -- Freeze Tag
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GuessingGame(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:DodgeBall(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
			self:CDBar(args.spellId, 14.5)
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(321828, "purple", name) -- Patty Cake
		if self:Me(guid) then
			self:PlaySound(321828, "warning") -- Patty Cake
		end
	end

	function mod:PattyCake(args)
		self:GetBossTarget(printTarget, 0.1, args.sourceGUID)
		self:CDBar(args.spellId, 22)
	end
end

function mod:FreezeTag(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23)
end
