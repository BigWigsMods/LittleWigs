
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Millificent Manastorm", 1544, 1688)
if not mod then return end
mod:RegisterEnableMob(101976)
mod.engageId = 1847

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		201159, -- Delta Finger Laser X-treme
		201240, -- Elementium Squirrel Bomb
		201392, -- Thorium Rocket Chicken
		201572, -- Millificent's Rage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DeltaFinger", 201159)
	self:Log("SPELL_CAST_SUCCESS", "SquirrelBomb", 201240, 201432) -- normal, overloaded
	self:Log("SPELL_CAST_SUCCESS", "RocketChicken", 201392, 201438) -- normal, reinforced
	self:Log("SPELL_AURA_APPLIED", "MillificentsRage", 201572)
end

function mod:OnEngage()
	self:Bar(201159, 5) -- Delta Finger Laser X-treme
	self:CDBar(201240, 7) -- Elementium Squirrel Bomb
	self:CDBar(201392, 24) -- Thorium Rocket Chicken
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DeltaFinger(args)
	self:TargetMessage(args.spellId, args.destName, "orange")
	self:Bar(args.spellId, 8.5)
end

function mod:SquirrelBomb()
	self:Message(201240, "yellow", "Info")
	self:CDBar(201240, 18)
end

function mod:RocketChicken(args)
	self:Message(201392, "red", "Alarm")
	self:CDBar(201392, args.spellId == 201438 and 9.7 or 18)
end

function mod:MillificentsRage(args)
	self:Message(args.spellId, "cyan", "Warning")
	self:CDBar(201240, 5) -- Overloaded Squirrel Bomb
	self:CDBar(201392, 13.5) -- Reinforced Rocket Chicken
end
