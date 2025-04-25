--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Torque Clankfire and Sprok", {2681, 2690}) -- Kriegval's Rest, The Underkeep
if not mod then return end
mod:RegisterEnableMob(
	237554, -- Torque Clankfire (Kriegval's Rest)
	234939, -- Torque Clankfire (The Underkeep)
	237552, -- Sprok (Kriegval's Rest)
	234938 -- Sprok (The Underkeep)
)
mod:SetEncounterID({3140, 3106}) -- Kriegval's Rest, The Underkeep
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
	self:SetSpellRename(1215084, CL.enrage) -- Darkfuse Cocktail (Enrage)
	self:SetSpellRename(1215015, CL.frontal_cone) -- This One, Boss? (Frontal Cone)
end

function mod:GetOptions()
	return {
		-- Torque Clankfire
		1215033, -- Long Fuse Missiles
		1215090, -- Evasive Tactics
		-- Sprok
		1215084, -- Darkfuse Cocktail
		1215015, -- This One, Boss?
	},{
		[1215033] = L.torque_clankfire,
		[1215084] = L.sprok,
	},{
		[1215084] = CL.enrage, -- Darkfuse Cocktail (Enrage)
		[1215015] = CL.frontal_cone, -- This One, Boss? (Frontal Cone)
	}
end

function mod:OnBossEnable()
	-- Torque Clankfire
	self:Log("SPELL_CAST_START", "LongFuseMissiles", 1215033)
	self:Log("SPELL_CAST_SUCCESS", "EvasiveTactics", 1215090)
	self:Death("TorqueClankfireDeath", 237554, 234939)

	-- Sprok
	self:Log("SPELL_CAST_START", "DarkfuseCocktail", 1215084)
	self:Log("SPELL_INTERRUPT", "DarkfuseCocktailInterrupt", 1215084)
	self:Log("SPELL_CAST_SUCCESS", "DarkfuseCocktailSuccess", 1215084)
	self:Log("SPELL_CAST_START", "ThisOneBoss", 1215015)
	self:Log("SPELL_CAST_SUCCESS", "ThisOneBossSuccess", 1215015)
	self:Death("SprokDeath", 237552, 234938)
end

function mod:OnEngage()
	self:CDBar(1215033, 6.1) -- Long Fuse Missiles
	self:CDBar(1215084, 8.5, CL.enrage) -- Darkfuse Cocktail
	self:CDBar(1215015, 11.8, CL.frontal_cone) -- This One, Boss?
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
	self:Message(args.spellId, "red", CL.casting:format(CL.enrage))
	self:PlaySound(args.spellId, "alert")
end

function mod:DarkfuseCocktailInterrupt()
	self:CDBar(1215084, 16.1, CL.enrage)
end

function mod:DarkfuseCocktailSuccess(args)
	self:CDBar(args.spellId, 16.1, CL.enrage)
end

function mod:ThisOneBoss(args)
	self:Message(args.spellId, "orange", CL.frontal_cone)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ThisOneBossSuccess(args)
	self:CDBar(args.spellId, 13.4, CL.frontal_cone)
end

function mod:SprokDeath()
	self:StopBar(CL.enrage) -- Darkfuse Cocktail
	self:StopBar(CL.frontal_cone) -- This One, Boss?
end
