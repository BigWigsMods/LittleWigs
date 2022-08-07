--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grimrail Depot Trash", 1208)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	81236, -- Grimrail Technician
	164168, -- Grimrail Overseer
	80937, -- Grom'kar Gunner
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.grimrail_technician = "Grimrail Technician"
	L.grimrail_overseer = "Grimrail Overseer"
	L.gromkar_gunner = "Grom'kar Gunner"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Grimrail Technician
		163966, -- Activating
		164192, -- 50,000 Volts
		-- Grimrail Overseer
		164168, -- Dash
		-- Grom'kar Gunner
		166675, -- Shrapnel Blast
	}, {
		[163966] = L.grimrail_technician,
		[164168] = L.grimrail_overseer,
		[166675] = L.gromkar_gunner,
	}
end

function mod:OnBossEnable()
	-- Grimrail Technician
	self:Log("SPELL_CAST_START", "Activating", 163966)
	self:Log("SPELL_CAST_START", "FiftyThousandVolts", 164192)
	-- Grimrail Overseer
	self:Log("SPELL_CAST_START", "Dash", 164168)
	-- Grom'kar Gunner
	self:Log("SPELL_CAST_START", "ShrapnelBlast", 166675)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Grimrail Technician

function mod:Activating(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:FiftyThousandVolts(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end

-- Grimrail Overseer

do
	local prev = 0
	function mod:Dash(args)
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Grom'kar Gunner

function mod:ShrapnelBlast(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end
