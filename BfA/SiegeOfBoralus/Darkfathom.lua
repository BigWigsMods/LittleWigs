
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hadal Darkfathom", 1822, 2134)
if not mod then return end
mod:RegisterEnableMob(128651) -- Hadal Darkfathom
mod.engageId = 2099
mod.respawnTime = 32

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		261563, -- Crashing Tide
		257882, -- Break Water
		276068, -- Tidal Surge
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "BreakWater", 257882)
	self:Log("SPELL_CAST_START", "TidalSurge", 276068)
end

function mod:OnEngage()
	self:CDBar(257882, 7) -- Break Water
	self:CDBar(261563, 13) -- Crashing Tide
	self:CDBar(276068, 24) -- Tidal Surge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 257861 then -- Crashing Tide
		self:Message2(261563, "yellow")
		self:PlaySound(261563, "alert")
		self:CDBar(261563, 17)
	end
end

function mod:BreakWater(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 26)
end

function mod:TidalSurge(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 55)
end
