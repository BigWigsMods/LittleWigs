
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Springvale", 764, 98)
if not mod then return end
mod:RegisterEnableMob(4278)
mod.engageId = 1071
--mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93687, -- Desecration
		93844, -- Empowerment
		-2138, -- Shield of the Perfidious
		93852, -- Word of Shame
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Desecration", 93687)
	self:Log("SPELL_CAST_START", "UnholyEmpowerment", 93844)
	--self:Log("SPELL_AURA_APPLIED", "ShieldOfThePerfidious", 93736, 93737) -- FIXME: no spells have these IDs as of 7.3.5, couldn't get him to cast it, wowhead is of no help
	self:Log("SPELL_AURA_APPLIED", "WordOfShame", 93852)
end

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
		self:TargetMessage(args.spellId, args.destName, "Personal")
	end
end

function mod:WordOfShame(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
end
