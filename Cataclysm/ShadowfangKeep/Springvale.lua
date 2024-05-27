
--------------------------------------------------------------------------------
-- TODO List:
-- - The boss is bugged as of 7.3.5 and doesn't cast Shield of the Perfidious. When/if it is fixed, make the module warn about it.

-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Springvale", 33, 98)
if not mod then return end
mod:RegisterEnableMob(4278)
mod.engageId = 1071
--mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93687, -- Desecration (has better description than the ID doing damage)
		-- -2138, -- Shield of the Perfidious
		93844, -- Unholy Empowerment
		93852, -- Word of Shame
	}, {
		[93687] = "general",
		[93844] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DesecrationCast", 93687)
	self:Log("SPELL_AURA_APPLIED", "Desecration", 93691)
	self:Log("SPELL_DAMAGE", "Desecration", 93691)
	self:Log("SPELL_MISSED", "Desecration", 93691)
	--self:Log("SPELL_AURA_APPLIED", "ShieldOfThePerfidious", 0)
	self:Log("SPELL_CAST_START", "UnholyEmpowerment", 93844)
	self:Log("SPELL_AURA_APPLIED", "WordOfShame", 93852)
end

function mod:OnEngage()
	self:CDBar(93687, 9.6) -- Desecration
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:DesecrationCast(args)
	self:CDBar(args.spellId, 17.8) -- 17.8s - 19.8s
end

do
	local prev = 0
	function mod:Desecration(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:MessageOld(93687, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

do
	local prev = 0
	function mod:UnholyEmpowerment(args)
		local t = GetTime()
		if t - prev > 2 then -- adds cast this, he spawns 2 at a time
			prev = t
			self:MessageOld(args.spellId, "orange", "alarm", CL.casting:format(args.spellName))
		end
	end
end

function mod:WordOfShame(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
end

--function mod:ShieldOfThePerfidious(args)
--	if self.Me(args.destGUID) then
--		self:TargetMessageOld(args.spellId, args.destName, "blue")
--	end
--end
