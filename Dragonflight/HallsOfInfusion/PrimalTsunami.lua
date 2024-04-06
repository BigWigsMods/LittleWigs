--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Primal Tsunami", 2527, 2511)
if not mod then return end
mod:RegisterEnableMob(
	189729, -- Primal Tsunami
	196043  -- Primalist Infuser
)
mod:SetEncounterID(2618)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local infusedGlobulesCount = 1
local tempestsFuryCount = 1
local addsKilled = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Violent Squalls
		387559, -- Infused Globules
		388424, -- Tempest's Fury
		{387504, "TANK_HEALER"}, -- Squall Buffet
		389875, -- Undertow
		-- Stage Two: Infused Waters
		388882, -- Inundate
	}, {
		[387559] = -25529, -- Stage One: Violent Swells
		[388882] = -25531, -- Stage Two: Infused Waters
	}
end

function mod:OnBossEnable()
	-- Stages
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "Submerge", 387585)
	self:Log("SPELL_AURA_REMOVED", "SubmergeOver", 387585)

	-- Stage 1
	self:Log("SPELL_CAST_START", "InfusedGlobules", 387559)
	self:Log("SPELL_CAST_START", "TempestsFury", 388424)
	self:Log("SPELL_CAST_START", "SquallBuffet", 387504)
	self:Log("SPELL_CAST_START", "Undertow", 389875)

	-- Stage 2
	self:Log("SPELL_CAST_START", "Inundate", 388882)
	self:Death("AddDeath", 196043) -- Primalist Infuser
end

function mod:OnEngage()
	infusedGlobulesCount = 1
	tempestsFuryCount = 1
	addsKilled = 0
	self:SetStage(1)
	self:CDBar(388424, 4.0, CL.count:format(self:SpellName(388424), tempestsFuryCount)) -- Tempest's Fury
	self:CDBar(387559, 8.0) -- Infused Globules
	self:CDBar(387504, 16.0) -- Squall Buffet
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:UNIT_SPELLCAST_SUCCEEDED(event, unit, _, spellId)
	if spellId == 388420 then -- Cast Away
		-- we can clean up bars a second early, this always precedes submerge
		self:StopBar(387559) -- Infused Globules
		self:StopBar(CL.count:format(self:SpellName(388424), tempestsFuryCount)) -- Tempest's Fury
		self:StopBar(387504) -- Squall Buffet
		self:UnregisterUnitEvent(event, unit)
	end
end

function mod:Submerge(args)
	self:StopBar(387559) -- Infused Globules
	self:StopBar(CL.count:format(self:SpellName(388424), tempestsFuryCount)) -- Tempest's Fury
	self:StopBar(387504) -- Squall Buffet
	self:SetStage(2)
	self:Message("stages", "cyan", CL.percent:format(60, args.spellName), args.spellId)
	self:PlaySound("stages", "long")
	self:CDBar("stages", 131.1, CL.onboss:format(args.spellName), args.spellId)
end

function mod:SubmergeOver(args)
	-- reset infusedGlobulesCount for timer purposes
	infusedGlobulesCount = 1
	self:StopBar(CL.onboss:format(args.spellName))
	self:SetStage(1)
	self:Message("stages", "cyan", CL.over:format(args.spellName), args.spellId)
	self:PlaySound("stages", "info")
	self:CDBar(388424, 7.6, CL.count:format(self:SpellName(388424), tempestsFuryCount)) -- Tempest's Fury
	self:CDBar(387559, 11.6) -- Infused Globules
	self:CDBar(387504, 19.6) -- Squall Buffet
end

-- Stage 1

function mod:InfusedGlobules(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	infusedGlobulesCount = infusedGlobulesCount + 1
	if infusedGlobulesCount % 2 == 0 then
		self:CDBar(args.spellId, 23.2)
	else
		self:CDBar(args.spellId, 8.8)
	end
end

function mod:TempestsFury(args)
	self:StopBar(CL.count:format(args.spellName, tempestsFuryCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, tempestsFuryCount))
	self:PlaySound(args.spellId, "alert")
	tempestsFuryCount = tempestsFuryCount + 1
	self:CDBar(args.spellId, 32.0, CL.count:format(args.spellName, tempestsFuryCount))
end

function mod:SquallBuffet(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 32.0)
end

function mod:Undertow(args)
	self:Message(args.spellId, "purple")
	if self:Tank() then
		-- this is only cast when the tank is out of range
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

-- Stage 2

do
	local prev = 0
	function mod:Inundate(args)
		if self:Friendly(args.sourceFlags) -- these NPCs can be mind-controlled by Priests
			or self:MobId(args.sourceGUID) ~= 196043 then -- Primalist Infuser
			return
		end
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:AddDeath(args)
	addsKilled = addsKilled + 1
	local addsNeeded = self:Mythic() and 4 or 2
	if addsKilled < addsNeeded then
		self:Message("stages", "cyan", CL.add_killed:format(addsKilled, addsNeeded), false)
		self:PlaySound("stages", "info")
	end
end
