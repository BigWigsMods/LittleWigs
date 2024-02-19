--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bloodmaul Slag Mines Trash", 1175)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	84978, -- Bloodmaul Enforcer
	75426, -- Bloodmaul Overseer
	75193, -- Bloodmaul Overseer
	75210 -- Bloodmaul Warder
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bloodmaul_enforcer = "Bloodmaul Enforcer"
	L.bloodmaul_overseer = "Bloodmaul Overseer"
	L.bloodmaul_warder = "Bloodmaul Warder"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Bloodmaul Enforcer
		151447, -- Crush
		-- Bloodmaul Overseer
		151697, -- Subjugate
		-- Bloodmaul Warder
		151545, -- Frightening Roar
	}, {
		[151447] = L.bloodmaul_enforcer,
		[151697] = L.bloodmaul_overseer,
		[151545] = L.bloodmaul_warder,
	}
end

function mod:OnBossEnable()
	-- Bloodmaul Enforcer
	self:Log("SPELL_CAST_START", "Crush", 151447)

	-- Bloodmaul Overseer
	self:Log("SPELL_CAST_START", "Subjugate", 151697)

	-- Bloodmaul Warder
	self:Log("SPELL_CAST_START", "FrighteningRoar", 151545)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Bloodmaul Enforcer

do
	local prev = 0
	function mod:Crush(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Bloodmaul Overseer

function mod:Subjugate(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Bloodmaul Warder

do
	local prev = 0
	function mod:FrighteningRoar(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		-- also cast by this NPC when fighting elementals, so add a range check
		if unit and self:UnitWithinRange(unit, 40) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(args.spellId, "red", CL.casting:format(args.spellName))
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end
