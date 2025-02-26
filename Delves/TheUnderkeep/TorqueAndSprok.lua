--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Torque Clankfire and Sprok", 2690)
if not mod then return end
mod:RegisterEnableMob(
	234939, -- Torque Clankfire
	234938 -- Sprok
)
mod:SetEncounterID(3106)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bossName = "Torque Clankfire and Sprok"
	L.torque_clankfire = "Torque Clankfire"
	L.sprok = "Sprok"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:GetOptions()
	return {
		-- Torque Clankfire
		1215033, -- Long Fuse Missiles
		1215090, -- Evasive Tactics
		-- Sprok
		1215084, -- Darkfuse Cocktail
		1215015, -- This One, Boss?
	}, {
		[1215033] = L.torque_clankfire,
		[1215084] = L.sprok,
	}
end

function mod:OnBossEnable()
	-- Torque Clankfire
	self:Log("SPELL_CAST_START", "LongFuseMissiles", 1215033)
	self:Log("SPELL_CAST_SUCCESS", "EvasiveTactics", 1215090)
	self:Death("TorqueClankfireDeath", 234939)

	-- Sprok
	self:Log("SPELL_CAST_START", "DarkfuseCocktail", 1215084)
	self:Log("SPELL_INTERRUPT", "DarkfuseCocktailInterrupt", 1215084)
	self:Log("SPELL_CAST_SUCCESS", "DarkfuseCocktailSuccess", 1215084)
	self:Log("SPELL_CAST_START", "ThisOneBoss", 1215015)
	self:Log("SPELL_CAST_SUCCESS", "ThisOneBossSuccess", 1215015)
	self:Death("SprokDeath", 234938)
end

function mod:OnEngage()
	self:CDBar(1215033, 6.1) -- Long Fuse Missiles
	self:CDBar(1215084, 8.5) -- Darkfuse Cocktail
	self:CDBar(1215015, 11.8) -- This One, Boss?
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Torque Clankfire

function mod:LongFuseMissiles(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 28.7)
	self:PlaySound(args.spellId, "long")
end

function mod:EvasiveTactics(args)
	-- only cast if in melee range
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:TorqueClankfireDeath()
	self:StopBar(1215033) -- Long Fuse Missiles
end

-- Sprok

function mod:DarkfuseCocktail(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:DarkfuseCocktailInterrupt()
	self:CDBar(1215084, 16.1)
end

function mod:DarkfuseCocktailSuccess(args)
	self:CDBar(args.spellId, 16.1)
end

function mod:ThisOneBoss(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ThisOneBossSuccess(args)
	self:CDBar(args.spellId, 13.4)
end

function mod:SprokDeath()
	self:StopBar(1215084) -- Darkfuse Cocktail
	self:StopBar(1215015) -- This One, Boss?
end
