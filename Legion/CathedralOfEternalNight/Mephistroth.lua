if not IsTestBuild() then return end -- XXX dont load on live
--------------------------------------------------------------------------------
-- TODO List:
-- - Demonic Upheaval was missing debuffs in logs?
-- - P2 stuff
-- - Timer for 2nd P2
-- - Mythic Abilities

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mephistroth", 1146, 1878)
if not mod then return end
mod:RegisterEnableMob(116944)
mod.engageId = 2039

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		233155, -- Carrion Swarm
		--233196, -- Demonic Upheaval
		{234830, "PROXIMITY"}, -- Dark Solitude
		233206, -- Shadow Fade
	},{
		[233155] = -14949,
		[233206] = -14950,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3", "boss4", "boss5")
	self:Log("SPELL_CAST_START", "CarrionSwarm", 233155)
	self:Log("SPELL_CAST_START", "DarkSolitude", 234830)
	self:Log("SPELL_AURA_APPLIED", "ShadowFade", 233206)
	self:Log("SPELL_AURA_REMOVED", "ShadowFadeRemoved", 233206)
end

function mod:OnEngage()
	phase = 1
	self:OpenProximity(234830, 8)

	self:Bar(234830, 8.2) -- Dark Solitude
	self:Bar(233155, 15.6) -- Carrion Swarm
	self:Bar(233206, 39.9) -- Shadow Fade
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 234283 then -- Expel Shadows
		self:Message(233206, "Attention", "Warning", 234283)
		local timeLeft = self:BarTimeLeft(233206)
		local newTime = timeLeft + 7.5
		self:Bar(233206, newTime <= 30 and newTime or 30)
	end
end

function mod:CarrionSwarm(args)
	self:Message(args.spellId, "Attention", "Alarm")
	if self:BarTimeLeft(233206) > 18.2 then
		self:Bar(args.spellId, 18.2)
	end
end

function mod:DarkSolitude(args)
	self:Message(args.spellId, "Attention", "Alarm")
	if self:BarTimeLeft(233206) > 9 then
		self:CDBar(args.spellId, 9)
	end
end

function mod:ShadowFade(args)
	phase = 2
	self:Message(args.spellId, "Positive", "Long")
	self:Bar(args.spellId, 30) -- Update time with Expel Shadows
end

function mod:ShadowFadeRemoved(args)
	phase = 1
	self:Message(args.spellId, "Positive", "Long", CL.removed:format(args.spellName))
	self:Bar(args.spellId, 80) -- XXX Assumed
	self:Bar(234830, 7.8) -- Dark Solitude
	self:Bar(233155, 15) -- Carrion Swarm
end
