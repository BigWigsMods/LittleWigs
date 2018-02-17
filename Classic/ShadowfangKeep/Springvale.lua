
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Springvale", 764, 98)
if not mod then return end
mod:RegisterEnableMob(4278)
mod.engageId = 1071

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93687, -- Desecration
		93844, -- Empowerment
		--93736, -- Shield of the Perfidious, this ID throws errors, I couldn't get him to cast it to find the correct one
		93852, -- Word of Shame
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Desecration", 93687)
	self:Log("SPELL_CAST_START", "UnholyEmpowerment", 93844)
	--self:Log("SPELL_AURA_APPLIED", "ShieldOfThePerfidious", 93736, 93737) -- XXX What's doing the damage on players?
	self:Log("SPELL_AURA_APPLIED", "WordOfShame", 93852)
end

--[[function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end]]

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Desecration(args)
	self:Message(args.spellId, "Attention")
end

do
	local prev = 0
	function mod:UnholyEmpowerment(args)
		local t = GetTime()
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
		end
	end
end

function mod:ShieldOfThePerfidious(args)
	if self.Me(args.destGUID) then
		self:Message(args.spellId, "Personal", CL.you:format(args.spellName))
	end
end

function mod:WordOfShame(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
end
