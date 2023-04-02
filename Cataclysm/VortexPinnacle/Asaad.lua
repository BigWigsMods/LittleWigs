--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Asaad", 657, 116)
if not mod then return end
mod:RegisterEnableMob(43875)
mod:SetEncounterID(1042)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		86911, -- Unstable Grounding Field
		86930, -- Supremacy of the Storm
		87622, -- Chain Lightning
		-2434, -- Skyfall Star
		87618, -- Static Cling
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "UnstableGroundingField", 86911)
	self:Log("SPELL_CAST_SUCCESS", "SupremacyOfTheStorm", 86930)
	self:Log("SPELL_CAST_START", "ChainLightning", 87622)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Summon Skyfall Star
	self:Log("SPELL_CAST_START", "StaticCling", 87618)
end

function mod:OnEngage()
	if not self:Normal() then
		self:Bar(87618, 10.7) -- Static Cling
	end
	self:Bar(-2434, 10.7, nil, 96260) -- Summon Skyfall Star
	self:CDBar(87622, 14.5) -- Chain Lightning
	self:CDBar(86911, 15.6) -- Unstable Grounding Field
	self:CDBar(86930, 25.2) -- Supremacy of the Storm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:UnstableGroundingField(args)
		-- throttle because boss applies this twice sometimes
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "green")
			self:PlaySound(args.spellId, "info")
			self:CDBar(args.spellId, 44.7)
			self:CDBar(86930, 9.6) -- Supremacy of the Storm
		end
	end
end

function mod:SupremacyOfTheStorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 44.2)
end

function mod:ChainLightning(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO pattern?
	-- pull:14.6, 21.8, 15.8, 30.4, 17.0
	-- pull:33.8, 15.8, 30.3, 17.0, 29.1, 14.6, 31.6, 17.0, 29.1, 15.8, 31.6, 23.2
	self:CDBar(args.spellId, 13.4)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 96260 then -- Summon Skyfall Star
		self:Message(-2434, "cyan", 96260, 96260)
		self:PlaySound(-2434, "alert")
		-- TODO pattern?
		-- pull:10.9, 29.2, 12.2, 34.1, 12.2
		-- pull:10.7, 26.7, 12.1, 34.0, 12.2, 34.0, 14.5, 31.6, 12.1, 34.0, 12.2, 35.2, 12.2, 30.5, 12.2, 12.2
		self:CDBar(-2434, 12.1, nil, 96260)
	end
end

function mod:StaticCling(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	-- TODO pattern?
	-- pull:10.9, 29.2, 15.8, 30.4, 17.0
	-- pull:10.7, 26.7, 15.8, 30.4, 17.0, 29.1, 15.8, 30.4, 16.9, 29.1, 15.8, 31.6, 15.8, 26.8, 15.8
	self:CDBar(args.spellId, 15.8)
end
