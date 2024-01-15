--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Forgemaster Gorek", 2519, 2489)
if not mod then return end
mod:RegisterEnableMob(189478) -- Forgemaster Gorek
mod:SetEncounterID(2612)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local mightOfTheForgeCount = 0

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
	self:Log("SPELL_CAST_SUCCESS", "BlazingAegisStart", 374842)
	self:Log("SPELL_AURA_APPLIED", "BlazingAegis", 374842)
	self:Log("SPELL_AURA_REMOVED", "BlazingAegisRemoved", 374842)
	self:Log("SPELL_CAST_SUCCESS", "Forgestorm", 374969)
	self:Log("SPELL_CAST_START", "HeatedSwings", 374533)
end

function mod:OnEngage()
	mightOfTheForgeCount = 0
	self:Bar(374635, 3.6, CL.count:format(self:SpellName(374635), 1)) -- Might of the Forge (1)
	self:Bar(374839, 12.1) -- Blazing Aegis
	self:CDBar(374533, 20.5) -- Heated Swings
	self:CDBar(374969, 29.5) -- Forgestorm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MightOfTheForge(args)
	mightOfTheForgeCount = mightOfTheForgeCount + 1
	self:StopBar(CL.count:format(args.spellName, mightOfTheForgeCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, mightOfTheForgeCount))
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 30.4, CL.count:format(args.spellName, mightOfTheForgeCount + 1))
	-- Might of the Forge is what starts the 30.4s cycle for all other abilities
	-- so if this is delayed we should adjust other timers
	if mightOfTheForgeCount == 1 then
		self:Bar(374839, {8.3, 12.1}) -- Blazing Aegis
		self:CDBar(374533, {16.6, 20.5}) -- Heated Swings
		self:CDBar(374969, {25.2, 29.5}) -- Forgestorm
	else
		self:Bar(374839, {8.3, 30.4}) -- Blazing Aegis
		self:CDBar(374533, {15.8, 30.4}) -- Heated Swings
		self:CDBar(374969, {24.3, 30.4}) -- Forgestorm
	end
end

do
	local playerList = {}

	function mod:BlazingAegisStart(args)
		if self:Mythic() then
			playerList = {}
		end
		self:Bar(374839, 30.4)
	end

	function mod:BlazingAegis(args)
		if self:Mythic() then
			-- on mythic this "bounces" to 2 additional players
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(374839, "yellow", playerList, 3)
			self:PlaySound(374839, "alert", nil, playerList)
		else
			self:TargetMessage(374839, "yellow", args.destName)
			self:PlaySound(374839, "alert", nil, args.destName)
		end
		if self:Me(args.destGUID) then
			self:Say(374839, nil, nil, "Blazing Aegis")
			self:SayCountdown(374839, 3.5)
		end
	end

	function mod:BlazingAegisRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(374839)
		end
	end
end

function mod:Forgestorm(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.4)
end

function mod:HeatedSwings(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.4)
end
