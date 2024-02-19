
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vigilant Kaathar", 1182, 1185)
if not mod then return end
mod:RegisterEnableMob(75839)
mod.engageId = 1686
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local strikeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153002, -- Holy Shield
		{153006, "FLASH"}, -- Consecrated Light
		152954, -- Sanctified Strike
		153430, -- Sanctified Ground
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HolyShield", 153002)
	self:Log("SPELL_CAST_START", "ConsecratedLight", 153006)
	self:Log("SPELL_AURA_REMOVED", "ConsecratedLightOver", 153006)
	self:Log("SPELL_CAST_START", "SanctifiedStrike", 152954)
	self:Log("SPELL_AURA_APPLIED", "SanctifiedGround", 153430)
end

function mod:OnEngage()
	strikeCount = 0
	self:CDBar(153002, 30.5) -- Holy Shield
	self:CDBar(152954, 7.3) -- Sanctified Strike -- 6s?
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, player)
		self:TargetMessageOld(153002, player, "orange", "alert", nil, nil, true)
	end
	function mod:HolyShield(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 47)
		self:Bar(153006, 7.4) -- Consecrated Light
	end
end

function mod:ConsecratedLight(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:Bar(args.spellId, self:Normal() and 12 or 8, CL.cast:format(args.spellName))
	self:Flash(args.spellId)
end

function mod:ConsecratedLightOver()
	self:CDBar(152954, self:Normal() and 6.2 or 10.2) -- Sanctified Strike
	strikeCount = 0
end

function mod:SanctifiedStrike(args)
	strikeCount = strikeCount + 1
	self:MessageOld(args.spellId, "red")
	if strikeCount < 3 then
		self:CDBar(args.spellId, 8.5)
	end
end

function mod:SanctifiedGround(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
	end
end
