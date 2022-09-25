if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Forgemaster Gorek", 2519, 2489)
if not mod then return end
mod:RegisterEnableMob(189478) -- Forgemaster Gorek
mod:SetEncounterID(2612)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		374635, -- Might of the Forge
		{374839, "SAY", "SAY_COUNTDOWN"}, -- Blazing Aegis
		374969, -- Forgestorm
		374533, -- Heated Swings
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "MightOfTheForge", 374635)
	self:Log("SPELL_AURA_APPLIED", "BlazingAegis", 374842)
	self:Log("SPELL_CAST_START", "Forgestorm", 374969) -- TODO on SUCCESS better?
	self:Log("SPELL_CAST_START", "HeatedSwings", 374533)
end

function mod:OnEngage()
	-- TODO these timers are all wrong
	self:Bar(374635, 2.3) -- Might of the Forge
	self:Bar(374969, 25.5) -- Forgestorm
	self:Bar(374533, 18.9) -- Heated Swings
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MightOfTheForge(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:Bar(374839, 8.3) -- Blazing Aegis
	-- TODO might of the forge bar
end

function mod:BlazingAegis(args)
	self:TargetMessage(374839, "yellow", args.destName)
	self:PlaySound(374839, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(374839)
		self:SayCountdown(374839, 3.5)
	end
end

function mod:Forgestorm(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO bar
end

function mod:HeatedSwings(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	-- TODO bar
end
