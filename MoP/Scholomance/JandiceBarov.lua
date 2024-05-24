--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Jandice Barov", 1007, 663)
if not mod then return end
mod:RegisterEnableMob(59184) -- Jandice Barov
mod:SetEncounterID(1427)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local whirlOfIllusionCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		114062, -- Wondrous Rapidity
		-5535, -- Whirl of Illusion
		114059, -- Gravity Flux
	}, {
		[114059] = CL.heroic, -- Gravity Flux (Heroic)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "WondrousRapidity", 114062)
	self:Log("SPELL_AURA_APPLIED", "WondrousRapidityApplied", 114062)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Whirl of Illusion, Gravity Flux
end

function mod:OnEngage()
	whirlOfIllusionCount = 1
	self:SetStage(1)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:CDBar(114062, 6.1) -- Wondrous Rapidity
	if not self:Normal() then
		self:CDBar(114059, 17.2) -- Gravity Flux
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0

	function mod:WondrousRapidity(args)
		prev = args.time
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alarm")
		if self:Normal() then
			self:CDBar(args.spellId, 21.8)
		else -- Heroic
			self:CDBar(args.spellId, 31.5)
		end
	end

	function mod:WondrousRapidityApplied(args)
		-- immediately after Whirl of Illusion ends she can instant cast this ability with
		-- no SPELL_CAST_START (and sometimes with no SPELL_CAST_SUCCESS), so show the alert
		-- with an adjusted timer on SPELL_AURA_APPLIED if we didn't get the SPELL_CAST_START.
		if args.time - prev > 2 then
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
			if self:Normal() then
				self:CDBar(args.spellId, 20.3)
			else -- Heroic
				self:CDBar(args.spellId, 30.0)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 113808 then -- Whirl of Illusion
		-- this doesn't affect the CD of Wondrous Rapidity like it does for Gravity Flux
		self:StopBar(114059) -- Gravity Flux
		self:SetStage(2)
		local percent = whirlOfIllusionCount == 1 and 66 or 33
		self:Message(-5535, "cyan", CL.percent:format(percent, self:SpellName(-5535)))
		self:PlaySound(-5535, "long")
		whirlOfIllusionCount = whirlOfIllusionCount + 1
	elseif spellId == 114059 then -- Gravity Flux
		self:Message(spellId, "orange")
		self:PlaySound(spellId, "alarm")
		self:CDBar(spellId, 31.5)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	-- the boss frame goes away during Stage 2, use this to detect when the boss returns to start Stage 1 again
	if self:GetStage() == 2 and self:GetBossId(59184) and UnitExists("boss1") then -- Jandice Barov
		self:SetStage(1)
		self:Message(-5535, "green", CL.over:format(self:SpellName(-5535))) -- Whirl of Illusion
		self:PlaySound(-5535, "info")
		if not self:Normal() then
			self:CDBar(114059, 10.4) -- Gravity Flux
		end
	end
end
