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
		259022, -- Agent Azerite
		259853, -- Chemical Burn
		260669, -- Propellant Blast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AgentAzerite", 259022)
	--self:Log("SPELL_CAST_SUCCESS", "ChemicalBurnSuccess", 259853)
	self:Log("SPELL_AURA_APPLIED", "ChemicalBurnApplied", 259853)
	self:Log("SPELL_CAST_START", "PropellantBlast", 260669)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AgentAzerite(args)
	self:Message(args.spellId, "red", nil, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long", "watchstep")
end

--function mod:ChemicalBurnSuccess(args)
	-- self:Bar(args.spellId, 20)
--end

do
	local playerList = mod:NewTargetList()
	function mod:ChemicalBurnApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Dispeller("magic") then
			if #playerList == 1 then
				self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "orange")
				self:PlaySound(args.spellId, "alarm", "dispel")
			end
		else
			if #playerList == 1 then
				self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "orange")
			end
			if self:Me(args.destGUID) then
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

function mod:PropellantBlast(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
end
