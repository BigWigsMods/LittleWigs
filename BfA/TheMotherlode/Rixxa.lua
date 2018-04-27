if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rixxa Fluxflame", 1594, 2115)
if not mod then return end
mod:RegisterEnableMob(129231)
mod.engageId = 2107

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		270042, -- Agent Azerite
		259853, -- Chemical Burn
		260669, -- Propellant Blast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AgentAzerite", 270042)
	--self:Log("SPELL_CAST_SUCCESS", "ChemicalBurnSuccess", 259853) -- XXX Maybe a UNIT Event? casts 2x in rapid succession right now.
	self:Log("SPELL_AURA_APPLIED", "ChemicalBurnApplied", 259853)
	self:Log("SPELL_CAST_START", "PropellantBlast", 260669)
end

function mod:OnEngage()
	self:Bar(270042, 8) -- Agent Azerite
	self:Bar(260669, 46) -- Propellant Blast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AgentAzerite(args)
	self:Message(args.spellId, "red", nil, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long", "watchstep")
	self:CDBar(args.spellId, 8)
end

--function mod:ChemicalBurnSuccess(args)
	-- self:Bar(args.spellId, 20)
--end

do
	local playerList = mod:NewTargetList()
	function mod:ChemicalBurnApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Me(args.destGUID) or self:Dispeller("magic") then
			self:PlaySound(args.spellId, "alarm", self:Dispeller("magic") and "dispel")
		end
		self:TargetsMessage(args.spellId, "orange", playerList)
		self:Bar(args.spellId, 30) -- XXX Move to a singular event if possible
	end
end

function mod:PropellantBlast(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:CastBar(args.spellId, 5.5)
	--self:Bar(args.spellId, 8) -- XXX 3 chain casts and then a cooldown?
end
