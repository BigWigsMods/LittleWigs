if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Unbound Abomination", 1841, 2158)
if not mod then return end
mod:RegisterEnableMob(133007, 134419) -- Unbound Abomination, Titan Keeper Hezrel
mod.engageId = 2123

--------------------------------------------------------------------------------
-- Locals
--

local visageRemaining = 10

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- 269301, -- Putrid Blood
		269843, -- Vile Expulsion
		269310, -- Cleansing Light
	}
end

function mod:OnBossEnable()
	-- self:Log("SPELL_CAST_SUCCESS", "PutridBlood", 269301) -- XXX Every 5 seconds, do we need anything for it?
	self:Log("SPELL_CAST_START", "VileExpulsion", 269843)
	self:Log("SPELL_CAST_START", "CleansingLight", 269310)
	self:Death("VisageDeath", 137103)
end

function mod:OnEngage()
	visageRemaining = 10
	self:Bar(269310, 7.2) -- Cleansing Light
	self:Bar(269843, 8.5) -- Vile Expulsion
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- function mod:PutridBlood(args)
	-- self:Message(args.spellId, "yellow")
	-- self:PlaySound(args.spellId, "alert")
-- end

function mod:VileExpulsion(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "watchwave")
	self:Bar(args.spellId, 15.5)
end

function mod:CleansingLight(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "long", "runin")
	self:CDBar(args.spellId, 32) -- pull:7.2, 32.8, 24.3, 37.6, 32.7
end

function mod:VisageDeath(args)
	visageRemaining = visageRemaining - 1
	self:Message("stages", "cyan", nil, CL.add_remaining:format(visageRemaining), false)
	self:PlaySound("stages", "info")
end
