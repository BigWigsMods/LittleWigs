
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Roltall", 1175, 887)
if not mod then return end
mod:RegisterEnableMob(75786)
mod.engageId = 1652
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153247, -- Fiery Boulder
		152940, -- Heat Wave
		{167739, "FLASH"}, -- Scorching Aura
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FieryBoulder", 153247)
	self:Log("SPELL_CAST_START", "HeatWaveInc", 152940)
	self:Log("SPELL_CAST_SUCCESS", "HeatWaveBegin", 152940)
	self:Log("SPELL_AURA_APPLIED", "ScorchingAura", 167739)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FieryBoulder(args)
	self:MessageOld(args.spellId, "orange", "warning")
end

function mod:HeatWaveInc(args)
	self:MessageOld(args.spellId, "red", "alert", CL.incoming:format(args.spellName))
end

function mod:HeatWaveBegin(args)
	self:MessageOld(args.spellId, "red")
	self:Bar(args.spellId, 8, CL.cast:format(args.spellName))
end

do
	local prev = 0 -- throttle if the player is crossing the edge of its radius multiple times (running against Heat Wave or w/e)
	function mod:ScorchingAura(args)
		if self:Me(args.destGUID) and self:Ranged() then
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:Flash(args.spellId)
				self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
			end
		end
	end
end
