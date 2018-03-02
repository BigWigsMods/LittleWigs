-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mage-Lord Urom", 528, 624)
if not mod then return end
--mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27655)

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{51121, "ICON", "SAY"}, -- Time Bomb
		51110, -- Arcane Explosion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TimeBomb", 51121, 59376)
	self:Log("SPELL_AURA_REMOVED", "TimeBomb", 51121, 59376)
	self:Log("SPELL_CAST_START", "ArcaneExplosion", 51110, 59377)
	self:Death("Win", 27655)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:TimeBomb(args)
	if self:Me(args.destGUID) then
		self:Say(51121)
		self:SayCountdown(51121, 6)
	end
	self:TargetMessage(51121, args.destName, "Urgent", "Alert")
	self:TargetBar(51121, 6, args.destName)
	self:PrimaryIcon(51121, args.destName)
end

function mod:TimeBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(51121)
	end
	self:StopBar(51121, args.destName)
	self:PrimaryIcon(51121)
end

function mod:ArcaneExplosion(args)
	self:Message(51110, "Attention", nil, CL.casting:format(args.spellName))
	self:Bar(51110, 8)
end
