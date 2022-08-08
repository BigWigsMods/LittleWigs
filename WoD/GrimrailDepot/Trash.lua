--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grimrail Depot Trash", 1208)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	81236,  -- Grimrail Technician
	164168, -- Grimrail Overseer
	80937,  -- Grom'kar Gunner
	88163,  -- Grom'kar Cinderseer
	80935,  -- Grom'kar Boomer
	82579,  -- Grom'kar Far Seer
	82597   -- Grom'kar Captain
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.grimrail_technician = "Grimrail Technician"
	L.grimrail_overseer = "Grimrail Overseer"
	L.gromkar_gunner = "Grom'kar Gunner"
	L.gromkar_cinderseer = "Grom'kar Cinderseer"
	L.gromkar_boomer = "Grom'kar Boomer"
	L.gromkar_far_seer = "Grom'kar Far Seer"
	L.gromkar_captain = "Grom'kar Captain"
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
		-- Grom'kar Cinderseer
		{176025, "SAY"}, -- Lava Wreath
		-- Grom'kar Boomer
		156301, -- Blackrock Mortar
		176127, -- Cannon Barrage
		-- Grom'kar Far Seer
		166335, -- Storm Shield
		166341, -- Thunder Zone
		-- Grom'kar Captain
		166380, -- Reckless Slash
	}, {
		[163966] = L.grimrail_technician,
		[164168] = L.grimrail_overseer,
		[166675] = L.gromkar_gunner,
		[176025] = L.gromkar_cinderseer,
		[156301] = L.gromkar_boomer,
		[166335] = L.gromkar_far_seer,
		[166380] = L.gromkar_captain,
	}
end

function mod:OnBossEnable()
	-- Grimrail Technician
	self:Log("SPELL_AURA_APPLIED", "Activating", 163966)
	self:Log("SPELL_CAST_START", "FiftyThousandVolts", 164192)
	-- Grimrail Overseer
	self:Log("SPELL_CAST_START", "Dash", 164168)
	-- Grom'kar Gunner
	self:Log("SPELL_CAST_START", "ShrapnelBlast", 166675)
	-- Grom'kar Cinderseer
	self:Log("SPELL_AURA_APPLIED", "LavaWreathApplied", 176025)
	-- Grom'kar Boomer
	self:Log("SPELL_CAST_START", "BlackrockMortar", 156301)
	self:Log("SPELL_CAST_START", "CannonBarrage", 176127)
	-- Grom'kar Far Seer
	self:Log("SPELL_CAST_START", "StormShield", 166335)
	self:Log("SPELL_CAST_START", "ThunderZone", 166341)
	-- Grom'kar Captain
	self:Log("SPELL_CAST_START", "RecklessSlash", 166380)
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

do
	local prev = 0
	function mod:ShrapnelBlast(args)
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Grom'kar Cinderseer

do
	local prev = 0
	function mod:LavaWreathApplied(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:Say(args.spellId)
				self:PersonalMessage(args.spellId)
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

-- Grom'kar Boomer

do
	local prev = 0
	function mod:BlackrockMortar(args)
		if self:MobId(args.sourceGUID) == 80935 then -- Grom'kar Boomer trash version, Nitrogg has adds that cast this spell
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "yellow")
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

function mod:CannonBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Grom'kar Far Seer

function mod:StormShield(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:ThunderZone(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Grom'kar Captain

function mod:RecklessSlash(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
